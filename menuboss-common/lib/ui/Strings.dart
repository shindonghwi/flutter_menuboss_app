import 'package:flutter/material.dart';

class Strings {
  final Locale locale;

  Strings(this.locale);

  static Strings of(BuildContext? context) {
    if (context == null) {
      return Strings(const Locale('en'));
    }
    Locale locale = Localizations.localeOf(context);
    return Strings(locale);
  }

  bool isKr() => locale.languageCode == 'ko';

  String _localizedValue(String key) {
    Map<String, String> localizedStrings = {
      'appTitle': isKr() ? '메뉴보스' : 'MenuBoss',

      'login_title': isKr() ? '로그인' : 'Login',
      'login_welcome': isKr() ? '반갑습니다! 회원 정보를 입력해주세요' : 'Welcome! Please enter your details',
      'login_no_account': isKr() ? '메뉴보스가 처음이신가요?' : 'No account?',
      'login_email_correct': isKr() ? '올바른 이메일 입니다' : 'This is a valid email address',
      'login_email_invalid': isKr() ? '올바른 이메일을 입력해주세요' : 'Email address entered incorrectly',
      'login_pw_invalid': isKr() ? 'a-z, A-Z, 0-9, 4~20 자리' : 'a-z, A-Z, 0-9, 4 to 20 characters',

      'signup_full_name_hint': isKr() ? '이름을 입력해주세요' : 'Please enter your name',
      'signup_business_name': isKr() ? '사업자 이름' : 'Business name',
      'signup_business_name_hint': isKr() ? '사업자 이름을 입력해주세요' : 'Please enter a business name',

      'policy_title': isKr() ? '약관동의' : '',
      'policy_description_title': isKr() ? '회원가입' : '',
      'policy_description': isKr() ? '서비스 시작을 위해 가입 및 정보 제공에 동의해주세요' : '',
      'policy_term1': isKr() ? '(필수) 만 14세 이상입니다' : '',
      'policy_term2': isKr() ? '(필수) 이용약관 동의' : '',
      'policy_term3': isKr() ? '(필수) 개인정보 수집 및 이용 동의' : '',
      'policy_term4': isKr() ? '(선택) 마케팅 개인정보 제3자 제공 동의' : '',

      'main_navigation_menu_schedules': isKr() ? '시간표' : 'Schedules',
      'main_navigation_menu_playlists': isKr() ? '재생목록' : 'Playlists',
      'main_navigation_menu_screens': isKr() ? 'TV' : 'Screens',
      'main_navigation_menu_media': isKr() ? '보관함' : 'Media',
      'main_navigation_menu_my': isKr() ? '내 정보' : 'My',

      'scan_qr_title': isKr() ? 'QR 코드 인식' : 'Scan QR code',
      'scan_qr_enter_pin_code': isKr() ? 'PIN 번호 입력' : 'Enter PIN code',
      'scan_qr_description':
          isKr() ? 'TV 화면에 보이는\nQR 코드를 인식해주세요' : 'Scan the QR code you see\non the TV screen',

      'apply_screen_title': isKr() ? 'TV에 적용' : 'Apply to Screens',

      'create_playlist_title': isKr() ? '재생목록 생성' : 'Create playlist',
      'create_playlist_title_input': isKr() ? '제목을 입력해주세요' : 'Please enter a title',

      'select_playlist_title': isKr() ? '재생목록' : 'Playlist',

      'destination_folder_title': isKr() ? '폴더 선택' : 'Select folder',
      'destination_folder_root': isKr() ? '보관함' : 'Media',

      'create_schedule_title': isKr() ? '시간표 생성' : 'Create schedule',
      'create_schedule_title_input': isKr() ? '제목을 입력해주세요' : 'Please enter a title',
      'create_schedule_default_playlist_title_basic': isKr() ? '기본' : 'Basic',
      'create_schedule_default_playlist_title_morning': isKr() ? '아침' : 'Morning',
      'create_schedule_default_playlist_title_lunch': isKr() ? '점심' : 'Lunch',
      'create_schedule_default_playlist_title_dinner': isKr() ? '저녁' : 'Dinner',
      'create_schedule_add_playlist': isKr() ? '재생목록 추가' : 'Add Playlist',
      'create_schedule_change_playlist': isKr() ? '재생목록 변경' : 'Change Playlist',
      'create_schedule_new_playlist': isKr() ? '새 재생목록' : 'New playlist',

      'edit_playlist_title': isKr() ? '재생목록 수정' : 'Edit playlist',
      'edit_schedule_title': isKr() ? '시간표 수정' : 'Edit schedule',

      'my_page_setting_item_title': isKr() ? '설정' : 'Settings',
      'my_page_setting_item_submenu_team': isKr() ? '구성원' : 'Team',
      'my_page_setting_item_submenu_role': isKr() ? '역할' : 'Roles',
      'my_page_setting_item_title_user': isKr() ? '사용자 설정' : 'User Settings',
      'my_page_setting_item_submenu_my': isKr() ? '내 정보' : 'My account',
      'my_page_setting_item_submenu_business': isKr() ? '사업자' : 'Business',
      'my_page_setting_item_title_guide': isKr() ? '가이드' : 'Guide',
      'my_page_setting_item_submenu_menual': isKr() ? '사용방법' : 'Get started',

      'my_page_profile_appbar_title': isKr() ? '프로필' : 'Profile',
      'my_page_profile_business_name': isKr() ? '비즈니스 이름' : 'Business name',
      'my_page_profile_delete_account': isKr() ? '탈퇴하기' : 'Delete account',

      'guide_list_title': isKr() ? '사용방법' : 'Get started',
      'guide_list_item_device_title': isKr() ? 'TV' : 'Screen',
      'guide_list_item_device_description': isKr() ? 'TV를 추가하고 관리' : 'Add and manage screens',
      'guide_list_item_schedule_title': isKr() ? '시간표' : 'Schedule',
      'guide_list_item_schedule_description':
          isKr() ? '시간별로 TV 화면을 다르게 설정' : 'Set the screen differently by time',
      'guide_list_item_playlist_title': isKr() ? '재생목록' : 'Playlist',
      'guide_list_item_playlist_description':
          isKr() ? '콘텐츠 순서를 정렬하고 시간 설정' : 'Sort and time content',
      'guide_list_item_media_title': isKr() ? '보관함' : 'Media',
      'guide_list_item_media_description':
          isKr() ? '파일 업로드 및 이동, 상세보기' : 'Upload and move files, view more',
      'guide_list_detail_view':
          isKr() ? '모바일 앱 가이드 자세히 보기' : 'Learn more about the mobile app guide',

      'guide_detail_device_1_title': isKr() ? '1. TV앱 다운로드' : '1. Screen app download',
      'guide_detail_device_1_description': isKr()
          ? '구글 플레이스토어에서 [MenuBossTV - Digital Signage All in one Service] 다운받아주세요'
          : '[MenuBossTV - Digital Signage All in one Service] from Amazon App Store',
      'guide_detail_device_1_sub_description_1':
          isKr() ? '· 리모컨 역할 : 모바일 휴대폰 또는 태블릿' : '· Controller : Mobile phone or tablet',
      'guide_detail_device_1_sub_description_2':
          isKr() ? '· 디지털 메뉴판 역할 : TV' : '· Digital Signage : TV Screen',
      'guide_detail_device_2_title':
          isKr() ? '2. TV 연결 - QR 코드 스캔 / PIN 번호 입력' : '2. Screen Connect - QR code / PIN code',
      'guide_detail_device_2_description':
          isKr() ? '두 가지 방법을 통해 TV와 모바일 앱을 연결해주세요' : 'Please connect the TV screen and mobile app',
      'guide_detail_device_3_title': isKr() ? '3. TV에 이름 표시' : '3. Display Screen Name',
      'guide_detail_device_3_description': isKr()
          ? 'TV화면 구분이 어려울 경우, 더보기의 [TV에 이름 표시] 기능을 이용해서 TV를 구분할 수 있습니다'
          : 'You can distinguish the screen using the [Screen Display Name] function',

      'guide_detail_schedule_1_title': isKr() ? '1. 시간표 만들기' : '1. Create schedule',
      'guide_detail_schedule_1_description': isKr()
          ? '시간표에 재생목록을 추가하고 해당 시간을 설정할 수 있습니다'
          : 'Add playlists to your schedule and set their time',
      'guide_detail_schedule_1_sub_description_1': isKr()
          ? '· 기본 설정은 시간을 수정하거나 삭제할 수 없습니다'
          : '· Default setting basics cannot be time modified or deleted',
      'guide_detail_schedule_2_title': isKr() ? '2. TV에 시간표 적용' : '2. Connect to screen',
      'guide_detail_schedule_2_description': isKr()
          ? '[TV 적용] 버튼을 누르고 TV를 선택하면 연결완료!'
          : 'Press the [Apply] button and select the screen',
      'guide_detail_schedule_3_title': isKr() ? '3. 시간표 수정' : '3. Edit schedule',
      'guide_detail_schedule_3_description': isKr()
          ? '하단의 [+] 버튼을 통해 새 재생목록을 추가하고 시간 수정 및 삭제할 수 있습니다'
          : 'Additional schedules can be added via the [plus] button at the bottom',

      'guide_detail_playlist_1_title': isKr() ? '1. 재생목록 만들기' : '1. Create playlist',
      'guide_detail_playlist_1_description': isKr()
          ? '콘텐츠의 순서를 정렬하고 옵션을 통해 화면 모양을 원하는대로 설정할 수 있습니다'
          : 'Sort the order of the content, and use the options to set the appearance of the screen',
      'guide_detail_playlist_1_sub_description_1': isKr()
          ? '· 옵션 : 가로 / 세로 그리고 채우기 / 맞추기 / 늘리기'
          : '· Option : Horizontal / Vertical and Fill / Fit / Stretch',
      'guide_detail_playlist_1_sub_description_2':
          isKr() ? '· 동영상은 시간 설정이 불가합니다' : '· It is not possible to set the time for videos',
      'guide_detail_playlist_2_title': isKr() ? '2. 미리보기' : '2. Preview',
      'guide_detail_playlist_2_description': isKr()
          ? '옵션의 [미리보기] 를 통해 TV 화면의 모습을 미리 볼 수 있습니다'
          : 'Set up or preview the screen through the optional preview',
      'guide_detail_playlist_3_title': isKr() ? '3. TV에 재생목록 적용' : '3. Connect to screen',
      'guide_detail_playlist_3_description': isKr()
          ? '[TV 적용] 버튼을 누르고 TV를 선택하면 연결완료!'
          : 'Press the [Apply] button and select the screen',

      'guide_detail_media_1_title': isKr() ? '1. 콘텐츠 파일 업로드' : '1. Upload media file',
      'guide_detail_media_1_description': isKr()
          ? '이미지, 동영상 파일을 업로드 하거나 새 폴더를 만들어 파일을 정리 할 수 있습니다'
          : 'Upload images and videos or organize files through folders',
      'guide_detail_media_1_sub_description_1': isKr()
          ? '· [+] : 새 폴더 만들기 / [체크 아이콘] : 파일 이동 및 삭제'
          : '· [Plus icon] : New folder / [Check icon] : Move files',
      'guide_detail_media_1_sub_description_2': isKr()
          ? '· 폴더 안에서 또 다른 폴더를 생성할 수 없습니다'
          : '· Creating a folder within a folder is not possible',
      'guide_detail_media_2_title': isKr() ? '2. 파일 상세' : '2. Create a folder and add file detail',
      'guide_detail_media_2_description': isKr()
          ? '업로드한 파일을 선택하면 해당 파일의 상세 정보를 볼 수 있습니다'
          : 'Select an uploaded file to view more information about the file',
      'guide_detail_media_3_title': isKr() ? '3. 파일 이동' : '3. Move media file',
      'guide_detail_media_3_description': isKr()
          ? '메인화면 상단의 [체크 아이콘] 을 선택하여 파일을 이동 및 삭제할 수 있습니다'
          : 'Move or delete files by selecting the [check icon] at the top of the main screen',

      'delete_account_title': isKr() ? '탈퇴' : 'Delete account',
      'delete_account_description':
          isKr() ? '메뉴보스를 탈퇴하시나요?' : 'Are you sure you want to delete your account?',
      'delete_account_description1': isKr()
          ? '탈퇴하시면 모든 정보와 데이터가 삭제됩니다.\n삭제하시려면 주의 사항을 확인하고 진행해 주세요'
          : 'When you delete your account, all of your information and data will be deleted.\nIf you want to delete it, please check the precautions and proceed',
      'delete_account_reason_title': isKr() ? '탈퇴 사유를 선택해주세요' : 'Reason for deleting your account',
      'delete_account_reason_menu1':
          isKr() ? '서비스를 자주 사용하지 않음' : "I don't use the service very often",
      'delete_account_reason_menu2': isKr() ? '서비스가 불편함' : 'Service is inconvenient',
      'delete_account_reason_menu3': isKr() ? '사용하기 어려움' : "It's hard to use",
      'delete_account_reason_menu4': isKr() ? '기타' : 'Other',
      'delete_account_reason_menu4_hint':
          isKr() ? '탈퇴 이유를 알려주세요' : 'Please tell me why you want to quit',

      'media_info_title': isKr() ? '미디어 정보' : 'Media Information',
      'media_info_menu_title': isKr() ? '정보' : 'Information',
      'media_info_menu_input_title': isKr() ? '제목' : 'Title',
      'media_info_menu_input_file_name_hint': isKr() ? '파일 이름 입력' : 'Input file name',
      'media_info_menu_register_date': isKr() ? '업로드 날짜' : 'Uploaded date',
      'media_info_menu_file_size': isKr() ? '파일 크기' : 'File size',
      'media_info_menu_file_type': isKr() ? '파일 유형' : 'File type',
      'media_info_menu_file_capacity': isKr() ? '파일 용량' : 'File capacity',
      'media_info_menu_file_codec': isKr() ? '코덱' : 'Codec',
      'media_info_menu_file_running_time': isKr() ? '재생 시간' : 'Running time',

      'media_content_title': isKr() ? '콘텐츠' : 'Contents',
      'media_content_tab_media': isKr() ? '미디어' : 'Media',
      'media_content_tab_canvas': isKr() ? '캔버스' : 'Canvas',

      'bottom_sheet_pin_code_description': isKr() ? 'PIN 코드를 입력하세요' : 'Please enter your PIN code',
      'bottom_sheet_menu_display_show_name': isKr() ? '화면 이름 표시' : 'Display screen name',

      'tutorial_screen_add_new': isKr() ? 'TV를 추가해서 등록해주세요' : 'Add and register a new screen',
      'tutorial_screen_enter_pin_code': isKr()
          ? 'QR 코드를 스캔하거나\nPIN 번호를 입력해 주세요'
          : 'Scan the QR code or\nplease enter the PIN code',
      'tutorial_screen_description1': isKr()
          ? 'TV의 On, Off 상태와 TV 화면에 연결된\n시간표, 재생목록을 살펴볼 수 있습니다'
          : 'Through On and Off of the screen\nyou can check the status of the screen',
      'tutorial_screen_description2': isKr()
          ? '자세히보기 아이콘을 눌러 [TV에 이름 표시]을 통해\nTV 화면에 이름을 표시하거나 수정 및 삭제가 가능합니다'
          : 'Display your name on the screen via the\n[More] icon or editing and deletion are possible',

      'tutorial_playlist_add_new': isKr() ? '재생목록을 추가해서 등록해주세요' : 'Add and register a new playlist',
      'tutorial_playlist_description1':
          isKr() ? '재생목록의 제목을 입력해주세요' : 'Please write the title of the playlist',
      'tutorial_playlist_description2':
          isKr() ? '옵션에서 TV 화면의 모습을 설정할 수 있습니다' : 'Set the playlist settings in the options',
      'tutorial_playlist_description3':
          isKr() ? '콘텐츠를 추가 및 정렬하고 시간 설정이 가능합니다' : 'Add and sort content, set time',
      'tutorial_playlist_description4': isKr()
          ? '연결할 재생목록의 [TV 적용] 버튼을 누르고\n켜져있는 TV를 선택하면, TV와 재생목록 연결 완료!'
          : 'Press the [Apply] button to select the screen\nthat is turned on. Screen and playlist connected!',
      'tutorial_playlist_description5':
          isKr() ? '[+] 버튼을 눌러 새 재생목록을 만들 수 있습니다' : 'Press the [Plus] button to add a new playlist',

      'tutorial_schedule_add_new': isKr() ? '시간표를 추가해서 등록해주세요' : 'Add and register a new schedule',
      'tutorial_schedule_description1':
          isKr() ? '시간표의 제목을 입력해주세요' : 'Please write the title of the schedule',
      'tutorial_schedule_description2': isKr()
          ? '1. 재생목록 추가 2. 시간 설정하고 휴지통 아이콘을\n눌러 해당 재생목록을 삭제 할 수 있습니다'
          : '1. Add playlist 2. Schedule by setting time\nYou can delete it using the trash can icon',
      'tutorial_schedule_description3': isKr()
          ? '연결할 시간표의 [TV 적용] 버튼을 누르고\n켜져있는 TV를 선택하면, TV와 시간표 연결 완료!'
          : 'Press the [Apply] button to select the screen\nthat is turned on. Screen and schedule connected!',
      'tutorial_schedule_description4':
          isKr() ? '[+] 버튼을 눌러 새 시간표를 만들 수 있습니다' : 'Press the [Plus] button to add a new schedule',

      'tutorial_media_add_new': isKr() ? '이미지, 동영상 파일을 업로드해주세요' : 'Upload image and video files',
      'tutorial_media_description1': isKr() ? '새 폴더 만들기' : 'Create a new folder',
      'tutorial_media_description2':
          isKr() ? '파일 또는 폴더를 선택한 뒤 이동 및 삭제가 가능합니다' : 'Select, move, and delete files and folders',
      'tutorial_media_description3':
          isKr() ? '[+] 버튼을 눌러 파일을 업로드할 수 있습니다' : 'Press the [Plus] button to upload file',
      'tutorial_media_description4': isKr() ? '폴더 이름 수정' : 'Editing folder name',
      'tutorial_media_description5': isKr() ? '폴더 삭제' : 'Delete folder',
      'tutorial_media_description6':
          isKr() ? '파일을 선택하면 해당 파일의 상세 정보를 볼 수 있습니다' : 'Select a file to see detailed information',

      'blank_message_content_add_screen': isKr() ? 'TV 추가' : 'New screen',
      'blank_message_content_upload_file': isKr() ? '파일 업로드' : 'Upload file',
      'blank_message_content_add_content': isKr() ? '콘텐츠 추가' : 'Add content',
      'blank_message_content_add_canvas': isKr() ? '캔버스 추가' : 'Add canvas',
      'blank_message_content_new_schedule': isKr() ? '시간표 추가' : 'New schedule',
      'blank_message_content_new_playlist': isKr() ? '재생목록 추가' : 'New playlist',
      'blank_message_description_add_screen': isKr()
          ? '현재 저장된 TV목록이 없습니다\nQR코드 인식을 통해 TV를 만들어주세요'
          : 'There are currently no saved screen list\nPlease register the screen through QR code',
      'blank_message_description_add_canvas': isKr()
          ? '현재 저장된 캔버스 없습니다\n캔버스를 만들어 추가해주세요'
          : 'There are currently no saved canvases\nPlease create and add a canvas',
      'blank_message_description_new_schedule': isKr()
          ? '현재 저장된 시간표가 없습니다\n시간표를 추가하여 만들어주세요'
          : 'There are currently no saved schedules\nPlease add a schedule to create one',
      'blank_message_description_new_playlist': isKr()
          ? '현재 저장된 재생목록이 없습니다\n재생목록을 추가하여 만들어주세요'
          : 'There are currently no saved playlists\nPlease add a playlist to create one',
      "blank_message_description_upload_file": isKr()
          ? "현재 저장된 파일 및 폴더가 없습니다\n파일 또는 폴더를 추가하여 만들어주세요"
          : "There are no current files or folders\nPlease create a file or folder",

      'popup_rename_title': isKr() ? '이름 변경' : 'Rename',
      'popup_rename_screen_hint': isKr() ? 'TV 이름을 입력해주세요' : 'Enter Screen name',
      'popup_rename_media_hint': isKr() ? '미디어 이름' : 'Media name',
      'popup_rename_schedule_hint': isKr() ? '시간표 이름' : 'Schedule name',
      'popup_rename_playlist_hint': isKr() ? '재생목록 이름' : 'Playlist name',
      'popup_delete_title': isKr() ? '정말로 삭제하시겠습니까?' : 'Are you sure?',
      'popup_delete_description': isKr()
          ? '이 레코드를 정말로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다'
          : 'Do you really want to delete these records?\nThis process cannot be undone',
      'popup_apply_screen_title': isKr() ? '스크린에 적용하시겠습니까?' : 'Apply to screens?',
      'popup_apply_screen_description': isKr()
          ? '이것을 스크린에 직접 적용하시겠습니까?'
          : 'Are you sure you want to apply it directly to the screens?',
      'popup_logout_description': isKr() ? '로그아웃 하시겠습니까?' : 'Are you sure you want to log out?',
      'popup_change_duration_title':
          isKr() ? '미디어의 지속 시간을 입력하세요' : 'Please enter the duration\nof the media',
      'popup_delete_account_title': isKr() ? '계정 삭제 완료!' : 'Delete account completed!',
      'popup_delete_account_description': isKr()
          ? '계정 삭제가 성공적으로 완료되었습니다. 다음에 다시 만나요'
          : 'Account deletion completed successfully. See you next time',

      // Common Strings
      'common_email': isKr() ? '이메일' : 'Email',
      'common_password': isKr() ? '비밀번호' : 'Password',
      'common_option': isKr() ? '옵션' : 'Option',
      'common_refresh': isKr() ? '새로 고침' : 'Refresh',
      'common_title': isKr() ? '제목' : 'Title',
      'common_total_duration': isKr() ? '총 재생 시간' : 'Total duration',
      'common_add': isKr() ? '추가' : 'Add',
      'common_horizontal': isKr() ? '가로' : 'Horizontal',
      'common_vertical': isKr() ? '세로' : 'Vertical',
      'common_fit': isKr() ? '맞추기' : 'Fit',
      'common_stretch': isKr() ? '늘리기' : 'Stretch',
      'common_fill': isKr() ? '채우기' : 'Fill',
      'common_sign_up': isKr() ? '회원가입' : 'Sign up',
      'common_on': isKr() ? 'On' : 'On',
      'common_off': isKr() ? 'Off' : 'Off',
      'common_or': isKr() ? '또는' : 'or',
      'common_done': isKr() ? '완료' : 'Done',
      'common_next': isKr() ? '다음' : 'Next',
      'common_do_login': isKr() ? '로그인' : 'Log in',
      'common_connect_screen': isKr() ? 'TV 적용' : 'Apply',
      'common_confirm': isKr() ? '확인' : 'Confirm',
      'common_rename': isKr() ? '이름 변경' : 'Rename',
      'common_logout': isKr() ? '로그아웃' : 'Log out',
      'common_ok': isKr() ? '확인' : 'Ok',
      'common_cancel': isKr() ? '취소' : 'Cancel',
      'common_preview': isKr() ? '미리보기' : 'Preview',
      'common_move': isKr() ? '이동' : 'Move',
      'common_new_folder': isKr() ? '새 폴더' : 'New folder',
      'common_move_here': isKr() ? '여기로 이동' : 'Move here',
      'common_delete': isKr() ? '삭제' : 'Delete',
      'common_save': isKr() ? '저장' : 'Save',
      'common_time': isKr() ? '시간' : 'Time',
      'common_full_name': isKr() ? '이름' : 'Full name',
      'common_updated': isKr() ? '수정일' : 'Updated',
      'common_back': isKr() ? '뒤로가기' : 'Back',
      'common_image': isKr() ? '이미지' : 'image',
      'common_video': isKr() ? '비디오' : 'video',
      'common_canvas': isKr() ? '캔버스' : 'canvas',
      'common_folder': isKr() ? '폴더' : 'folder',
      'common_all_agree': isKr() ? '전체동의' : '',

      // Filter Keys and Values
      'filter_key_name_asc': "name_asc",
      'filter_key_name_desc': "name_desc",
      'filter_key_newest_first': "created_desc",
      'filter_key_oldest_first': "created_asc",
      'filter_value_name_asc': isKr() ? "이름 (오름차순)" : "Name (A->Z)",
      'filter_value_name_desc': isKr() ? "이름 (내림차순)" : "Name (Z->A)",
      'filter_value_newest_first': isKr() ? "최신 순" : "Newest First",
      'filter_value_oldest_first': isKr() ? "오래된 순" : "Oldest First",

      // Messages
      'message_server_error_5xx': isKr()
          ? '데이터를 불러오는 중 오류가 발생했습니다.\n다시 사용해주세요'
          : 'An error occurred while loading data.\nPlease use it again',
      'message_file_not_found_404':
          isKr() ? '파일을 찾을 수 없습니다\n잠시후에 다시 시도해주세요' : 'File not found.\nPlease use it again',
      'message_file_not_allow_404': isKr()
          ? '허용되지 않는 파일 확장자입니다.\n다시 사용해주세요'
          : 'File extension you do not allowed.\nPlease use it again',
      'message_permission_error_photos': isKr()
          ? '미디어 파일을 업로드하려면 사진 및 비디오 권한이 필요합니다'
          : 'You need photo and video permissions to upload media files',
      'message_network_required': isKr() ? '네트워크 연결이 불안정합니다' : 'The network connection is unstable',
      'message_operation_timeout': isKr()
          ? '작업이 너무 지연되고 있습니다.\n잠시 후에 다시 시도해주세요'
          : 'Operation is being delayed too much.\nPlease try again in a few minutes',
      'message_not_found_user': isKr() ? '사용자 정보를 찾을 수 없습니다' : 'User information not found',
      'message_add_media_content': isKr() ? '콘텐츠를 추가해주세요' : 'Please add media content',
      'message_api_success': '',
      'message_temp_login_fail': isKr()
          ? '일시적인 장애가 발생하였습니다\n다른 로그인 방법을 사용해주세요'
          : 'A temporary failure has occurred.\nPlease use a different login method',
      'message_time_setting_precede':
          isKr() ? '종료시간은 시작 시간보다 빠를수 없습니다' : 'End time cannot precede start time',
      'message_time_setting_duplicated':
          isKr() ? '중복된 시간을 수정해주세요' : 'Please correct the duplicate time',
      'message_apply_screen_success': isKr() ? 'TV에 적용되었습니다' : 'Successfully applied to screens',
      'message_register_screen_success':
          isKr() ? 'TV 등록에 성공했습니다' : 'Successfully added to the screens',
      'message_remove_playlist_success':
          isKr() ? '재생목록 삭제에 성공했습니다' : 'Playlist deleted successfully',
      'message_register_playlist_success':
          isKr() ? '재생목록 등록에 성공했습니다' : 'Playlist registered successfully',
      'message_update_playlist_success':
          isKr() ? '재생목록 정보가 변경되었습니다' : 'Playlist information has been changed',
      'message_add_media_in_playlist_success':
          isKr() ? '재생목록에 추가되었습니다' : 'Successfully Add Media to Playlist',
      'message_remove_schedule_success':
          isKr() ? '시간표 삭제에 성공했습니다' : 'Schedule deleted successfully',
      'message_register_schedule_success':
          isKr() ? '시간표 등록에 성공했습니다' : 'Schedule registered successfully',
      'message_update_schedule_success':
          isKr() ? '시간표 정보가 변경되었습니다' : 'Schedule information has been changed',
      'message_remove_media_success':
          isKr() ? '미디어 파일 삭제에 성공했습니다' : 'Media file deleted successfully',
      'message_send_event_name_show_success':
          isKr() ? '스크린에 이름을 표시하였습니다' : 'Successfully Send show name event to Screen',
    };

    return localizedStrings[key] ?? "Not Found";
  }

