abstract class PaymentStates{}

class PaymentInitState extends PaymentStates{}

class PaymentSuccessState extends PaymentStates{}
class PaymentErrorState extends PaymentStates{
  String error;
  PaymentErrorState(this.error);
}

class PaymentOrderIdSuccessState extends PaymentStates{}
class PaymentOrderIdErrorState extends PaymentStates{
  String error;
  PaymentOrderIdErrorState(this.error);
}

class PaymentRequestTokenSuccessState extends PaymentStates{}
class PaymentRequestTokenErrorState extends PaymentStates{
  String error;
  PaymentRequestTokenErrorState(this.error);
}