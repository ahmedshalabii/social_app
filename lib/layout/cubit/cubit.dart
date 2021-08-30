import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screens.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/components/profile_components.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;
  PostModel postModel;

  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  int currentButton = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<Widget> profileScreens = [
    ProfileFollowers(),
    ProfileFollowing(),
    ProfilePosts(),
  ];
  List<String> title = [
    "Home",
    "Chats",
    "Users",
    "Profile",
  ];
  void changeProfileScreens(int profileIndex) {
    currentButton = profileIndex;
    emit(ChangeProfileScreensState());
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  void newPost() {
    emit(NewPostState());
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    emit(ProfileImagePickedLoadingState());
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    emit(CoverImagePickedLoadingState());
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
    @required String password,
  }) {
    emit(GetUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${userModel.uId}/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          password: password,
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(ProfileImageUploadErrorState());
      });
    }).catchError((error) {
      emit(ProfileImageUploadErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
    @required String password,
  }) {
    emit(GetUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${userModel.uId}/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          password: password,
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(CoverImageUploadErrorState());
      });
    }).catchError((error) {
      emit(CoverImageUploadErrorState());
    });
  }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
    @required String password,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,
      password: password,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async {
    emit(PostImagePickedLoadingState());
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemoveState());
  }

  void removePostVideo() {
    postVideo = null;
    emit(PostVideoRemoveState());
  }

  void noPostData() {
    if (postModel.postImage == null &&
        postModel.text == null &&
        postModel.text == null) emit(NoPostDataState());
  }

  File postVideo;

  Future<void> getPostVideo() async {
    emit(PostVideoPickedLoadingState());
    final pickedFile = await picker.getVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostVideoPickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostVideoPickedErrorState());
    }
  }

  void uploadPostImage({
    String text,
    @required String dateTime,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
        print(value);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void uploadPostVideo({
    @required String dateTime,
    String text,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postVideo.path).pathSegments.last}')
        .putFile(postVideo)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(text: text, dateTime: dateTime, postVideo: value);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost(
      {String text,
      @required String dateTime,
      String postImage,
      String postVideo}) {
    PostModel postModel = PostModel(
      name: userModel.name,
      image: userModel.image,
      uId: userModel.uId,
      postVideo: postVideo ?? '',
      postImage: postImage ?? '',
      dateTime: dateTime,
      text: text,
    );
    emit(CreatePostLoadingState());
    if (postImage == null && text.trim().isEmpty == true && postVideo == null) {
      emit(NoPostDataState());
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> commment = [];
  void getPosts() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);

          postsId.add(element.id);
          posts.add(PostModel.fomJson(element.data()));

          emit(GetPostSuccessState());
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(GetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      LikePostErrorState(error.toString());
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel.uId)
        .set({'comment': true}).then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error) {
      CommentPostErrorState(error.toString());
    });
  }

  List<SocialUserModel> users = [];
  void getUsers() {
    if (users.length == 0) emit(GetAllUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserErrorState(error.toString()));
    });
  }

  void logOut(context) {
    emit(LogoutuserLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      navigateAndFinish(context, LoginScreen());
      emit(LogoutuserSuccessState());
    }).catchError((error) => emit(LogoutuserErrorState(error.toString())));
  }
}
