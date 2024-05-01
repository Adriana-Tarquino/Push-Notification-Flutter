import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushnotification/Screens/block_build.dart';
import 'package:pushnotification/Screens/login_cubit.dart';
import 'package:pushnotification/api/firebase_api.dart';
import 'firebase_options.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:permission_handler/permission_handler.dart';
  
final navigatorkey = GlobalKey<NavigatorState>();
Future<void> main() async {
    // Solicitar permiso de notificaciones si es necesario
  // var notificationStatus = await Permission.notification.status;
  // if (!notificationStatus.isGranted) {
  //   await Permission.notification.request();
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAnalytics().logAppOpen();
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MoviesScreen(),
      //home: LoginScreen(),
      //home: LoginScreenAut(),
      home: BlocProvider(
        create: (context) => LoginCubit(),
        // child: const StateLog(),
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // El usuario ha iniciado sesión correctamente, redirige a la página principal
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Error al iniciar sesión: $e');
      // Manejo de errores, muestra un mensaje al usuario o realiza otra acción según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(email, password),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
