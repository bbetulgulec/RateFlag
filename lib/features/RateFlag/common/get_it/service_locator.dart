import 'package:get_it/get_it.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_auth_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_firestore_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_storage_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/storage_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/check_auth_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/create_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/delete_account.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/forgot_password_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/login_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/sign_out.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/add_comment_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_comment.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_follow_data.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/is_following.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_by_id.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_comments.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_user_posts.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_saved_posts.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/rate_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/share_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toggle_follow.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toogle_saved_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/verifiy_mail.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/storage/upload_image_storage.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/storage/upload_profile_image.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/cubit/splash_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => FirebaseAuthImpl());
  getIt.registerLazySingleton<FirestoreRepository>(
    () => FirebaseFirestoreImpl(),
  );
  getIt.registerLazySingleton<StorageRepository>(() => FirebaseStorageImpl());

  // Usecases
  getIt.registerLazySingleton(() => CheckAuthUser(getIt()));
  getIt.registerLazySingleton(
    () => CreateUser(getIt<AuthRepository>(), getIt<FirestoreRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteAccount(getIt<FirestoreRepository>(), getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => ForgotPasswordUser(getIt()));
  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => SignOut(getIt()));
  getIt.registerLazySingleton(() => CreatePost(getIt()));
  getIt.registerLazySingleton(() => CreateComment(getIt()));
  getIt.registerLazySingleton(() => GetUserFollowData(getIt()));
  getIt.registerLazySingleton(() => IsFollowing(getIt()));
  getIt.registerLazySingleton(() => LoadAllPost(getIt()));
  getIt.registerLazySingleton(() => LoadPostById(getIt()));
  getIt.registerLazySingleton(() => ToggleSavedPost(getIt()));
  getIt.registerLazySingleton(() => LoadUserPosts(getIt()));
  getIt.registerLazySingleton(() => LoadSavedPosts(getIt()));
  getIt.registerLazySingleton(() => RatePost(getIt()));
  getIt.registerLazySingleton(() => PostShare());
  getIt.registerLazySingleton(() => ToggleFollows(getIt()));
  getIt.registerLazySingleton(() => UpdateUserInfo(getIt()));
  getIt.registerLazySingleton(() => AddCommentPost(getIt()));
  getIt.registerLazySingleton(() => LoadPostComments(getIt()));

  getIt.registerLazySingleton(
    () => VerifyMail(getIt<FirestoreRepository>(), getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => UploadImageStorage(getIt()));
  getIt.registerLazySingleton(
    () => UploadProfileImage(getIt<StorageRepository>()),
  );

  getIt.registerLazySingleton(() => GetUserInfo(getIt()));
  // Cubits
  getIt.registerFactory(() => AccountInfoCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => HomeCubit(getIt(), getIt()));
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));
  getIt.registerFactory(() => MainCubit());
  getIt.registerFactory(() => OnboardingCubit(totalPageCount: 4));
  getIt.registerFactory(() => PostCubit(getIt(), getIt()));
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
    () => ProfileCubit(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(() => RegisterCubit(getIt()));
  getIt.registerFactory(() => SettingsCubit(getIt()));
  getIt.registerFactory(() => SplashCubit(getIt()));
}
