abstract class PaymobStates{}

class PaymobInitState extends PaymobStates{}

class PaymobSuccessState extends PaymobStates{}
class PaymobErrorState extends PaymobStates{
  String error;
  PaymobErrorState(this.error);
}

class PaymobOrderIdSuccessState extends PaymobStates{}
class PaymobOrderIdErrorState extends PaymobStates{
  String error;
  PaymobOrderIdErrorState(this.error);
}

class PaymobRequestTokenSuccessState extends PaymobStates{}
class PaymobRequestTokenErrorState extends PaymobStates{
  String error;
  PaymobRequestTokenErrorState(this.error);
}

class RaqiGetCoupons extends PaymobStates {}

class RaqiFirstPakka extends PaymobStates {}
class RaqiSecPakka extends PaymobStates {}
class RaqiThirdPakka extends PaymobStates {}
