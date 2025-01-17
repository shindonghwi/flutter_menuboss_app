import 'package:flutter/material.dart';
import 'package:menuboss/data/models/business/ResponseBusinessMemberModel.dart';
import 'package:menuboss/data/models/business/ResponseRoleModel.dart';
import 'package:menuboss/data/models/device/RequestDeviceApplyContents.dart';
import 'package:menuboss/data/models/media/ResponseMediaModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistsModel.dart';
import 'package:menuboss/data/models/schedule/ResponseScheduleModel.dart';
import 'package:menuboss/data/models/schedule/ResponseSchedulesModel.dart';
import 'package:menuboss/presentation/features/apply_screen/ApplyToDeviceScreen.dart';
import 'package:menuboss/presentation/features/create/playlist/CreatePlaylistScreen.dart';
import 'package:menuboss/presentation/features/create/schedule/CreateScheduleScreen.dart';
import 'package:menuboss/presentation/features/delete_account/DeleteAccountScreen.dart';
import 'package:menuboss/presentation/features/detail/playlist/DetailPlaylistScreen.dart';
import 'package:menuboss/presentation/features/detail/schedule/DetailScheduleScreen.dart';
import 'package:menuboss/presentation/features/guide/detail/GuideDetailScreen.dart';
import 'package:menuboss/presentation/features/guide/list/GuideListScreen.dart';
import 'package:menuboss/presentation/features/login/LoginScreen.dart';
import 'package:menuboss/presentation/features/main/MainScreen.dart';
import 'package:menuboss/presentation/features/main/media/in_folder/MediaInFolderScreen.dart';
import 'package:menuboss/presentation/features/main/my/account/MyAccountScreen.dart';
import 'package:menuboss/presentation/features/main/my/business/MyBusinessScreen.dart';
import 'package:menuboss/presentation/features/main/my/password/MyPasswordScreen.dart';
import 'package:menuboss/presentation/features/main/my/profile/MyProfileScreen.dart';
import 'package:menuboss/presentation/features/main/my/role/create/RoleCreateScreen.dart';
import 'package:menuboss/presentation/features/main/my/role/list/RoleListScreen.dart';
import 'package:menuboss/presentation/features/main/my/team/create/TeamCreateScreen.dart';
import 'package:menuboss/presentation/features/main/my/team/list/TeamListScreen.dart';
import 'package:menuboss/presentation/features/media_content/MediaContentScreen.dart';
import 'package:menuboss/presentation/features/media_info/MediaInformationScreen.dart';
import 'package:menuboss/presentation/features/preview/PreviewPlaylistScreen.dart';
import 'package:menuboss/presentation/features/scan_qr/ScanQrScreen.dart';
import 'package:menuboss/presentation/features/select/destination_folder/DestinationFolderScreen.dart';
import 'package:menuboss/presentation/features/select/media_file/SelectMediaFileScreen.dart';
import 'package:menuboss/presentation/features/select/media_file/in_folder/SelectMediaInFolderScreen.dart';
import 'package:menuboss/presentation/features/select/playlist/SelectPlaylistScreen.dart';
import 'package:menuboss/presentation/features/signup/SignUpScreen.dart';
import 'package:menuboss/presentation/features/splash/SplashScreen.dart';

