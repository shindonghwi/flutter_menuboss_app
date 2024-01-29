import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/business/RequestAddressModel.dart';

class PatchBusinessAddressUseCase {
  PatchBusinessAddressUseCase();

  final RemoteBusinessRepository _remoteBusinessRepository =
      GetIt.instance<RemoteBusinessRepository>();

  Future<ApiResponse<void>> call(RequestAddressModel model) async {
    return await _remoteBusinessRepository.patchAddress(model);
  }
}
