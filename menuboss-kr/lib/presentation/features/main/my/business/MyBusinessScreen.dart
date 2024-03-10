import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kpostal/kpostal.dart';
import 'package:menuboss/app/MenuBossApp.dart';
import 'package:menuboss/data/models/business/RequestAddressModel.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarIconTitleText.dart';
import 'package:menuboss_common/components/button/PrimaryFilledButton.dart';
import 'package:menuboss_common/components/textfield/OutlineTextField.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/components/view_state/LoadingView.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
import 'package:menuboss_common/utils/InputFormatterUtil.dart';
import 'package:menuboss_common/utils/StringUtil.dart';
import 'package:menuboss_common/utils/UiState.dart';

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
        country: "KR",
        line1: meInfoState?.business?.address?.line1 ?? "",
        line2: meInfoState?.business?.address?.line2 ?? "",
        postalCode: meInfoState?.business?.address?.postalCode ?? "",
        phone: meInfoState?.business?.phone?.phone ?? "",
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
              debugPrint("updateBusinssInfoState success : ${businessName.value}");
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
                    postalCode: meInfoState?.business?.address?.postalCode ?? "",
                    onChanged: (postalCode, line1, line2) {
                      addressInfo.value = addressInfo.value.copyWith(
                        line1: line1,
                        line2: line2,
                        postalCode: postalCode,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _Phone(
                    initValue: meInfoState?.business?.phone?.phone ?? "",
                    onChanged: (phone) {
                      addressInfo.value = addressInfo.value.copyWith(
                        phone: StringUtil.convertKrPhoneCountry(phone),
                      );
                    },
                  ),
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
  final String postalCode;
  final Function(String, String, String) onChanged;

  const _Address({
    super.key,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final postalCodeController = useTextEditingController(text: postalCode);
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
        Row(
          children: [
            Flexible(
              flex: 263,
              fit: FlexFit.tight,
              child: OutlineTextField.medium(
                controller: postalCodeController,
                hint: getString(context).commonPostalCode,
                enable: false,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 67,
              fit: FlexFit.tight,
              child: PrimaryFilledButton.mediumRound8(
                content: getString(context).commonSearch,
                isActivated: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KpostalView(
                        callback: (Kpostal result) {
                          postalCodeController.text = result.postCode;
                          line1Controller.text = result.address;
                          onChanged.call(
                            postalCodeController.text,
                            line1Controller.text,
                            line2Controller.text,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: line1Controller,
          hint: getString(context).commonAddress,
          enable: false,
        ),
        const SizedBox(height: 12),
        OutlineTextField.medium(
          controller: line2Controller,
          hint: getString(context).myBusinessAddressDetailHint,
          onChanged: (value) => onChanged.call(
            postalCodeController.text,
            line1Controller.text,
            value,
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
        OutlineTextField.medium(
          controller: useTextEditingController(text: StringUtil.formatKrPhoneNumber(initValue)),
          hint: getString(context).myBusinessPhoneHint,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
          inputFormatters: [InputFormatterUtil.krPhoneNumber()],
          onChanged: (value) => onChanged.call(value),
        ),
      ],
    );
  }
}
