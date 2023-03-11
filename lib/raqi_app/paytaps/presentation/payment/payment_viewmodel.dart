
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/paytaps/domain/ext.dart';
import 'package:raqi/raqi_app/paytaps/domain/network/requests/paytabs_payment_request.dart';
import 'package:raqi/raqi_app/paytaps/domain/services/paytabs_service.dart';
import 'package:raqi/raqi_app/paytaps/presentation/payment/payment_states.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class PaymentViewModel {
  PayTabsService _payTabsService = PayTabsService();

  // makePayTabsPayment(double amount,String cartId) {
  //   FlutterPaytabsBridge.startPaymentWithSavedCards(
  //     _payTabsService.configPayment(
  //         payTabsPaymentRequest: PayTabsPaymentRequest(amount, 'USD', 'AE'),
  //         cartId : cartId,
  //         context:
  //     ),
  //         false,
  //     (event) {
  //       if (event["status"] == "success") {
  //         var transactionDetails = event["data"];
  //         if (transactionDetails["isSuccess"]) {
  //
  //         } else {
  //
  //         }
  //       } else if (event["status"] == "error") {
  //
  //       } else if (event["status"] == "event") {}
  //     },
  //   );
  // }

  String minEarning = "" ;
  startCardPayment(double amount, String cartId,context){
    FlutterPaytabsBridge.startCardPayment(
        _payTabsService.configPayment(payTabsPaymentRequest: PayTabsPaymentRequest(amount, 'SAR', 'SA'), cartId : cartId,context: context), (event) {

        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);

          if (transactionDetails["isSuccess"]) {
            if(transactionDetails["cartAmount"] == "10.00"){
              minEarning = "420";
              FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
              showToast(text: "مبارك, تم شحن 420 دقيقة", state: ToastStates.SUCCESS);
            }
            if(transactionDetails["cartAmount"] == "35.00"){
              minEarning = "1680";
              FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
              showToast(text: "مبارك, تم شحن 1680 دقيقة", state: ToastStates.SUCCESS);
            }
            if(transactionDetails["cartAmount"] == "70.00"){
              minEarning = "3360";
              FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
              showToast(text: "مبارك, تم شحن 3360 دقيقة", state: ToastStates.SUCCESS);
            }
            FirebaseFirestore.instance.collection("payments").add({
              'amount': transactionDetails["cartAmount"],
              'dateTime': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
            });
            print(transactionDetails["cartAmount"]);
            print(minEarning);
          } else {
            showToast(text: "حدث خطأ ما, حاول لاحقا", state: ToastStates.ERROR);
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }

    });
  }

  startApplePayment(double amount, String cartId,context){
    FlutterPaytabsBridge.startApplePayPayment(_payTabsService.configApple(payTabsPaymentRequest: PayTabsPaymentRequest(amount, 'SAR', 'SA'), cartId: cartId, context: context), (event) {

          if (event["status"] == "success") {
            // Handle transaction details here.
            var transactionDetails = event["data"];


            if (transactionDetails["isSuccess"]) {
              if(transactionDetails["cartAmount"] == "10.00"){
                minEarning = "420";
                FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
                showToast(text: "مبارك, تم شحن 420 دقيقة", state: ToastStates.SUCCESS);
              }
              if(transactionDetails["cartAmount"] == "35.00"){
                minEarning = "1680";
                FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
                showToast(text: "مبارك, تم شحن 1680 دقيقة", state: ToastStates.SUCCESS);
              }
              if(transactionDetails["cartAmount"] == "70.00"){
                minEarning = "3360";
                FirebaseFirestore.instance.collection("students").doc(RaqiCubit.get(context).userModel!.uId).update({'minutes' : minEarning});
                showToast(text: "مبارك, تم شحن 3360 دقيقة", state: ToastStates.SUCCESS);
              }
              print(transactionDetails["cartAmount"]);
              print(minEarning);
            }

            print(transactionDetails);
          } else if (event["status"] == "error") {
            // Handle error here.
          } else if (event["status"] == "event") {
            // Handle events here.
          }

    });
  }





}
