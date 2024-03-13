import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/repositories/remote/business/RemoteBusinessRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/business/RequestTeamMemberModel.dart';

class PatchMemberUseCase {
  PatchMemberUseCase();

  final RemoteBusinessRepository _remoteBusinessRepository =
      GetIt.instance<RemoteBusinessRepository>();

  Future<ApiResponse<void>> call(RequestTeamMemberModel model, int memberId) async {
    return await _remoteBusinessRepository.patchMember(model, memberId);
  }
}
