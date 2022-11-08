abstract class LoginStates{}
class LoginInit extends LoginStates{}
class LoginChangePasswordVisibility extends LoginStates{}

class MovieLoginLoading extends LoginStates{}
class MovieLoginSuccess extends LoginStates{
  final String uId;

  MovieLoginSuccess(this.uId);
}
class MovieLoginError extends LoginStates{
  final error;

  MovieLoginError(this.error);
}