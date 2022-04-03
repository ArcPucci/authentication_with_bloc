import 'package:auth_with_bloc/bloc/login/login_cubit.dart';
import 'package:auth_with_bloc/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Авторизация"),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<LoginCubit, LoginState>(
          listener: _loginListener,
          child: BlocBuilder<LoginCubit, LoginState>(
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
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<LoginCubit>()
                              .login(_controller1.text, _controller2.text);
                        }
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Еще нет аккаунта?"),
                    )
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

  void _loginListener (BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            username: _controller1.text,
            password: _controller2.text,
          ),
        ),
      );
    } else if (state is LoginFailed) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Container(color: Colors.white, child: Text(state.error)));
        },
      );
    }
  }
}