  String get appTitle => _localizedValue('appTitle');

  String get loginTitle => _localizedValue('login_title');

  String get loginWelcome => _localizedValue('login_welcome');

  String get loginNoAccount => _localizedValue('login_no_account');

  String get loginEmailCorrect => _localizedValue('login_email_correct');

  String get loginEmailInvalid => _localizedValue('login_email_invalid');

  String get loginPwInvalid => _localizedValue('login_pw_invalid');

  String get signupFullNameHint => _localizedValue('signup_full_name_hint');

  String get signupBusinessName => _localizedValue('signup_business_name');

  String get signupBusinessNameHint => _localizedValue('signup_business_name_hint');

  String get policyTitle => _localizedValue('policy_title');

  String get policyDescriptionTitle => _localizedValue('policy_description_title');

  String get policyDescription => _localizedValue('policy_description');

  String get policyTerm1 => _localizedValue('policy_term1');

  String get policyTerm2 => _localizedValue('policy_term2');

  String get policyTerm3 => _localizedValue('policy_term3');

  String get policyTerm4 => _localizedValue('policy_term4');

  String get mainNavigationMenuSchedules => _localizedValue('main_navigation_menu_schedules');

  String get mainNavigationMenuPlaylists => _localizedValue('main_navigation_menu_playlists');

