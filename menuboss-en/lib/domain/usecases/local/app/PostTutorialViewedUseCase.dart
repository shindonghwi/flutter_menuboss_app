import 'package:get_it/get_it.dart';
import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class PostTutorialViewedUseCase {
  PostTutorialViewedUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<void> call(TutorialKey key) async {
    return await _localAppRepository.setTutorialViewed(key.toString());
  }
}
