
abstract class LoginState  {
  const LoginState();

  List<Object> get props => [];
}

class StringLoading extends LoginState {}

class StringNew extends LoginState {
  final String data;

  const StringNew({required this.data});

}
