abstract class RaqiStates {}

class RaqiInitialStates extends RaqiStates {}
class RaqiGetUserSuccessState extends RaqiStates {}
class RaqiGetUserLoadingState extends RaqiStates {}
class RaqiGetUserErrorState extends RaqiStates {
  final String Error ;
  RaqiGetUserErrorState(this.Error);
}

class RaqiGetAllTeachersSuccessState extends RaqiStates {}
class RaqiGetAllTeachersLoadingState extends RaqiStates {}
class RaqiGetAllTeachersErrorState extends RaqiStates {
  final String Error ;
  RaqiGetAllTeachersErrorState(this.Error);
}

class RaqiGetPostsSuccessState extends RaqiStates {}
class RaqiGetPostsLoadingState extends RaqiStates {}
class RaqiGetPostsErrorState extends RaqiStates {
  final String Error ;
  RaqiGetPostsErrorState(this.Error);
}

class RaqiGetSomeonePostsSuccessState extends RaqiStates {}
class RaqiGetSomeonePostsLoadingState extends RaqiStates {}
class RaqiGetSomeonePostsErrorState extends RaqiStates {
  final String Error ;
  RaqiGetSomeonePostsErrorState(this.Error);
}

class RaqiLikePostSuccessState extends RaqiStates {}
class RaqiLikePostErrorState extends RaqiStates {
  final String Error ;
  RaqiLikePostErrorState(this.Error);
}

class RaqiFollowSomeoneSuccessState extends RaqiStates {}
class RaqiFollowSomeoneErrorState extends RaqiStates {
  final String Error ;
  RaqiFollowSomeoneErrorState(this.Error);
}

class RaqiChangeBottomNavBarState extends RaqiStates {}

class RaqiProfileImagePickedSuccessState extends RaqiStates {}
class RaqiProfileImagePickedErrorState extends RaqiStates {}

class RaqiCoverImagePickedSuccessState extends RaqiStates {}
class RaqiCoverImagePickedErrorState extends RaqiStates {}

class RaqiUploadProfileImageSuccessState extends RaqiStates {}
class RaqiUploadProfileImageErrorState extends RaqiStates {}

class RaqiUploadCoverImageSuccessState extends RaqiStates {}
class RaqiUploadCoverImageErrorState extends RaqiStates {}

class RaqiUserUpdateLoadingState extends RaqiStates {}
class RaqiUserUpdateErrorState extends RaqiStates {}

class RaqiCreatePostLoadingState extends RaqiStates {}
class RaqiCreatePostErrorState extends RaqiStates {}
class RaqiCreatePostSuccessState extends RaqiStates {}

class RaqiCommentLoadingState extends RaqiStates {}
class RaqiCommentErrorState extends RaqiStates {}
class RaqiCommentSuccessState extends RaqiStates {}

class RaqiGetCommentsLoadingState extends RaqiStates {}
class RaqiGetCommentsErrorState extends RaqiStates {}
class RaqiGetCommentsSuccessState extends RaqiStates {}

class RaqiGetAnotherUserLoadingState extends RaqiStates {}
class RaqiGetAnotherUserErrorState extends RaqiStates {}
class RaqiGetAnotherUserSuccessState extends RaqiStates {}


class RaqiPostImagePickedSuccessState extends RaqiStates {}
class RaqiPostImagePickedErrorState extends RaqiStates {}

class RaqiRemovePostImageState extends RaqiStates {}

class RaqiSendMessageErrorState extends RaqiStates {}
class RaqiSendMessageSuccessState extends RaqiStates {}
class RaqiGetMessagesErrorState extends RaqiStates {}
class RaqiGetMessagesSuccessState extends RaqiStates {}

class RaqiGetIsPostLikedSuccessState extends RaqiStates {}
class RaqiGetIsPostLikedLoadingState extends RaqiStates {}

class RaqiGetSearchUserSuccessState extends RaqiStates {}
class RaqiGetSearchUserErrorState extends RaqiStates {}


