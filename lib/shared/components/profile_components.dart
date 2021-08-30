import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ProfilePosts extends StatefulWidget {
  @override
  _ProfilePostsState createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  //   void initState() {
  //   HomeCubit.get(context).getPosts();
  // }
  @override
  Widget build(BuildContext context) {
    return profilePosts();
  }
}

Widget profilePosts() {
  return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => BulidPostItem(
              context, HomeCubit.get(context).posts[index], index),
          separatorBuilder: (context, index) => SizedBox(
            height: 8,
          ),
          itemCount: HomeCubit.get(context).posts.length,
        );
      });
}

Widget ProfileFollowers() => Center(child: Text("Your followers"));
Widget ProfileFollowing() => Center(child: Text("Your Following"));
Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title,
      ),
      actions: actions,
    );
Widget BulidPostItem(context, PostModel model, index) {
  var cubit = HomeCubit.get(context);
  // bool onTapLike=;
  return Card(
    color: Theme.of(context).backgroundColor,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(
                        width: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                  Text('${model.dateTime}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Spacer(),
              IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {})
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Text(
            '${model.text}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 5),
        //   width: double.infinity,
        //   child: Wrap(
        //     alignment: WrapAlignment.start,
        //     crossAxisAlignment: WrapCrossAlignment.start,
        //     children: [
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           height: 25,
        //           minWidth: 1,
        //           padding: EdgeInsets.only(left: 3),
        //           child: Text(
        //             "#Android",
        //             style: TextStyle(color: defaultColor, fontSize: 16),
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        if (model.postImage != '')
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 500.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    )),
              )),

        Row(
          children: [
            TextButton(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        "${cubit.likes[index]}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                onPressed: () {}),
            Spacer(),
            TextButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.insert_comment,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        "0",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                onPressed: () {}),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    // cubit.commentPost(cubit.postsId[index]);
                  },
                  child: Row(

                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundImage:
                            NetworkImage('${cubit.userModel.image}'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              

              TextButton(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.redAccent,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                onPressed: () {
                  cubit.likePost(cubit.postsId[index]);
                },
              )
// TextButton(

              // child: Row(
              //   children: [

              //     Icon(
              //       IconBroken.Heart,
              //       color: Colors.red,
              //     ),
              //     Text(
              //       "Dislike",
              //       style: Theme.of(context).textTheme.caption,
              //     )
              //   ],
              // ),
              //   onPressed: () {

              //   cubit.likePost(cubit.postsId[index]);
              // },
              // )
            ],
          ),
        )
      ],
    ),
  );
}
