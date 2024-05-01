import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushnotification/Screens/login.dart';
import 'package:pushnotification/Screens/login_cubit.dart';
import 'package:pushnotification/Screens/login_state.dart';

class StateLog extends StatelessWidget {
  const StateLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is StringLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StringNew) {
             if (state.data == 'User authenticated') {
              //return MoviesScreen(); // Muestra la pantalla de películas
              return const Center(child: Text("Congratulations"));
            } else {
              return Center(child: Text(state.data)); // Muestra el mensaje de autenticación
            }
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(emailController: 
            TextEditingController(),
            passwordController: TextEditingController(),)),
          ).then((value) {
            if (value != null && value is Map<String, String>) {
              String email = value['email'] ?? '';
              String password = value['password'] ?? '';
              context.read<LoginCubit>().authentication(email, password);
            }
          });
        },
       child: const Icon(Icons.account_circle),
      ),
    );
  }
}