  String get mainNavigationMenuScreens => _localizedValue('main_navigation_menu_screens');

  String get mainNavigationMenuMedia => _localizedValue('main_navigation_menu_media');

  String get mainNavigationMenuMy => _localizedValue('main_navigation_menu_my');

  String get scanQrTitle => _localizedValue('scan_qr_title');

  String get scanQrEnterPinCode => _localizedValue('scan_qr_enter_pin_code');

  String get scanQrDescription => _localizedValue('scan_qr_description');

  String get applyScreenTitle => _localizedValue('apply_screen_title');

  String get createPlaylistTitle => _localizedValue('create_playlist_title');

  String get createPlaylistTitleInput => _localizedValue('create_playlist_title_input');

  String get selectPlaylistTitle => _localizedValue('select_playlist_title');

  String get destinationFolderTitle => _localizedValue('destination_folder_title');

  String get destinationFolderRoot => _localizedValue('destination_folder_root');

  String get createScheduleTitle => _localizedValue('create_schedule_title');

  String get createScheduleTitleInput => _localizedValue('create_schedule_title_input');

  String get createScheduleDefaultPlaylistTitleBasic =>
      _localizedValue('create_schedule_default_playlist_title_basic');

  String get createScheduleDefaultPlaylistTitleMorning =>
      _localizedValue('create_schedule_default_playlist_title_morning');

