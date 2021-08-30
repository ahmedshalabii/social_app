import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/profile_components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    var profileImage = HomeCubit.get(context).profileImage;
    var cubit = HomeCubit.get(context);
    // final keyRefresh = GlobalKey<RefreshIndicatorState>();
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (HomeCubit.get(context).posts.length == 0)
        showToast(text: "No Posts found", state: ToastStates.ERROR);
    }, builder: (context, state) {
      return SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        
        child: Column(
          children: [
                   ConditionalBuilder(
          condition: HomeCubit.get(context).userModel!=null,
              builder:(context)=> Card(
                color: Theme.of(context).backgroundColor,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(8.0),
                elevation: 5,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, NewPostScreen());
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: profileImage == null
                                  ? NetworkImage("${cubit.userModel.image}")
                                  : FileImage(profileImage),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Write a new post ...",
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.grey[400],
          ),
        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Expanded(
                          child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconBroken.Image,
                                    color: Colors.greenAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      "Photos",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                navigateTo(context, NewPostScreen());
                                cubit.getPostImage();
                              }),
                        ),
                          
                        Expanded(
                          child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.tag,
                                    color: defaultColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      "Trends",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                navigateTo(context, NewPostScreen());
                                // cubit.getPostImage();
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
               fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
            
            ConditionalBuilder(
                condition: HomeCubit.get(context).posts.length > 0 &&HomeCubit.get(context).userModel!=null ,
                builder: (context) => Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => BulidPostItem(
                              context, HomeCubit.get(context).posts[index],index),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8,
                          ),
                          itemCount: HomeCubit.get(context).posts.length,
                        ),
                        Text(
                          "No more Posts",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          height: 150,
                        )
                      ],
                    ),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
          ],
        ),
      );
    });
  }
}
