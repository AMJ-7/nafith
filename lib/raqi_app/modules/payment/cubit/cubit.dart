import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/models/first_token.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/states.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';
import 'package:raqi/raqi_app/shared/network/dio.dart';

class PaymentCubit extends Cubit<PaymentStates>{
  PaymentCubit() : super(PaymentInitState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  FirstToken? firstToken;
  Future getFirstToken(int price , String firstName , String lastName , String email , String phone)async{
    DioHelperPayment.postData(url: 'auth/tokens', data: {'api_key' : PaymobApiKey})
        .then((value) {
          PaymobToken = value.data['token'];
          print('First Token : ${PaymobToken}');
          getOrderId(price, firstName, lastName, email, phone);
          emit(PaymentSuccessState());
    })
        .catchError((error){
          emit(PaymentErrorState(error));

    });
  }

  Future getOrderId(int price , String firstName , String lastName , String email , String phone)async{
    DioHelperPayment.postData(url: 'ecommerce/orders',
        data: {
          'auth_token' : PaymobToken,
          'delivery_needed' : 'false',
          "amount_cents": price,
          "currency": "EGP",
          "items" : []
    }
    ).then((value) {
      PaymobOrderId = value.data['id'].toString();
      print('Order ID : ${PaymobOrderId}');
      getFinalTokenCard(price, firstName, lastName, email, phone);
      emit(PaymentOrderIdSuccessState());

    })
        .catchError((error){
      emit(PaymentOrderIdErrorState(error));

    });
  }

  Future getFinalTokenCard(int price , String firstName , String lastName , String email , String phone)async{
    DioHelperPayment.postData(url: 'acceptance/payment_keys',
        data: {
          "auth_token": PaymobToken,
          "amount_cents": price*100,
          "expiration": 36000,
          "order_id": PaymobOrderId,
          "billing_data": {
            "apartment": "NA",
            "email": email,
            "floor": "NA",
            "first_name": firstName,
            "street": "NA",
            "building": "NA",
            "phone_number": lastName,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": firstName.split(" ").last,
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": IntegrationIDCard,
          "lock_order_when_paid": "false"
        }
    ).then((value) {
      PaymobFinalToken = value.data['token'].toString();
      print('Final Token Card : ${PaymobFinalToken}');
      emit(PaymentRequestTokenSuccessState());

    })
        .catchError((error){
      emit(PaymentRequestTokenErrorState(error.toString()));
      print(error);

    });
  }
}