  String get createScheduleDefaultPlaylistTitleLunch =>
      _localizedValue('create_schedule_default_playlist_title_lunch');

  String get createScheduleDefaultPlaylistTitleDinner =>
      _localizedValue('create_schedule_default_playlist_title_dinner');

  String get createScheduleAddPlaylist => _localizedValue('create_schedule_add_playlist');

  String get createScheduleChangePlaylist => _localizedValue('create_schedule_change_playlist');

  String get createScheduleNewPlaylist => _localizedValue('create_schedule_new_playlist');

  String get editPlaylistTitle => _localizedValue('edit_playlist_title');

  String get editScheduleTitle => _localizedValue('edit_schedule_title');

  String get myPageSettingItemTitle => _localizedValue('my_page_setting_item_title');

  String get myPageSettingSubmenuTeam => _localizedValue('my_page_setting_item_submenu_team');

  String get myPageSettingSubmenuRole => _localizedValue('my_page_setting_item_submenu_role');

  String get myPageSettingItemTitleUser => _localizedValue('my_page_setting_item_title_user');

  String get myPageSettingSubmenuMy => _localizedValue('my_page_setting_item_submenu_my');

  String get myPageSettingSubmenuBusiness =>
      _localizedValue('my_page_setting_item_submenu_business');

  String get myPageSettingSubmenuGuide => _localizedValue('my_page_setting_item_title_guide');

