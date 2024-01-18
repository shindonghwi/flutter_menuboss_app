import 'package:get_it/get_it.dart';
import 'package:menuboss/data/data_source/local/app/LocalAppApi.dart';
import 'package:menuboss/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:menuboss/data/data_source/remote/canvas/RemoteCanvasApi.dart';
import 'package:menuboss/data/data_source/remote/device/RemoteDeviceApi.dart';
import 'package:menuboss/data/data_source/remote/file/RemoteFileApi.dart';
import 'package:menuboss/data/data_source/remote/me/RemoteMeApi.dart';
import 'package:menuboss/data/data_source/remote/media/RemoteMediaApi.dart';
import 'package:menuboss/data/data_source/remote/playlist/RemotePlaylistApi.dart';
import 'package:menuboss/data/data_source/remote/schedule/RemoteScheduleApi.dart';
import 'package:menuboss/data/data_source/remote/validation/RemoteValidationApi.dart';
import 'package:menuboss/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/canvas/RemoteCanvasRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/device/RemoteDeviceRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/file/RemoteFileRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/me/RemoteMeRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/media/RemoteMediaRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/playlist/RemotePlaylistRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/schedule/RemoteScheduleRepositoryImpl.dart';
import 'package:menuboss/data/repositories/remote/validation/RemoteValidationRepositoryImpl.dart';
import 'package:menuboss/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:menuboss/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:menuboss/domain/repositories/remote/canvas/RemoteCanvasRepository.dart';
import 'package:menuboss/domain/repositories/remote/device/RemoteDeviceRepository.dart';
import 'package:menuboss/domain/repositories/remote/file/RemoteFileRepository.dart';
import 'package:menuboss/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:menuboss/domain/repositories/remote/media/RemoteMediaRepository.dart';
import 'package:menuboss/domain/repositories/remote/playlist/RemotePlaylistRepository.dart';
import 'package:menuboss/domain/repositories/remote/schedule/RemoteScheduleRepository.dart';
import 'package:menuboss/domain/repositories/remote/validation/RemoteValidationRepository.dart';
import 'package:menuboss/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/GetMediaFilterTypeUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/GetTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostMediaFilterTypeUseCase.dart';
import 'package:menuboss/domain/usecases/local/app/PostTutorialViewedUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostAppleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostLogoutUseCase.dart';
import 'package:menuboss/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:menuboss/domain/usecases/remote/canvas/GetCanvasesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/DelDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/GetDeivcesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PatchDeviceNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDeviceUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDevicesContentsUseCase.dart';
import 'package:menuboss/domain/usecases/remote/device/PostShowNameEventUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadMediaVideoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/file/PostUploadProfileImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMePasswordUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMePhoneUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PatchMeProfileImageUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeJoinUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeLeaveUseCase.dart';
import 'package:menuboss/domain/usecases/remote/me/PostMeSocialJoinUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/DelMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediaUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/GetMediasUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PatchMediaNameUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PostCreateMediaFolderUseCase.dart';
import 'package:menuboss/domain/usecases/remote/media/PostMediaMoveUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/DelPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PatchPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/playlist/PostPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/DelScheduleUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/GetScheduleUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/GetSchedulesUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/PatchScheduleUseCase.dart';
import 'package:menuboss/domain/usecases/remote/schedule/PostPlaylistUseCase.dart';
import 'package:menuboss/domain/usecases/remote/validation/PostValidationSocialLoginUseCase.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// usecase
  /// -------

  // app
  GetIt.instance.registerLazySingleton<GetLoginAccessTokenUseCase>(() => GetLoginAccessTokenUseCase());
  GetIt.instance.registerLazySingleton<PostLoginAccessTokenUseCase>(() => PostLoginAccessTokenUseCase());
  GetIt.instance.registerLazySingleton<GetMediaFilterTypeUseCase>(() => GetMediaFilterTypeUseCase());
  GetIt.instance.registerLazySingleton<PostMediaFilterTypeUseCase>(() => PostMediaFilterTypeUseCase());
  GetIt.instance.registerLazySingleton<GetTutorialViewedUseCase>(() => GetTutorialViewedUseCase());
  GetIt.instance.registerLazySingleton<PostTutorialViewedUseCase>(() => PostTutorialViewedUseCase());

  // auth
  GetIt.instance.registerLazySingleton<PostAppleSignInUseCase>(() => PostAppleSignInUseCase());
  GetIt.instance.registerLazySingleton<PostGoogleSignInUseCase>(() => PostGoogleSignInUseCase());
  GetIt.instance.registerLazySingleton<PostSocialLoginInUseCase>(() => PostSocialLoginInUseCase());
  GetIt.instance.registerLazySingleton<PostEmailLoginUseCase>(() => PostEmailLoginUseCase());
  GetIt.instance.registerLazySingleton<PostLogoutUseCase>(() => PostLogoutUseCase());

  // me
  GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  GetIt.instance.registerLazySingleton<PatchMeNameUseCase>(() => PatchMeNameUseCase());
  GetIt.instance.registerLazySingleton<PatchMePhoneUseCase>(() => PatchMePhoneUseCase());
  GetIt.instance.registerLazySingleton<PatchMePasswordUseCase>(() => PatchMePasswordUseCase());
  GetIt.instance.registerLazySingleton<PostMeJoinUseCase>(() => PostMeJoinUseCase());
  GetIt.instance.registerLazySingleton<PostMeLeaveUseCase>(() => PostMeLeaveUseCase());
  GetIt.instance.registerLazySingleton<PatchMeProfileImageUseCase>(() => PatchMeProfileImageUseCase());
  GetIt.instance.registerLazySingleton<PostMeSocialJoinUseCase>(() => PostMeSocialJoinUseCase());

  // device
  GetIt.instance.registerLazySingleton<GetDevicesUseCase>(() => GetDevicesUseCase());
  GetIt.instance.registerLazySingleton<PostDeviceUseCase>(() => PostDeviceUseCase());
  GetIt.instance.registerLazySingleton<DelDeviceUseCase>(() => DelDeviceUseCase());
  GetIt.instance.registerLazySingleton<PatchDeviceNameUseCase>(() => PatchDeviceNameUseCase());
  GetIt.instance.registerLazySingleton<PostDevicesContentsUseCase>(() => PostDevicesContentsUseCase());
  GetIt.instance.registerLazySingleton<PostShowNameEventUseCase>(() => PostShowNameEventUseCase());

  // playlist
  GetIt.instance.registerLazySingleton<GetPlaylistsUseCase>(() => GetPlaylistsUseCase());
  GetIt.instance.registerLazySingleton<GetPlaylistUseCase>(() => GetPlaylistUseCase());
  GetIt.instance.registerLazySingleton<PostPlaylistUseCase>(() => PostPlaylistUseCase());
  GetIt.instance.registerLazySingleton<PatchPlaylistUseCase>(() => PatchPlaylistUseCase());
  GetIt.instance.registerLazySingleton<DelPlaylistUseCase>(() => DelPlaylistUseCase());

  // schedule
  GetIt.instance.registerLazySingleton<GetSchedulesUseCase>(() => GetSchedulesUseCase());
  GetIt.instance.registerLazySingleton<GetScheduleUseCase>(() => GetScheduleUseCase());
  GetIt.instance.registerLazySingleton<PostScheduleUseCase>(() => PostScheduleUseCase());
  GetIt.instance.registerLazySingleton<PatchScheduleUseCase>(() => PatchScheduleUseCase());
  GetIt.instance.registerLazySingleton<DelScheduleUseCase>(() => DelScheduleUseCase());

  // media
  GetIt.instance.registerLazySingleton<GetMediasUseCase>(() => GetMediasUseCase());
  GetIt.instance.registerLazySingleton<GetMediaUseCase>(() => GetMediaUseCase());
  GetIt.instance.registerLazySingleton<PostCreateMediaFolderUseCase>(() => PostCreateMediaFolderUseCase());
  GetIt.instance.registerLazySingleton<PatchMediaNameUseCase>(() => PatchMediaNameUseCase());
  GetIt.instance.registerLazySingleton<PostMediaMoveUseCase>(() => PostMediaMoveUseCase());
  GetIt.instance.registerLazySingleton<DelMediaUseCase>(() => DelMediaUseCase());

  // canvas
  GetIt.instance.registerLazySingleton<GetCanvasesUseCase>(() => GetCanvasesUseCase());

  // file
  GetIt.instance.registerLazySingleton<PostUploadMediaImageUseCase>(() => PostUploadMediaImageUseCase());
  GetIt.instance.registerLazySingleton<PostUploadMediaVideoUseCase>(() => PostUploadMediaVideoUseCase());
  GetIt.instance.registerLazySingleton<PostUploadProfileImageUseCase>(() => PostUploadProfileImageUseCase());

  // validation
  GetIt.instance.registerLazySingleton<PostValidationSocialLoginUseCase>(() => PostValidationSocialLoginUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteDeviceRepository>(() => RemoteDeviceRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemotePlaylistRepository>(() => RemotePlaylistRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteMediaRepository>(() => RemoteMediaRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteCanvasRepository>(() => RemoteCanvasRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteScheduleRepository>(() => RemoteScheduleRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteFileRepository>(() => RemoteFileRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteValidationRepository>(() => RemoteValidationRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
  GetIt.instance.registerLazySingleton<RemoteDeviceApi>(() => RemoteDeviceApi());
  GetIt.instance.registerLazySingleton<RemotePlaylistApi>(() => RemotePlaylistApi());
  GetIt.instance.registerLazySingleton<RemoteMediaApi>(() => RemoteMediaApi());
  GetIt.instance.registerLazySingleton<RemoteCanvasApi>(() => RemoteCanvasApi());
  GetIt.instance.registerLazySingleton<RemoteScheduleApi>(() => RemoteScheduleApi());
  GetIt.instance.registerLazySingleton<RemoteFileApi>(() => RemoteFileApi());
  GetIt.instance.registerLazySingleton<RemoteValidationApi>(() => RemoteValidationApi());
}