import '../data/models/me/RequestMeSocialJoinModel.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  Login(route: "/login"), // 로그인
  SignUp(route: "/signup"), // 회원가입
  Main(route: "/main"), // 메인

  ScanQR(route: "/scan/qr"), // Scan QR 코드 인식
  MediaInfo(route: "/media/info"), // 미디어 정보
  MediaDetailInFolder(route: "/media/detail/folder"), // 미디어 폴더 내부 정보
  MediaContent(route: "/media/content"), // 미디어 콘텐츠 목록

  DetailPlaylist(route: "/detail/playlist"), // 플레이리스트 상세
  CreatePlaylist(route: "/create/playlist"), // 플레이리스트 만들기
  PreviewPlaylist(route: "/preview/playlist"), // 플레이리스트 미리보기

  DetailSchedule(route: "/detail/schedule"), // 스케줄 상세
  CreateSchedule(route: "/create/schedule"), // 스케줄 만들기

  SelectPlaylist(route: "/select/playlist"), // 플레이리스트 선택
  SelectMediaFile(route: "/select/media"), // 미디어 선택
  SelectMediaInFolder(route: "/select/media/folder"), // 미디어 선택 폴더 내부 정보
  SelectDestinationFolder(route: "/select/destination/folder"), // 폴더 선택

  ApplyDevice(route: "/apply/screen"), // 스크린에 적용
  MyProfile(route: "/my/profile"), // 프로필 정보
  MyPassword(route: "/my/password"), // 내 비밀번호
  MyAccount(route: "/my/account"), // 내 계정 정보
  MyBusiness(route: "/my/business"), // 내 비즈니스 정보
  TeamList(route: "/my/team/list"), // 팀 목록
  TeamCreate(route: "/my/team/create"), // 팀 생성
  RoleList(route: "/my/role/list"), // 역할 목록
  RoleCreate(route: "/my/role/create"), // 역할 생성
  GuideList(route: "/my/guide/list"), // 사용방법 목록
  GuideDetail(route: "/my/guide/detail"), // 사용방법 상세
  DeleteAccount(route: "/delete/account"); // 계정 삭제

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.Login.route: (context) => const LoginScreen(),
      RoutingScreen.SignUp.route: (context) => const SignUpScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      RoutingScreen.ScanQR.route: (context) => const ScanQrScreen(),
      RoutingScreen.MediaInfo.route: (context) => const MediaInformationScreen(),
      RoutingScreen.MediaDetailInFolder.route: (context) => const MediaInFolderScreen(),
      RoutingScreen.MediaContent.route: (context) => const MediaContentScreen(),
      RoutingScreen.DetailPlaylist.route: (context) => const DetailPlaylistScreen(),
      RoutingScreen.CreatePlaylist.route: (context) => const CreatePlaylistScreen(),
      RoutingScreen.PreviewPlaylist.route: (context) => const PreviewPlaylistScreen(),
      RoutingScreen.DetailSchedule.route: (context) => const DetailScheduleScreen(),
      RoutingScreen.CreateSchedule.route: (context) => const CreateScheduleScreen(),
      RoutingScreen.SelectPlaylist.route: (context) => const SelectPlaylistScreen(),
      RoutingScreen.SelectMediaFile.route: (context) => const SelectMediaFileScreen(),
      RoutingScreen.SelectMediaInFolder.route: (context) => const SelectMediaInFolderScreen(),
      RoutingScreen.SelectDestinationFolder.route: (context) => const DestinationFolderScreen(),
      RoutingScreen.ApplyDevice.route: (context) => const ApplyToDeviceScreen(),
      RoutingScreen.MyProfile.route: (context) => const MyProfileScreen(),
      RoutingScreen.MyAccount.route: (context) => const MyAccountScreen(),
      RoutingScreen.MyBusiness.route: (context) => const MyBusinessScreen(),
      RoutingScreen.TeamList.route: (context) => const TeamListScreen(),
      RoutingScreen.TeamCreate.route: (context) => const TeamCreateScreen(),
      RoutingScreen.RoleList.route: (context) => const RoleListScreen(),
      RoutingScreen.RoleCreate.route: (context) => const RoleCreateScreen(),
      RoutingScreen.MyPassword.route: (context) => const MyPasswordScreen(),
      RoutingScreen.GuideList.route: (context) => const GuideListScreen(),
      RoutingScreen.GuideDetail.route: (context) => const GuideDetailScreen(),
      RoutingScreen.DeleteAccount.route: (context) => const DeleteAccountScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter, dynamic parameter1}) {
    if (route == RoutingScreen.Splash.route) {
      return const SplashScreen();
    } else if (route == RoutingScreen.Login.route) {
      return const LoginScreen();
    } else if (route == RoutingScreen.SignUp.route) {
      RequestMeSocialJoinModel? socialJoinModel = parameter;
      String? socialEmail = parameter1;
      return SignUpScreen(socialJoinModel: socialJoinModel, socialEmail: socialEmail);
    } else if (route == RoutingScreen.Main.route) {
      return const MainScreen();
    } else if (route == RoutingScreen.ScanQR.route) {
      return const ScanQrScreen();
    } else if (route == RoutingScreen.MediaInfo.route) {
      ResponseMediaModel model = parameter;
      return MediaInformationScreen(item: model);
    } else if (route == RoutingScreen.MediaContent.route) {
      return const MediaContentScreen();
    } else if (route == RoutingScreen.MediaDetailInFolder.route) {
      ResponseMediaModel mediaInfo = parameter;
      return MediaInFolderScreen(item: mediaInfo);
    } else if (route == RoutingScreen.DetailPlaylist.route) {
      ResponsePlaylistsModel model = parameter;
      return DetailPlaylistScreen(item: model);
    } else if (route == RoutingScreen.CreatePlaylist.route) {
      ResponsePlaylistModel? model = parameter;
      return CreatePlaylistScreen(item: model);
    } else if (route == RoutingScreen.PreviewPlaylist.route) {
      return const PreviewPlaylistScreen();
    } else if (route == RoutingScreen.DetailSchedule.route) {
      ResponseSchedulesModel model = parameter;
      return DetailScheduleScreen(item: model);
    } else if (route == RoutingScreen.CreateSchedule.route) {
      ResponseScheduleModel? model = parameter;
      return CreateScheduleScreen(item: model);
    } else if (route == RoutingScreen.SelectPlaylist.route) {
      SelectedPlaylistInfo? info = parameter;
      return SelectPlaylistScreen(selectedPlaylistInfo: info);
    } else if (route == RoutingScreen.SelectMediaFile.route) {
      return const SelectMediaFileScreen();
    } else if (route == RoutingScreen.SelectMediaInFolder.route) {
      ResponseMediaModel mediaInfo = parameter;
      return SelectMediaInFolderScreen(item: mediaInfo);
    } else if (route == RoutingScreen.SelectDestinationFolder.route) {
      List<String> mediaIds = parameter;
      return DestinationFolderScreen(mediaIds: mediaIds);
    } else if (route == RoutingScreen.ApplyDevice.route) {
      RequestDeviceApplyContents model = parameter;
      return ApplyToDeviceScreen(item: model);
    } else if (route == RoutingScreen.MyProfile.route) {
      return const MyProfileScreen();
    } else if (route == RoutingScreen.MyPassword.route) {
      return const MyPasswordScreen();
    } else if (route == RoutingScreen.MyAccount.route) {
      return const MyAccountScreen();
    } else if (route == RoutingScreen.MyBusiness.route) {
      return const MyBusinessScreen();
    } else if (route == RoutingScreen.TeamList.route) {
      return const TeamListScreen();
    } else if (route == RoutingScreen.TeamCreate.route) {
      ResponseBusinessMemberModel? model = parameter;
      return TeamCreateScreen(item: model);
    } else if (route == RoutingScreen.RoleList.route) {
      return const RoleListScreen();
    } else if (route == RoutingScreen.RoleCreate.route) {
      ResponseRoleModel? model = parameter;
      return RoleCreateScreen(item: model);
    } else if (route == RoutingScreen.GuideList.route) {
      return const GuideListScreen();
    } else if (route == RoutingScreen.GuideDetail.route) {
      GuideType type = parameter;
      return GuideDetailScreen(type: type);
    } else if (route == RoutingScreen.DeleteAccount.route) {
      return const DeleteAccountScreen();
    } else {
      return const SplashScreen();
    }
  }
}
