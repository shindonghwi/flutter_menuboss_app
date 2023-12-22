import 'package:menuboss_common/ui/tutorial/model/TutorialKey.dart';

class TutorialKeyHelper {
  static const Map<TutorialKey, String> _stringToEnum = {
    TutorialKey.ScreenRegisterKey: "ScreenRegisterKey",
    TutorialKey.ScreenQrCode: "ScreenQrCode",
    TutorialKey.ScreenAdded: "ScreenAdded",
  };

  static String fromString(TutorialKey key) => _stringToEnum[key]!;
}
