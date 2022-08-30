abstract class RaqiLoginStates {}

class RaqiLoginInitialState extends RaqiLoginStates {}
class RaqiLoginLoadingState extends RaqiLoginStates {}
class RaqiLoginSuccessState extends RaqiLoginStates {}
class RaqiChangeCountrySuccessState extends RaqiLoginStates {}
class RaqiLoginErrorState extends RaqiLoginStates {
  final String error ;
  RaqiLoginErrorState(this.error);
}

class RaqiChangePasswordVisibilityState extends RaqiLoginStates {}