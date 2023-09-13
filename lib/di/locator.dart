import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/local/app/LocalAppApi.dart';
import 'package:menuboss/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:menuboss/data/data_source/remote/device/RemoteDeviceApi.dart';
import 'package:menuboss/data/data_source/remote/me/RemoteMeApi.dart';
import 'package:menuboss/data/data_source/remote/playlist/RemotePlaylistApi.dart';
import 'package:menuboss/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/device/RemoteDeviceRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/me/RemoteMeRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/playlist/RemotePlaylistRepositoryImpl.dart';
import 'package:menuboss/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:menuboss/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';
import 'package:menuboss/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostAppleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostLogoutUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/DelDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PatchDeviceNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDevicesContentsUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/DelPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PatchPlaylistNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PatchPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PostPlaylistUseCase.dart';
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
  GetIt.instance.registerLazySingleton<PostEmailLoginUseCase>(() => PostEmailLoginUseCase());
  GetIt.instance.registerLazySingleton<PostLogoutUseCase>(() => PostLogoutUseCase());

  // me
  GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  GetIt.instance.registerLazySingleton<PatchMeNameUseCase>(() => PatchMeNameUseCase());

  // device
  GetIt.instance.registerLazySingleton<GetDevicesUseCase>(() => GetDevicesUseCase());
  GetIt.instance.registerLazySingleton<PostDeviceUseCase>(() => PostDeviceUseCase());
  GetIt.instance.registerLazySingleton<DelDeviceUseCase>(() => DelDeviceUseCase());
  GetIt.instance.registerLazySingleton<PatchDeviceNameUseCase>(() => PatchDeviceNameUseCase());
  GetIt.instance.registerLazySingleton<PostDevicesContentsUseCase>(() => PostDevicesContentsUseCase());

  // playlist
  GetIt.instance.registerLazySingleton<GetPlaylistsUseCase>(() => GetPlaylistsUseCase());
  GetIt.instance.registerLazySingleton<GetPlaylistUseCase>(() => GetPlaylistUseCase());
  GetIt.instance.registerLazySingleton<PostPlaylistUseCase>(() => PostPlaylistUseCase());
  GetIt.instance.registerLazySingleton<PatchPlaylistUseCase>(() => PatchPlaylistUseCase());
  GetIt.instance.registerLazySingleton<PatchPlaylistNameUseCase>(() => PatchPlaylistNameUseCase());
  GetIt.instance.registerLazySingleton<DelPlaylistUseCase>(() => DelPlaylistUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteDeviceRepository>(() => RemoteDeviceRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemotePlaylistRepository>(() => RemotePlaylistRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
  GetIt.instance.registerLazySingleton<RemoteDeviceApi>(() => RemoteDeviceApi());
  GetIt.instance.registerLazySingleton<RemotePlaylistApi>(() => RemotePlaylistApi());
}
