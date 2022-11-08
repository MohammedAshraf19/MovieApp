abstract class RegisterStates{}
class RegisterInit extends RegisterStates{}
class RegisterChangePasswordVisibility extends RegisterStates{}

class MovieRegisterLoading extends RegisterStates{}
class MovieCreateUserError extends RegisterStates{
  final error;

  MovieCreateUserError(this.error);
}
class MovieCreateUserSuccess extends RegisterStates{
  final String uId;
  MovieCreateUserSuccess({
    required this.uId,
  });
}
