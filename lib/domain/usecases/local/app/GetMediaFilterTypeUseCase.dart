import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetFilterSelector.dart';

import '../../../repositories/local/app/LocalAppRepository.dart';

class GetMediaFilterTypeUseCase {
  GetMediaFilterTypeUseCase();

  final LocalAppRepository _localAppRepository = GetIt.instance<LocalAppRepository>();

  Future<FilterType> call(Map<FilterType, String> filterValues) async {
    final mediaFilterType = await _localAppRepository.getMediaFilterType(filterValues);
    debugPrint("local mediaFilterType: $mediaFilterType");
    return mediaFilterType;
  }
}
