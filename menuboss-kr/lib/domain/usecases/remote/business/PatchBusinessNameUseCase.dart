import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';

class PatchBusinessNameUseCase {
  PatchBusinessNameUseCase();

  final RemoteBusinessRepository _remoteBusinessRepository =
      GetIt.instance<RemoteBusinessRepository>();

  Future<ApiResponse<void>> call(String title) async {
    return await _remoteBusinessRepository.patchName(title);
  }
}
