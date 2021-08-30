import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileImage = HomeCubit.get(context).profileImage;
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile Picture"),
              
              actions: [
                if (profileImage != null)
                  IconButton(
                    icon: Icon(IconBroken.Tick_Square, size: 35),
                    onPressed: () {
                      cubit.uploadProfileImage(
                          name: cubit.userModel.name,
                          phone: cubit.userModel.phone,
                          bio: cubit.userModel.bio,
                          password: cubit.userModel.password);
                    },
                  ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                  Center(
                  
                    child: 
                    
                    Card(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: profileImage == null
                                ? NetworkImage("${cubit.userModel.image}")
                                : FileImage(profileImage),
                          ),
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: 3.0,
                                end: 2.0,
                              ),
                              child: IconButton(
                                splashRadius: 19,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
