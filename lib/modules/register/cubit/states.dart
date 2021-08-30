//import 'package:flutter_app/models/_app/Register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  // final RegisterModel RegisterModel;

  // RegisterSuccessState(this.RegisterModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
class  CreateUserSuccessState extends RegisterStates {
  // final RegisterModel RegisterModel;

  // RegisterSuccessState(this.RegisterModel);
}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState (this.error);
}