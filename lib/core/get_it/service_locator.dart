import 'package:get_it/get_it.dart';
import 'package:rate_flag/app/features/data/domain/repositories/auth_repository.dart';
import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/domain/repositories/notification_permission_repository.dart';
import 'package:rate_flag/app/features/data/domain/repositories/storage_repository.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_cubit.dart';
import 'package:rate_flag/app/features/data/data/repositories/firebase_auth_impl.dart';
import 'package:rate_flag/app/features/data/data/repositories/firebase_firestore_impl.dart';
import 'package:rate_flag/app/features/data/data/repositories/firebase_storage_impl.dart';
import 'package:rate_flag/app/features/data/data/repositories/local_services_impl.dart';
import 'package:rate_flag/app/features/data/usecase/auth/check_auth_user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/create_user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/delete_account.dart';
import 'package:rate_flag/app/features/data/usecase/auth/forgot_password_user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/login_user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/sign_out.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/create_comment.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/create_post.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/firestore/get_saved_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/is_following.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_all_user.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_post_by_id.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_post_comment.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_user_posts.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/rate_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/search_post_city.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/search_user_by_user_name.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/share_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/toggle_follow.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/toogle_saved_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/app/features/data/usecase/local/local_load__notifications.dart';
import 'package:rate_flag/app/features/data/usecase/local/local_send_notification.dart';
import 'package:rate_flag/app/features/data/usecase/local/local_services.dart';
import 'package:rate_flag/app/features/data/usecase/storage/upload_image_storage.dart';
import 'package:rate_flag/app/features/data/usecase/storage/upload_profile_image.dart';
import 'package:rate_flag/app/features/presentations/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/app/features/presentations/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/app/features/presentations/follow_list/cubit/follow_list_cubit.dart';
import 'package:rate_flag/app/features/presentations/home/cubit/home_cubit.dart';
import 'package:rate_flag/app/features/presentations/login/cubit/login_cubit.dart';
import 'package:rate_flag/app/features/presentations/main/cubit/main_cubit.dart';
import 'package:rate_flag/app/features/presentations/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/app/features/presentations/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/app/features/presentations/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/app/features/presentations/register/cubit/register_cubit.dart';
import 'package:rate_flag/app/features/presentations/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/app/features/presentations/splash/cubit/splash_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => FirebaseAuthImpl());
  getIt.registerLazySingleton<FirestoreRepository>(
    () => FirebaseFirestoreImpl(),
  );
  getIt.registerLazySingleton<StorageRepository>(() => FirebaseStorageImpl());
  getIt.registerLazySingleton<NotificationPermissionRepository>(
    () => LocalServicesImpl(),
  );

  // Usecases
  getIt.registerLazySingleton(() => CheckAuthUser(getIt()));
  getIt.registerLazySingleton(
    () => CreateUser(getIt<AuthRepository>(), getIt<FirestoreRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteAccount(getIt<FirestoreRepository>(), getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => ForgotPasswordUser(getIt()));
  getIt.registerLazySingleton(() => GetSavedPosts(getIt()));
  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => SignOut(getIt()));
  getIt.registerLazySingleton(() => CreatePost(getIt()));
  getIt.registerLazySingleton(() => CreateComment(getIt()));
  getIt.registerLazySingleton(() => IsFollowing(getIt()));
  getIt.registerLazySingleton(() => LoadAllPost(getIt()));
  getIt.registerLazySingleton(() => LoadPostById(getIt()));
  getIt.registerLazySingleton(() => ToggleSavedPost(getIt()));
  getIt.registerLazySingleton(() => LoadUserPosts(getIt()));
  getIt.registerLazySingleton(() => RatePost(getIt()));
  getIt.registerLazySingleton(() => PostShare());
  getIt.registerLazySingleton(() => ToggleFollows(getIt()));
  getIt.registerLazySingleton(() => UpdateUserInfo(getIt()));
  getIt.registerLazySingleton(() => SearchUserByUsername(getIt()));
  getIt.registerLazySingleton(() => LoadPostComment(getIt()));
  getIt.registerLazySingleton(() => UploadImageStorage(getIt()));
  getIt.registerLazySingleton(
    () => UploadProfileImage(getIt<StorageRepository>()),
  );

  getIt.registerLazySingleton(() => GetUserInfo(getIt()));
  getIt.registerLazySingleton(
    () => LocalSendNotification(getIt<NotificationPermissionRepository>()),
  );
  getIt.registerLazySingleton(
    () => LocalServices(getIt<NotificationPermissionRepository>()),
  );

  getIt.registerLazySingleton(
    () => LoadLocalNotifications(getIt<NotificationPermissionRepository>()),
  );
  getIt.registerLazySingleton<SearchPostCity>(
    () => SearchPostCity(getIt<FirestoreRepository>()),
  );
  getIt.registerLazySingleton<LoadAllUser>(
    () => LoadAllUser(getIt<FirestoreRepository>()),
  );

  // Cubits
  getIt.registerFactory(() => AccountInfoCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => HomeCubit(getIt(), getIt()));
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));
  getIt.registerFactory(() => FollowListCubit(getIt()));
  getIt.registerFactory(() => MainCubit());
  getIt.registerFactory(() => OnboardingCubit(totalPageCount: 4));
  getIt.registerFactory(() => PostCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => FilterPageCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(
    () => PostInfoCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => ProfileCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(() => RegisterCubit(getIt()));
  getIt.registerFactory(() => SettingsCubit(getIt()));
  getIt.registerFactory(() => SplashCubit(getIt()));
  getIt.registerFactory(() => NotificationCubit(getIt(), getIt()));
}
