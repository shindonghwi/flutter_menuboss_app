import 'package:get_it/get_it.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class PostMediaFilterTypeUseCase {
  PostMediaFilterTypeUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<void> call(FilterType type, Map<FilterType, String> filterValues) async {
    return await _localAppRepository.setMediaFilterType(type, filterValues);
  }
}