  String get myPageSettingSubmenuMenual => _localizedValue('my_page_setting_item_submenu_menual');

  String get myPageProfileAppbarTitle => _localizedValue('my_page_profile_appbar_title');

  String get myPageProfileBusinessName => _localizedValue('my_page_profile_business_name');

  String get myPageProfileDeleteAccount => _localizedValue('my_page_profile_delete_account');

  String get guideListTitle => _localizedValue('guide_list_title');

  String get guideListItemDeviceTitle => _localizedValue('guide_list_item_device_title');

  String get guideListItemDeviceDescription =>
      _localizedValue('guide_list_item_device_description');

  String get guideListItemScheduleTitle => _localizedValue('guide_list_item_schedule_title');

  String get guideListItemScheduleDescription =>
      _localizedValue('guide_list_item_schedule_description');

  String get guideListItemPlaylistTitle => _localizedValue('guide_list_item_playlist_title');

  String get guideListItemPlaylistDescription =>
      _localizedValue('guide_list_item_playlist_description');

  String get guideListItemMediaTitle => _localizedValue('guide_list_item_media_title');

  String get guideListItemMediaDescription => _localizedValue('guide_list_item_media_description');

  String get guideListDetailView => _localizedValue('guide_list_detail_view');

  String get guideDetailDevice1Title => _localizedValue('guide_detail_device_1_title');

