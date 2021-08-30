import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/video_widget.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:video_player/video_player.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var postTextController = TextEditingController();

  String now = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var profileImage = HomeCubit.get(context).profileImage;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is NoPostDataState) {
          showToast(text: 'No data', state: ToastStates.ERROR);
        }
        if (state is CreatePostSuccessState) {
          navigateAndFinish(context, HomeLayout());
          cubit.postImage = null;
         
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Creat post"),
            actions: [
              TextButton(
                  child: Text(
                    "Share",
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  onPressed: () {
                    if (cubit.postImage == null ) {
                      cubit.createPost(
                          text: postTextController.text, dateTime: now);
                    } else {
                      cubit.uploadPostImage(
                        text: postTextController.text,
                        dateTime: now,
                      );
                    }
                 
                  })
            ],
          ),
          body: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                if (state is CreatePostLoadingState) LinearProgressIndicator(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        radius: 35,
                        backgroundImage: profileImage == null
                            ? NetworkImage("${cubit.userModel.image}")
                            : FileImage(profileImage),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.userModel.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          now,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Container(
                    width: double.infinity,
                    height: 0.2,
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: postTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: "What is on your Mind ...",
                            hintStyle: Theme.of(context).textTheme.caption,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                if (cubit.postImage != null)
                  Container(
                    height: 200,
                    width: 150,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(image: FileImage(cubit.postImage)),
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey.withOpacity(0.0),
                          child: IconButton(
                            splashRadius: 19,
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              cubit.removePostImage();
                            },
                          ),
                        ),
                      ],
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
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
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
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
