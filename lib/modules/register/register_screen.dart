import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailContorller = TextEditingController();

  var passwordContorller = TextEditingController();
  var phoneContorller = TextEditingController();
  var nameContorller = TextEditingController();


  bool _passwordVisible1;

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _passwordVisible1 = false;

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is CreateUserSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
              (route) => false);
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
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
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        defaultFormField(
                          // onSubmit: (v) {
                          //   if (formKey.currentState.validate()) {
                          //     // LoginCubit.get(context).userLogin(
                          //     //     email: emailContorller.text,
                          //     //     password: passwordContorller.text);
                          //   }
                          // },
                          controller: nameContorller,
                          type: TextInputType.text,
                          label: "Name",
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your Name";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          // onSubmit: (v) {
                          //   if (formKey.currentState.validate()) {
                          //     // LoginCubit.get(context).userLogin(
                          //     //     email: emailContorller.text,
                          //     //     password: passwordContorller.text);
                          //   }
                          // },
                          controller: emailContorller,
                          type: TextInputType.emailAddress,
                          label: "Email Address",
                          prefix: Icons.email_sharp,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your Email Address";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          // onSubmit: (v) {
                          //   if (formKey.currentState.validate()) {
                          //     // LoginCubit.get(context).userLogin(
                          //     //     email: emailContorller.text,
                          //     //     password: passwordContorller.text);
                          //   }
                          // },
                          isPassword: !_passwordVisible1,
                          controller: passwordContorller,
                          type: TextInputType.text,
                          label: "Password",
                          prefix: Icons.lock_sharp,
                          suffix: _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your Password";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          // onSubmit: (v) {
                          //   if (formKey.currentState.validate()) {
                          //     // LoginCubit.get(context).userLogin(
                          //     //     email: emailContorller.text,
                          //     //     password: passwordContorller.text);
                          //   }
                          // },
                          controller: phoneContorller,
                          type: TextInputType.number,
                          label: "Phone Number",
                          prefix: Icons.call,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your Phone Number";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  
                                  if (formKey.currentState.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailContorller.text,
                                        password: passwordContorller.text,
                                        name: nameContorller.text,
                                        phone: phoneContorller.text);
                                  }
                                },
                                text: "REGISTER"),
                            fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don You Have Account?",
                                style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.w400,color: Colors.green)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top:5.0),
                                  child: Text("LOGIN",
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
