import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/local/app/LocalAppApi.dart';
import 'package:menuboss/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:menuboss/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:menuboss/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:menuboss/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:menuboss/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostAppleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostSocialEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:menuboss/presentation/utils/Common.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// common
  /// -------
  GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());

  /// -------
  /// usecase
  /// -------

  // app
  GetIt.instance.registerLazySingleton<GetLoginAccessTokenUseCase>(() => GetLoginAccessTokenUseCase());
  GetIt.instance.registerLazySingleton<PostLoginAccessTokenUseCase>(() => PostLoginAccessTokenUseCase());

  // auth
  GetIt.instance.registerLazySingleton<PostAppleSignInUseCase>(() => PostAppleSignInUseCase());
  GetIt.instance.registerLazySingleton<PostGoogleSignInUseCase>(() => PostGoogleSignInUseCase());
  GetIt.instance.registerLazySingleton<PostSocialLoginInUseCase>(() => PostSocialLoginInUseCase());
  GetIt.instance.registerLazySingleton<PostEmailLoginInUseCase>(() => PostEmailLoginInUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
}
