
abstract class RaqiSignupStates {}

class RaqiSignupInitialState extends RaqiSignupStates {}
class RaqiSignupLoadingState extends RaqiSignupStates {}
class RaqiSignupSuccessState extends RaqiSignupStates {}
class RaqiSignupErrorState extends RaqiSignupStates {
  final String error ;
  RaqiSignupErrorState(this.error);
}

class RaqiCreateUserSuccessState extends RaqiSignupStates {}
class RaqiCreateUserErrorState extends RaqiSignupStates {
  final String error ;
  RaqiCreateUserErrorState(this.error);
}

class RaqiChangePasswordVisibilitySignupState extends RaqiSignupStates {}

class RaqiChangeCheckBoxSignupState extends RaqiSignupStates {}
class RaqiChangeRadioSignupState extends RaqiSignupStates {}

class RaqiChangeCountrySuccessState extends RaqiSignupStates {}

class RaqiVerfiyPhoneSuccessState extends RaqiSignupStates {}