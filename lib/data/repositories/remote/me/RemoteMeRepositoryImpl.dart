// import 'package:get_it/get_it.dart';
// import 'package:ody_flutter_app/data/data_source/remote/me/RemoteMeApi.dart';
// import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
// import 'package:ody_flutter_app/data/models/ApiResponse.dart';
// import 'package:ody_flutter_app/data/models/me/RequestMeMedicineModel.dart';
// import 'package:ody_flutter_app/data/models/me/RequestMeMedicineUpdateModel.dart';
// import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
// import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
// import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
// import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
// import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';
//
// class RemoteMeRepositoryImpl implements RemoteMeRepository {
//   RemoteMeRepositoryImpl();
//
//   @override
//   Future<ApiResponse<ResponseMeInfoModel>> getMe() {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.getMe();
//   }
//
//   @override
//   Future<ApiResponse<void>> postLeave(String reason) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.postLeave(reason);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchGender(GenderType type) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchGender(type: type);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchNickname(String nick) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchNickname(nick: nick);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchHeight(int height) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchHeight(height: height);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchWeight(int weight) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchWeight(weight: weight);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchBirthday(String birthday) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchBirthday(birthday: birthday);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchDiseases(List<DiseaseType> diseases) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchDiseases(diseases: diseases);
//   }
//
//   @override
//   Future<ApiResponse<ResponseMeMedicineModel>> postMedicine(RequestMeMedicineModel data) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.postMedicine(data: data);
//   }
//
//   @override
//   Future<ApiListResponse<List<ResponseMeMedicineModel>>> getMedicines() {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.getMedicines();
//   }
//
//   @override
//   Future<ApiResponse<ResponseMeMedicineModel>> patchMedicine(RequestMeMedicineUpdateModel data) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchMedicine(data: data);
//   }
//
//   @override
//   Future<ApiResponse<void>> deleteMedicine(int medicineSeq) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.deleteMedicine(medicineSeq: medicineSeq);
//   }
//
//   @override
//   Future<ApiResponse<void>> patchConfigNotification(
//     bool all,
//     bool medicine,
//     bool step,
//     bool bloodPressure,
//     bool glucose,
//     bool report,
//   ) {
//     RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();
//     return remoteMeApi.patchConfigNotification(all, medicine, step, bloodPressure, glucose, report);
//   }
// }
