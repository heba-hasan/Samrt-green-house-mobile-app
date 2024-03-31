class LoginStates{}
class LogininitState extends LoginStates{}
class LoginloadingState extends LoginStates{}
class LoginsucessState extends LoginStates{
  final String ?uid;
  LoginsucessState(this.uid);
}
class LoginerrorState extends LoginStates{
  late final String error;
  LoginerrorState(this.error);
}
class Hideshowpass extends LoginStates{}