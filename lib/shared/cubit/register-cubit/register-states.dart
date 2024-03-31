class RegisterStates{}
class RegisterinitState extends RegisterStates{}
class RegisterloadingState extends RegisterStates{}
class RegistersucessState extends RegisterStates{}
class RegistererrorState extends RegisterStates{
  late final String error;
  RegistererrorState(this.error);
}

class CreatesucessState extends RegisterStates{}
class CreateerrorState extends RegisterStates{
  late final String error;
  CreateerrorState(this.error);
}

