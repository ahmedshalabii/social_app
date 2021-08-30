import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailContorller = TextEditingController();
  TextEditingController passwordContorller = TextEditingController();
  bool _passwordVisible;
  @override
  void initState() => _passwordVisible = true;

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState)
            showToast(text: state.error.toString(), state: ToastStates.ERROR);
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              HomeCubit.get(context).getUserData();
              showToast(text: "Wellcome ", state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayout()),
                  (route) => false);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.deepOrange),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                      child: Text(
                        "Please Enter Your Email Address and Password",
                        maxLines: 1,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      controller: emailContorller,
                      type: TextInputType.emailAddress,
                      label: "Email Address",
                      prefix: Icons.email_sharp,
                      validate: (value) {
                        if (value.isEmpty) {
                          return "please enter your Email Address";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: passwordContorller,
                      type: TextInputType.text,
                      label: "Password",
                      prefix: Icons.lock_sharp,
                      validate: (value) {
                        if (value.isEmpty) {
                          return "please enter your Password";
                        }
                      },
                      suffix: _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      isPassword: !_passwordVisible,
                      onSubmit: (v) {
                        if (formKey.currentState.validate()) {
                          // LoginCubit.get(context).userLogin(
                          //     email: emailContorller.text,
                          //     password: passwordContorller.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      builder: (context) => defaultButton(
                          function: () {
                          HomeCubit.get(context).getUserData();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeLayout()),
                                (route) => false);

                            if (formKey.currentState.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailContorller.text,
                                  password: passwordContorller.text);
                            }
                          },
                          text: "LOGIN"),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You Don't Have Account?",
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.green)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                  (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Register",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  )),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