  String get guideDetailDevice1Description => _localizedValue('guide_detail_device_1_description');

  String get guideDetailDevice1SubDescription1 =>
      _localizedValue('guide_detail_device_1_sub_description_1');

  String get guideDetailDevice1SubDescription2 =>
      _localizedValue('guide_detail_device_1_sub_description_2');

  String get guideDetailDevice2Title => _localizedValue('guide_detail_device_2_title');

  String get guideDetailDevice2Description => _localizedValue('guide_detail_device_2_description');

  String get guideDetailDevice3Title => _localizedValue('guide_detail_device_3_title');

  String get guideDetailDevice3Description => _localizedValue('guide_detail_device_3_description');

  String get guideDetailSchedule1Title => _localizedValue('guide_detail_schedule_1_title');

  String get guideDetailSchedule1Description =>
      _localizedValue('guide_detail_schedule_1_description');

  String get guideDetailSchedule1SubDescription1 =>
      _localizedValue('guide_detail_schedule_1_sub_description_1');

  String get guideDetailSchedule2Title => _localizedValue('guide_detail_schedule_2_title');

  String get guideDetailSchedule2Description =>
      _localizedValue('guide_detail_schedule_2_description');

  String get guideDetailSchedule3Title => _localizedValue('guide_detail_schedule_3_title');

  String get guideDetailSchedule3Description =>
      _localizedValue('guide_detail_schedule_3_description');

  String get guideDetailPlaylist1Title => _localizedValue('guide_detail_playlist_1_title');

  String get guideDetailPlaylist1Description =>
      _localizedValue('guide_detail_playlist_1_description');

  String get guideDetailPlaylist1SubDescription1 =>
      _localizedValue('guide_detail_playlist_1_sub_description_1');

  String get guideDetailPlaylist1SubDescription2 =>
      _localizedValue('guide_detail_playlist_1_sub_description_2');

  String get guideDetailPlaylist2Title => _localizedValue('guide_detail_playlist_2_title');

  String get guideDetailPlaylist2Description =>
      _localizedValue('guide_detail_playlist_2_description');

  String get guideDetailPlaylist3Title => _localizedValue('guide_detail_playlist_3_title');

  String get guideDetailPlaylist3Description =>
      _localizedValue('guide_detail_playlist_3_description');

  String get guideDetailMedia1Title => _localizedValue('guide_detail_media_1_title');

  String get guideDetailMedia1Description => _localizedValue('guide_detail_media_1_description');

  String get guideDetailMedia1SubDescription1 =>
      _localizedValue('guide_detail_media_1_sub_description_1');

