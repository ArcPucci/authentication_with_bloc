import 'dart:developer';

import 'package:auth_with_bloc/bloc/login/login_cubit.dart';
import 'package:auth_with_bloc/bloc/registration/registration_bloc.dart';
import 'package:auth_with_bloc/screens/login_screen.dart';
import 'package:auth_with_bloc/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: _registrationListener,
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Username",
                        labelText: "Username",
                      ),
                      controller: _controller1,
                      validator: _emptyValidator,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        labelText: "Password",
                      ),
                      controller: _controller2,
                      validator: _emptyValidator,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log(_controller1.text);
                        if (_formKey.currentState!.validate()) {
                          log(_controller2.text);
                          context.read<RegistrationBloc>().add(
                                RegisterEvent(
                                  username: _controller1.text,
                                  password: _controller2.text,
                                ),
                              );
                        }
                      },
                      child: const Text("Register"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: LoginCubit(),
                              child: LoginScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text("Уже есть аккаунт?"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String? _emptyValidator(String? value) {
    if (value == null) return "can't be null";
    if (value.isEmpty) return "can't be empty";
    if (value.length < 8) return "name is too short";
    if (value.contains(' ')) return "incorrect name";
    return null;
  }

  void _registrationListener(BuildContext context, RegistrationState state) {
    if (state is RegistrationSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            username: _controller1.text,
            password: _controller2.text,
          ),
        ),
      );
    } else if (state is RegistrationFailed) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child:
                  Container(color: Colors.white, child: Text(state.message)));
        },
      );
    }
  }
}
