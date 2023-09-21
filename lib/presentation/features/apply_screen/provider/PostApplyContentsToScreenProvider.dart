import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDevicesContentsUseCase.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final PostApplyContentsToScreenProvider = StateNotifierProvider<PostApplyContentsToScreenNotifier, UIState<String?>>(
  (ref) => PostApplyContentsToScreenNotifier(),
);

class PostApplyContentsToScreenNotifier extends StateNotifier<UIState<String?>> {
  PostApplyContentsToScreenNotifier() : super(Idle());

  PostDevicesContentsUseCase get _postDevicesContentsUseCase => GetIt.instance<PostDevicesContentsUseCase>();

  void applyToScreen(RequestDeviceApplyContents model) async {
    state = Loading();
    _postDevicesContentsUseCase(model).then((response) {
      if (response.status == 200) {
        state = Success(response.message);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void init() {
    state = Idle();
  }
}
