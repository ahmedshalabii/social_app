import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          
          return ConditionalBuilder(
            condition:HomeCubit.get(context).users.length>0 ,
            builder: (context)=>
             ListView.separated(
              physics:BouncingScrollPhysics(),
                itemBuilder: (context, index) => chatItem(context,HomeCubit.get(context).users[index]),
                separatorBuilder: (context, index) =>  SizedBox(height: 1,),
                itemCount: HomeCubit.get(context).users.length),
                fallback: (context)=> Center(
                      child: CircularProgressIndicator(),
                    ));
          
        });
  }

  Widget chatItem(context,SocialUserModel model) => Padding(
    padding: const EdgeInsets.all(3.0),
    child: Card(
      elevation: 5,
      color: Theme.of(context).backgroundColor,
      child: InkWell(
         onTap: (){},
        child: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
        
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                            style: Theme.of(context).textTheme.subtitle1),
                        SizedBox(
                          width: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 17,
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
