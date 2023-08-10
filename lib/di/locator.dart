import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  // /// -------
  // /// common
  // /// -------
  // GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());
  //
  // /// -------
  // /// usecase
  // /// -------
  //
  // //app
  // GetIt.instance.registerLazySingleton<GetAppPolicyCheckUseCase>(() => GetAppPolicyCheckUseCase());
  // GetIt.instance.registerLazySingleton<GetAppPolicyUpdateUseCase>(() => GetAppPolicyUpdateUseCase());
  // GetIt.instance.registerLazySingleton<GetLoginAccessTokenUseCase>(() => GetLoginAccessTokenUseCase());
  // GetIt.instance.registerLazySingleton<PostLoginAccessTokenUseCase>(() => PostLoginAccessTokenUseCase());
  //
  // GetIt.instance.registerLazySingleton<PostAppleSignInUseCase>(() => PostAppleSignInUseCase());
  // GetIt.instance.registerLazySingleton<PostGoogleSignInUseCase>(() => PostGoogleSignInUseCase());
  // GetIt.instance.registerLazySingleton<PostSocialLoginInUseCase>(() => PostSocialLoginInUseCase());
  //
  // GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  // GetIt.instance.registerLazySingleton<GetMeMedicinesUseCase>(() => GetMeMedicinesUseCase());
  // GetIt.instance.registerLazySingleton<PostMeLeaveUseCase>(() => PostMeLeaveUseCase());
  // GetIt.instance.registerLazySingleton<PostMeMedicineUseCase>(() => PostMeMedicineUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeGenderUseCase>(() => PatchMeGenderUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeBirthdayUseCase>(() => PatchMeBirthdayUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeNicknameUseCase>(() => PatchMeNicknameUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeHeightUseCase>(() => PatchMeHeightUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeWeightUseCase>(() => PatchMeWeightUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeDiseasesUseCase>(() => PatchMeDiseasesUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeConfigNotificationUseCase>(() => PatchMeConfigNotificationUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeMedicineUseCase>(() => PatchMeMedicineUseCase());
  // GetIt.instance.registerLazySingleton<DeleteMedicineUseCase>(() => DeleteMedicineUseCase());
  //
  // GetIt.instance.registerLazySingleton<GetBioHistoryMontlyUseCase>(() => GetBioHistoryMontlyUseCase());
  // GetIt.instance.registerLazySingleton<GetBioHistoryForDaysUseCase>(() => GetBioHistoryForDaysUseCase());
  // GetIt.instance.registerLazySingleton<GetBioReportMonthlyUseCase>(() => GetBioReportMonthlyUseCase());
  // GetIt.instance.registerLazySingleton<GetBioReportWeeklyUseCase>(() => GetBioReportWeeklyUseCase());
  // GetIt.instance.registerLazySingleton<GetBioReportMonthlyInfoUseCase>(() => GetBioReportMonthlyInfoUseCase());
  // GetIt.instance.registerLazySingleton<GetBioReportWeeklyInfoUseCase>(() => GetBioReportWeeklyInfoUseCase());
  // GetIt.instance.registerLazySingleton<PostBioBloodPressureUseCase>(() => PostBioBloodPressureUseCase());
  // GetIt.instance.registerLazySingleton<PostBioGlucoseUseCase>(() => PostBioGlucoseUseCase());
  // GetIt.instance.registerLazySingleton<PostBioStepsUseCase>(() => PostBioStepsUseCase());
  //
  // /// -------
  // /// repository
  // /// -------
  // GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  // GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  // GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());
  // GetIt.instance.registerLazySingleton<RemoteBioRepository>(() => RemoteBioRepositoryImpl());
  //
  // /// -------
  // /// api
  // /// -------
  // GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  // GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  // GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
  // GetIt.instance.registerLazySingleton<RemoteBioApi>(() => RemoteBioApi());
}