  String get guideDetailMedia1SubDescription2 =>
      _localizedValue('guide_detail_media_1_sub_description_2');

  String get guideDetailMedia2Title => _localizedValue('guide_detail_media_2_title');

  String get guideDetailMedia2Description => _localizedValue('guide_detail_media_2_description');

  String get guideDetailMedia3Title => _localizedValue('guide_detail_media_3_title');

  String get guideDetailMedia3Description => _localizedValue('guide_detail_media_3_description');

  String get deleteAccountTitle => _localizedValue('delete_account_title');

  String get deleteAccountDescription => _localizedValue('delete_account_description');

  String get deleteAccountDescription1 => _localizedValue('delete_account_description1');

  String get deleteAccountReasonTitle => _localizedValue('delete_account_reason_title');

  String get deleteAccountReasonMenu1 => _localizedValue('delete_account_reason_menu1');

  String get deleteAccountReasonMenu2 => _localizedValue('delete_account_reason_menu2');

  String get deleteAccountReasonMenu3 => _localizedValue('delete_account_reason_menu3');

  String get deleteAccountReasonMenu4 => _localizedValue('delete_account_reason_menu4');

  String get deleteAccountReasonMenu4Hint => _localizedValue('delete_account_reason_menu4_hint');

  String get mediaInfoTitle => _localizedValue('media_info_title');

  String get mediaInfoMenuTitle => _localizedValue('media_info_menu_title');

  String get mediaInfoMenuInputTitle => _localizedValue('media_info_menu_input_title');

  String get mediaInfoMenuInputFileNameHint =>
      _localizedValue('media_info_menu_input_file_name_hint');

  String get mediaInfoMenuRegisterDate => _localizedValue('media_info_menu_register_date');

  String get mediaInfoMenuFileSize => _localizedValue('media_info_menu_file_size');

  String get mediaInfoMenuFileType => _localizedValue('media_info_menu_file_type');

  String get mediaInfoMenuFileCapacity => _localizedValue('media_info_menu_file_capacity');

  String get mediaInfoMenuFileCodec => _localizedValue('media_info_menu_file_codec');

  String get mediaInfoMenuFileRunningTime => _localizedValue('media_info_menu_file_running_time');

  String get mediaContentTitle => _localizedValue('media_content_title');

  String get mediaContentTabMedia => _localizedValue('media_content_tab_media');

  String get mediaContentTabCanvas => _localizedValue('media_content_tab_canvas');

  String get bottomSheetPinCodeDescription => _localizedValue('bottom_sheet_pin_code_description');

  String get bottomSheetMenuDisplayShowName =>
      _localizedValue('bottom_sheet_menu_display_show_name');

  String get tutorialScreenAddNew => _localizedValue('tutorial_screen_add_new');

  String get tutorialScreenEnterPinCode => _localizedValue('tutorial_screen_enter_pin_code');

  String get tutorialScreenDescription1 => _localizedValue('tutorial_screen_description1');

  String get tutorialScreenDescription2 => _localizedValue('tutorial_screen_description2');

  String get tutorialPlaylistAddNew => _localizedValue('tutorial_playlist_add_new');

  String get tutorialPlaylistDescription1 => _localizedValue('tutorial_playlist_description1');

  String get tutorialPlaylistDescription2 => _localizedValue('tutorial_playlist_description2');

  String get tutorialPlaylistDescription3 => _localizedValue('tutorial_playlist_description3');

  String get tutorialPlaylistDescription4 => _localizedValue('tutorial_playlist_description4');

  String get tutorialPlaylistDescription5 => _localizedValue('tutorial_playlist_description5');

  String get tutorialScheduleAddNew => _localizedValue('tutorial_schedule_add_new');

  String get tutorialScheduleDescription1 => _localizedValue('tutorial_schedule_description1');

  String get tutorialScheduleDescription2 => _localizedValue('tutorial_schedule_description2');

  String get tutorialScheduleDescription3 => _localizedValue('tutorial_schedule_description3');

  String get tutorialScheduleDescription4 => _localizedValue('tutorial_schedule_description4');

  String get tutorialMediaAddNew => _localizedValue('tutorial_media_add_new');

  String get tutorialMediaDescription1 => _localizedValue('tutorial_media_description1');

  String get tutorialMediaDescription2 => _localizedValue('tutorial_media_description2');

  String get tutorialMediaDescription3 => _localizedValue('tutorial_media_description3');

  String get tutorialMediaDescription4 => _localizedValue('tutorial_media_description4');

  String get tutorialMediaDescription5 => _localizedValue('tutorial_media_description5');

  String get tutorialMediaDescription6 => _localizedValue('tutorial_media_description6');

  String get blankMessageContentAddScreen => _localizedValue('blank_message_content_add_screen');

  String get blankMessageContentAddContent => _localizedValue('blank_message_content_add_content');

  String get blankMessageContentAddCanvas => _localizedValue('blank_message_content_add_canvas');

  String get blankMessageContentNewSchedule =>
      _localizedValue('blank_message_content_new_schedule');

  String get blankMessageContentNewPlaylist =>
      _localizedValue('blank_message_content_new_playlist');

  String get blankMessageContentUploadFile => _localizedValue('blank_message_content_upload_file');

  String get blankMessageDescriptionAddScreen =>
      _localizedValue('blank_message_description_add_screen');

  String get blankMessageDescriptionAddCanvas =>
      _localizedValue('blank_message_description_add_canvas');

  String get blankMessageDescriptionNewSchedule =>
      _localizedValue('blank_message_description_new_schedule');

  String get blankMessageDescriptionNewPlaylist =>
      _localizedValue('blank_message_description_new_playlist');

  String get blankMessageDescriptionUploadFile =>
      _localizedValue('blank_message_description_upload_file');

  String get popupRenameTitle => _localizedValue('popup_rename_title');

  String get popupRenameScreenHint => _localizedValue('popup_rename_screen_hint');

  String get popupRenameMediaHint => _localizedValue('popup_rename_media_hint');

  String get popupRenamePlaylistHint => _localizedValue('popup_rename_playlist_hint');

  String get popupDeleteTitle => _localizedValue('popup_delete_title');

