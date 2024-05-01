import 'package:bloc/bloc.dart';
import 'package:pushnotification/Screens/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(StringLoading());

  void authentication(String usuario, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (usuario == "adriana@gmail.com" && password == "123") {
      await prefs.setBool('isAuthenticated', true);
      print('AQUI');
      emit(const StringNew(data: 'User authenticated'));
    } else {
      await prefs.setBool('isAuthenticated', false);
      emit(const StringNew(data: 'Authentication failed'));
    }
  }
}