import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/setting/settings_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is NewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                  icon: Icon(IconBroken.Notification), onPressed: () {}),
              IconButton(icon: Icon(IconBroken.Search), onPressed: () {}),
              IconButton(
                  icon: Icon(IconBroken.Setting),
                  onPressed: () {
                    if(cubit.userModel!=null)
                    
                    navigateTo(context, SettingScreen());
                  })
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            child: Icon(
              IconBroken.Plus,
              size: 30,
            ),
            onPressed: () {
              cubit.newPost();
            },
            backgroundColor: defaultColor,

            //params
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          extendBody: true,
          bottomNavigationBar: Container(
            height: 65,
            child: AnimatedBottomNavigationBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              activeColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedItemColor,
              inactiveColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              iconSize: 35,

              icons: [
                IconBroken.Home,
                IconBroken.Chat,
                IconBroken.Location,
                IconBroken.Profile,
              ],
              activeIndex: cubit.currentIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              rightCornerRadius: 10,
              leftCornerRadius: 10,
              splashColor: Colors.teal, splashSpeedInMilliseconds: 500,
              onTap: (index) => cubit.changeBottom(index),
              //other params
            ),
          ),
//             bottomNavigationBar:
//                BottomNavigationBar(
//                 currentIndex: cubit.currentIndex,
//               onTap: (index){
//                 cubit.changeBottom(index);
//               },
//               items: [
// BottomNavigationBarItem(icon:Icon(IconBroken.Home,size: 35,),label: "Home"),
// BottomNavigationBarItem(icon:Icon(IconBroken.Chat,size: 35) ,label: "Chats"),
// BottomNavigationBarItem(icon:Icon(IconBroken.Plus,size: 35) ,label: "Chats"),
// BottomNavigationBarItem(icon:Icon(IconBroken.Location,size: 35) ,label: "Location"),
// BottomNavigationBarItem(icon:Icon(IconBroken.Setting,size: 35) ,label: "Settings"),
//               ],),
        );
      },
    );
  }
}
