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

class RaqiGetAllStudentTeachersSuccessState extends RaqiStates {}
class RaqiGetAllStudentTeachersErrorState extends RaqiStates {
  final String Error ;
  RaqiGetAllStudentTeachersErrorState(this.Error);
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

class RaqiSaveSessionLoadingState extends RaqiStates {}
class RaqiSaveSessionErrorState extends RaqiStates {}
class RaqiSaveSessionSuccessState extends RaqiStates {}

class RaqiSaveNotificationLoadingState extends RaqiStates {}
class RaqiSaveNotificationErrorState extends RaqiStates {}
class RaqiSaveNotificationSuccessState extends RaqiStates {}

class RaqiGetSessionsLoadingState extends RaqiStates {}
class RaqiGetSessionsErrorState extends RaqiStates {}
class RaqiGetSessionsSuccessState extends RaqiStates {}

class RaqiGetNotificationsLoadingState extends RaqiStates {}
class RaqiGetNotificationsErrorState extends RaqiStates {}
class RaqiGetNotificationsSuccessState extends RaqiStates {}

class RaqiGetTeacherLoadingState extends RaqiStates {}
class RaqiGetTeacherErrorState extends RaqiStates {}
class RaqiGetTeacherSuccessState extends RaqiStates {}

class RaqiGetSearchLoadingState extends RaqiStates {}
class RaqiGetSearchErrorState extends RaqiStates {}
class RaqiGetSearchSuccessState extends RaqiStates {}


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

class RaqiEndCallSuccess extends RaqiStates {}
class RaqiEmitRate extends RaqiStates {}


class RaqiLoadBook extends RaqiStates {}

class RaqiGetTotalMins extends RaqiStates {}


class RaqiSendContactSuccessState extends RaqiStates {}
class RaqiSendContactErrorState extends RaqiStates {}

class RaqiReserveLoadingState extends RaqiStates {}
class RaqiReserveSuccess extends RaqiStates {}
class RaqiReserveErrorState extends RaqiStates {}

class RaqiGetReservedLoadingState extends RaqiStates {}
class RaqiGetReservedSuccessState extends RaqiStates {}

class getFollowerLoadingState extends RaqiStates {}
class getFollowerSuccessState extends RaqiStates {}
class getFollowerErorrState extends RaqiStates {}

class getMyFollowersSuccessState extends RaqiStates {}
class getMyFollowersLoadingState extends RaqiStates {}
class getMyFollowersErorrState extends RaqiStates {}



