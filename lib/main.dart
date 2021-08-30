import 'package:flutter/material.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';

Widget widget;

void main() async {
  // await CacheHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   bool isDark = CacheHelper.getData(key: 'isDark');
 uId = await CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    start: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget start;

  MyApp({
    this.isDark,
    this.start,
  });
  @override
  Widget build(BuildContext context) {
    
          return MultiBlocProvider(
      providers: [
       
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
       
        BlocProvider(
          create: (BuildContext context) => HomeCubit()..getUserData()..getPosts()..getUsers()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.system :ThemeMode.system,
            home: start,
          );
        },
      ),
    );

  }
}
