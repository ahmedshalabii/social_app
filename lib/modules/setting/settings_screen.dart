import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  TextEditingController bioController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var userCubit = HomeCubit.get(context).userModel;
        nameController.text = userCubit.name;
        bioController.text = userCubit.bio;
        passwordController.text = userCubit.password;
        phoneController.text = userCubit.phone;
        return ConditionalBuilder(
            condition: userCubit != null,
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        icon: Icon(IconBroken.Tick_Square,
                            size: 30, color: defaultColor),
                        onPressed: () {
                          cubit.updateUser(
                              password: passwordController.text,
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text);
                        })
                  ],
                ),
                body: SingleChildScrollView(
                  child: Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,  " + "${userCubit.name}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        defaultFormField(
                            controller: bioController,
                            type: TextInputType.text,
                            validate: (String v) {
                              if (v.isEmpty) {
                                return 'bio must not be Empty';
                              }
                            },
                            label: "Bio",
                            prefix: IconBroken.Info_Circle),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (String v) {
                              if (v.isEmpty) {
                                return 'name must not be Empty';
                              }
                            },
                            label: "name",
                            prefix: IconBroken.User),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String v) {
                              if (v.isEmpty) {
                                return 'Password must not be Empty';
                              }
                            },
                            label: "Password",
                            prefix: IconBroken.Lock),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String v) {
                              if (v.isEmpty) {
                                return 'Phone must not be Empty';
                              }
                            },
                            label: "Phone Number",
                            prefix: IconBroken.Call),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            function: () {
                              cubit.logOut(context);
                              
                            },
                            text: "Log out")
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (context) =>
                Scaffold(appBar: AppBar(), body: CircularProgressIndicator()));
      },
    );
  }
}
