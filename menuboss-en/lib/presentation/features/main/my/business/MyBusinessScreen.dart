import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/RequestAddressModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/utils/Clickable.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/InputFormatterUtil.dart';
import 'package:menuboss_common/utils/StringUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';
import 'package:menuboss_common/utils/dto/Pair.dart';

import '../../../login/provider/MeInfoProvider.dart';
import 'provider/UpdateBusinessInfoProvider.dart';

class MyBusinessScreen extends HookConsumerWidget {
  const MyBusinessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoState = ref.watch(meInfoProvider);
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final updateBusinessInfoState = ref.watch(updateBusinessAddressProvider);
    final updateBusinessInfoManager = ref.read(updateBusinessAddressProvider.notifier);

    final businessName = useState(meInfoState?.business?.title);
    final addressInfo = useState(
      RequestAddressModel(
        line1: meInfoState?.business?.address?.line1 ?? "",
        line2: meInfoState?.business?.address?.line2 ?? "",
        postalCode: meInfoState?.business?.address?.postalCode ?? "",
        phone: meInfoState?.business?.phone?.phone ?? "",
        country: meInfoState?.business?.address?.country ?? "US",
        city: meInfoState?.business?.address?.city ?? "",
        state: meInfoState?.business?.address?.state ?? "",
      ),
    );

    useEffect(() {
      return () {
        Future(() {
          updateBusinessInfoManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          updateBusinessInfoState.when(
            success: (event) {
              meInfoManager.updateMeBusinessInfo(
                businessName.value ?? "",
                addressInfo.value,
                addressInfo.value.phone,
              );
              Toast.showSuccess(context, getString(context).messageBusinessUpdateSuccess);
              popPageWrapper(context: context);
            },
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [updateBusinessInfoState]);

    return BaseScaffold(
      appBar: TopBarIconTitleText(
        content: getString(context).myBusinessAppbarTitle,
        rightText: getString(context).commonSave,
        rightIconOnPressed: () {
          updateBusinessInfoManager.updateBusinessInfo(
            addressInfo.value,
            businessName.value ?? "",
          );
        },
        rightTextActivated: true,
        onBack: () => popPageWrapper(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _BusinessName(
                    initValue: businessName.value ?? "",
                    onChanged: (name) => businessName.value = name,
                  ),
                  const SizedBox(height: 24),
                  _Address(
                    line1: meInfoState?.business?.address?.line1 ?? "",
                    line2: meInfoState?.business?.address?.line2 ?? "",
                    onChanged: (line1, line2) {
                      addressInfo.value = addressInfo.value.copyWith(
                        line1: line1,
                        line2: line2,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _City(
                    city: meInfoState?.business?.address?.city ?? "",
                    onChanged: (name) {
                      addressInfo.value = addressInfo.value.copyWith(
                        city: name,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _RegionState(
                    state: meInfoState?.business?.address?.state ?? "",
                    onChanged: (name) {
                      addressInfo.value = addressInfo.value.copyWith(
                        state: name,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _PostalZipCode(
                    postalCode: meInfoState?.business?.address?.postalCode ?? "",
                    onChanged: (code) {
                      addressInfo.value = addressInfo.value.copyWith(
                        postalCode: code,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _Country(
                    country: meInfoState?.business?.address?.country ?? "",
                  ),
                  const SizedBox(height: 24),
                  _Phone(
                    initValue: meInfoState?.business?.phone?.phone ?? "",
                    onChanged: (phone) {
                      addressInfo.value = addressInfo.value.copyWith(
                        phone: phone,
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            if (updateBusinessInfoState is Loading) const LoadingView()
          ],
        ),
      ),
    );
  }
}

class _BusinessName extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _BusinessName({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessBusinessNameTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: useTextEditingController(text: initValue),
          hint: getString(context).myBusinessBusinessNameHint,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}

class _Address extends HookWidget {
  final String line1;
  final String line2;
  final Function(String, String) onChanged;

  const _Address({
    super.key,
    required this.line1,
    required this.line2,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final line1Controller = useTextEditingController(text: line1);
    final line2Controller = useTextEditingController(text: line2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonAddress,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
            controller: line1Controller,
            hint: getString(context).myBusinessAddress1Hint,
            enable: true,
            onChanged: (value) => onChanged.call(
                  value,
                  line2Controller.text,
                )),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: line2Controller,
          hint: getString(context).myBusinessAddress2StateHint,
          enable: true,
          onChanged: (value) => onChanged.call(
            line1Controller.text,
            value,
          ),
        ),
      ],
    );
  }
}

class _City extends HookWidget {
  final String city;
  final Function(String) onChanged;

  const _City({
    super.key,
    required this.city,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cityController = useTextEditingController(text: city);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessCityTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: cityController,
          hint: getString(context).myBusinessCityHint,
          enable: true,
          onChanged: (value) => onChanged.call(
            value,
          ),
        ),
      ],
    );
  }
}

class _RegionState extends HookWidget {
  final String state;
  final Function(String) onChanged;

  const _RegionState({
    super.key,
    required this.state,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final stateController = useTextEditingController(text: state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessRegionStateTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: stateController,
          hint: getString(context).myBusinessRegionStateHint,
          enable: true,
          onChanged: (value) => onChanged.call(
            value,
          ),
        ),
      ],
    );
  }
}

class _PostalZipCode extends HookWidget {
  final String postalCode;
  final Function(String) onChanged;

  const _PostalZipCode({
    super.key,
    required this.postalCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final postalCodeController = useTextEditingController(text: postalCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessPostalZipCodeTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: postalCodeController,
          hint: getString(context).myBusinessPostalZipCodeHint,
          enable: true,
          onChanged: (value) => onChanged.call(
            value,
          ),
        ),
      ],
    );
  }
}

class _Country extends HookWidget {
  final String country;

  const _Country({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).myBusinessCountryTitle,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        Clickable(
          onPressed: () {},
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: getColorScheme(context).colorGray300,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const LoadSvg(
                      path: "assets/imgs/icon_us.svg",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getString(context).commonCountryUS,
                      style: getTextTheme(context).b3m.copyWith(
                            color: getColorScheme(context).colorGray900,
                          ),
                    )
                  ],
                ),
                LoadSvg(
                  path: "assets/imgs/icon_down.svg",
                  width: 20,
                  height: 20,
                  color: getColorScheme(context).colorGray600,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Phone extends HookWidget {
  final String initValue;
  final Function(String) onChanged;

  const _Phone({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final countryList = [
      Pair("US", "+1"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getString(context).commonPhoneNumber,
          style: getTextTheme(context).b3m.copyWith(
                color: getColorScheme(context).colorGray900,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Clickable(
                onPressed: () {},
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: getColorScheme(context).colorGray300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const LoadSvg(
                            path: "assets/imgs/icon_us.svg",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            countryList.first.second,
                            style: getTextTheme(context).b3m.copyWith(
                                  color: getColorScheme(context).colorGray900,
                                ),
                          )
                        ],
                      ),
                      LoadSvg(
                        path: "assets/imgs/icon_down.svg",
                        width: 20,
                        height: 20,
                        color: getColorScheme(context).colorGray600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
            Flexible(
              flex: 19,
              fit: FlexFit.tight,
              child: OutlineTextField.medium(
                inputFormatters: [InputFormatterUtil.usPhoneNumber()],
                controller: useTextEditingController(
                  text: StringUtil.formatUsPhoneNumber(initValue),
                ),
                hint: getString(context).myPageProfilePhoneHint,
                onChanged: (phoneNumber) {
                  onChanged.call("+1 ${StringUtil.extractNumbers(phoneNumber)}");
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
