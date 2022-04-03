import 'package:auth_with_bloc/bloc/login/login_cubit.dart';
import 'package:auth_with_bloc/bloc/registration/registration_bloc.dart';
import 'package:auth_with_bloc/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
        ],
        child: RegistrationScreen(),
      ),
    );
  }
}
