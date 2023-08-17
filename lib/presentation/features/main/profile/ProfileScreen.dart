import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menuboss/presentation/components/appbar/TopBarTitle.dart';
import 'package:menuboss/presentation/utils/Common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarTitle(
        content: getAppLocalizations(context).profile_appbar_title,
      ),
      body: SafeArea(
        child: Container(

        ),
      ),
    );
  }
}
