import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/profile/cover_image.dart';
import 'package:social_app/modules/profile/profile_image.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/profile_components.dart';

import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;
        var cubit = HomeCubit.get(context);
        var userModel = HomeCubit.get(context).userModel;
        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 220,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                InkWell(
                                     onTap: () {
                                  navigateTo(context, CoverImage());
                                },
                                  child: Container(
                                    height: 190,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverImage == null
                                            ? NetworkImage("${userModel.cover}")
                                            : FileImage(coverImage),
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.grey.withOpacity(0.7),
                                  child: IconButton(
                                    splashRadius: 20,
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      navigateTo(context, CoverImage());
                                    },
                                  ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context, ProfileImage());
                                },
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    radius: 47,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage("${userModel.image}")
                                        : FileImage(profileImage),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: .1,
                                  end: .1,
                                ),
                                child: CircleAvatar(
                                  radius: 19.0,
                                  backgroundColor: Colors.grey.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      bottom: 3.0,
                                      end: 2.0,
                                    ),
                                    child: IconButton(
                                      splashRadius: 19,
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        navigateTo(context, ProfileImage());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${userModel.name}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "${userModel.bio}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    BottomNavigationBar(
                      onTap: (profileIndex) {
                        cubit.changeProfileScreens(profileIndex);
                      },
                      currentIndex: cubit.currentButton,
                      elevation: 0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.people_alt_sharp,
                              size: 30,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "5K",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  "followers",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person_add,
                              size: 30,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "500",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  "following",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )),
                        BottomNavigationBarItem(
                            icon: Icon(
                              IconBroken.Plus,
                              size: 30,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "10",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  " posts",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 0,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: cubit.profileScreens[cubit.currentButton],
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        );
      },
    );
  }
}
