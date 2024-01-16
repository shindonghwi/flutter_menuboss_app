import 'package:get_it/get_it.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class GetTutorialViewedUseCase {
  GetTutorialViewedUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<bool> call(TutorialKey key) async {
    return await _localAppRepository.hasViewedTutorial(key.toString());
  }
}
