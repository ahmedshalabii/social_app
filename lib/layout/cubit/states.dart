abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class HomeLoadingState extends HomeStates {}
class GetUserLoadingState extends HomeStates {}
class GetUserSuccessState extends HomeStates {}
class GetUserErrorState extends HomeStates {
  final String error;
  GetUserErrorState(this.error);}
  //get all Users
  class GetAllUserLoadingState extends HomeStates {}
class GetAllUserSuccessState extends HomeStates {}
class GetAllUserErrorState extends HomeStates {
  final String error;
  GetAllUserErrorState(this.error);}
  //get posts
class GetPostLoadingState extends HomeStates {}
class GetPostSuccessState extends HomeStates {}
class GetPostErrorState extends HomeStates {
  final String error;
  GetPostErrorState(this.error);}
class ChangeBottomNavState extends HomeStates{}
class NewPostState extends HomeStates{}
class UserUpdateErrorState extends HomeStates{}
class ChangeProfileScreensState extends HomeStates{}
// Profile image Picked
class ProfileImagePickedLoadingState extends HomeStates{}
class ProfileImagePickedSuccessState extends HomeStates{}
class ProfileImagePickedErrorState extends HomeStates{}
// Profile image Update
class ProfileImageUpdateLoadingState extends HomeStates{}
class ProfileImageUploadSuccessState extends HomeStates{}
class ProfileImageUploadErrorState extends HomeStates{}
// Cover image Picked
class CoverImagePickedLoadingState extends HomeStates{}
class CoverImagePickedSuccessState extends HomeStates{}
class CoverImagePickedErrorState extends HomeStates{}
// Cover image Update
class CoverImageUpdateLoadingState extends HomeStates{}
class CoverImageUploadSuccessState extends HomeStates{}
class CoverImageUploadErrorState extends HomeStates{}
//Creat post
class CreatePostLoadingState extends HomeStates{}
class CreatePostSuccessState extends HomeStates{}
class CreatePostErrorState extends HomeStates{}
// Post image Picked
class PostImagePickedLoadingState extends HomeStates{}
class PostImagePickedSuccessState extends HomeStates{}
class PostImagePickedErrorState extends HomeStates{}
class PostImageRemoveState extends HomeStates{}
// Post video Picked
class PostVideoPickedLoadingState extends HomeStates{}
class PostVideoPickedSuccessState extends HomeStates{}
class PostVideoPickedErrorState extends HomeStates{}
class PostVideoRemoveState extends HomeStates{}
// No post Data
class NoPostDataState extends HomeStates{}
//post like
class LikePostSuccessState extends HomeStates {}
class LikePostErrorState extends HomeStates {
  final String error;
  LikePostErrorState(this.error);}
  //post comment
  class CommentPostSuccessState extends HomeStates {}
class CommentPostErrorState extends HomeStates {
  final String error;
  CommentPostErrorState(this.error);}
  //Log out
class LogoutuserLoadingState extends HomeStates{}
class LogoutuserSuccessState extends HomeStates{}
class LogoutuserErrorState extends HomeStates{
   final String error;
  LogoutuserErrorState(this.error);
}