  String get popupDeleteDescription => _localizedValue('popup_delete_description');

  String get popupApplyScreenTitle => _localizedValue('popup_apply_screen_title');

  String get popupApplyScreenDescription => _localizedValue('popup_apply_screen_description');

  String get popupLogoutDescription => _localizedValue('popup_logout_description');

  String get popupChangeDurationTitle => _localizedValue('popup_change_duration_title');

  String get popupDeleteAccountTitle => _localizedValue('popup_delete_account_title');

  String get popupDeleteAccountDescription => _localizedValue('popup_delete_account_description');

  String get commonEmail => _localizedValue('common_email');

  String get commonPassword => _localizedValue('common_password');

  String get commonOption => _localizedValue('common_option');

  String get commonRefresh => _localizedValue('common_refresh');

  String get commonTitle => _localizedValue('common_title');

  String get commonTotalDuration => _localizedValue('common_total_duration');

  String get commonAdd => _localizedValue('common_add');

  String get commonHorizontal => _localizedValue('common_horizontal');

  String get commonVertical => _localizedValue('common_vertical');

  String get commonFit => _localizedValue('common_fit');

  String get commonStretch => _localizedValue('common_stretch');

  String get commonFill => _localizedValue('common_fill');

  String get commonSignUp => _localizedValue('common_sign_up');

  String get commonOn => _localizedValue('common_on');

  String get commonOff => _localizedValue('common_off');

  String get commonOr => _localizedValue('common_or');

  String get commonDone => _localizedValue('common_done');

  String get commonNext => _localizedValue('common_next');

  String get commonDoLogin => _localizedValue('common_do_login');

  String get commonConnectScreen => _localizedValue('common_connect_screen');

  String get commonConfirm => _localizedValue('common_confirm');

  String get commonRename => _localizedValue('common_rename');

  String get commonLogout => _localizedValue('common_logout');

  String get commonOk => _localizedValue('common_ok');

  String get commonCancel => _localizedValue('common_cancel');

  String get commonPreview => _localizedValue('common_preview');

  String get commonMove => _localizedValue('common_move');

  String get commonNewFolder => _localizedValue('common_new_folder');

  String get commonMoveHere => _localizedValue('common_move_here');

  String get commonDelete => _localizedValue('common_delete');

  String get commonSave => _localizedValue('common_save');

  String get commonTime => _localizedValue('common_time');

  String get commonFullName => _localizedValue('common_full_name');

  String get commonUpdated => _localizedValue('common_updated');

  String get commonBack => _localizedValue('common_back');

  String get commonImage => _localizedValue('common_image');

  String get commonVideo => _localizedValue('common_video');

  String get commonCanvas => _localizedValue('common_canvas');

  String get commonFolder => _localizedValue('common_folder');

  String get commonAllAgree => _localizedValue('common_all_agree');

  String get filterKeyNameAsc => _localizedValue('filter_key_name_asc');

  String get filterKeyNameDesc => _localizedValue('filter_key_name_desc');

  String get filterKeyNewestFirst => _localizedValue('filter_key_newest_first');

  String get filterKeyOldestFirst => _localizedValue('filter_key_oldest_first');

  String get filterValueNameAsc => _localizedValue('filter_value_name_asc');

  String get filterValueNameDesc => _localizedValue('filter_value_name_desc');

  String get filterValueNewestFirst => _localizedValue('filter_value_newest_first');

  String get filterValueOldestFirst => _localizedValue('filter_value_oldest_first');

  String get messageServerError5xx => _localizedValue('message_server_error_5xx');

  String get messageFileNotFound404 => _localizedValue('message_file_not_found_404');

  String get messageFileNotAllowed404 => _localizedValue('message_file_not_allow_404');

  String get messagePermissionErrorPhotos => _localizedValue('message_permission_error_photos');

  String get messageNetworkRequired => _localizedValue('message_network_required');

  String get messageOperationTimeout => _localizedValue('message_operation_timeout');

  String get messageNotFoundUser => _localizedValue('message_not_found_user');

  String get messageAddMediaContent => _localizedValue('message_add_media_content');

  String get messageApiSuccess => _localizedValue('message_api_success');

  String get messageTempLoginFail => _localizedValue('message_temp_login_fail');

  String get messageTimeSettingPrecede => _localizedValue('message_time_setting_precede');

  String get messageTimeSettingDuplicated => _localizedValue('message_time_setting_duplicated');

  String get messageApplyScreenSuccess => _localizedValue('message_apply_screen_success');

  String get messageRegisterScreenSuccess => _localizedValue('message_register_screen_success');

  String get messageRemovePlaylistSuccess => _localizedValue('message_remove_playlist_success');

  String get messageRegisterPlaylistSuccess => _localizedValue('message_register_playlist_success');

  String get messageUpdatePlaylistSuccess => _localizedValue('message_update_playlist_success');

  String get messageAddMediaInPlaylistSuccess =>
      _localizedValue('message_add_media_in_playlist_success');

  String get messageRemoveScheduleSuccess => _localizedValue('message_remove_schedule_success');

  String get messageRegisterScheduleSuccess => _localizedValue('message_register_schedule_success');

  String get messageUpdateScheduleSuccess => _localizedValue('message_update_schedule_success');

  String get messageRemoveMediaSuccess => _localizedValue('message_remove_media_success');

  String get messageSendEventNameShowSuccess =>
      _localizedValue('message_send_event_name_show_success');

  String select_media_file_title(int count) => isKr() ? "파일 선택 ($count)" : "Select file ($count)";

  // Count Strings with Placeholders
  String count_playlist(int count) => isKr() ? "$count 개 재생목록" : "$count playlists";

  String count_pages(int count) => isKr() ? "콘텐츠 $count개" : "$count pages";

  String count_folder(int count, String size) =>
      isKr() ? "$count개 파일($size)" : "$count ${count <= 1 ? "File" : "Files"}$size";

  String type_media_size(String type, String size) => "$type - $size";

  String message_move_media_success(String folder) =>
      isKr() ? "파일이 $folder로 이동되었습니다" : "File moved to $folder";
}
