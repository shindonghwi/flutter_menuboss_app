# 미국 DEV APK
run-en-apk:
	cd menuboss-en && flutter clean && flutter pub get && cd ios && pod install \
	&& cd .. && flutter pub run build_runner build --delete-conflicting-outputs \
	&& flutter build apk --debug --flavor dev --no-tree-shake-icons -t lib/app/env/dev.dart

# 한국 DEV APK
run-kr-apk:
	cd menuboss-kr && flutter clean && flutter pub get && cd ios && pod install \
	&& cd .. && flutter pub run build_runner build --delete-conflicting-outputs \
	&& flutter build apk --debug --flavor dev --no-tree-shake-icons -t lib/app/env/dev.dart

# 미국 PROD AAB
run-en-aab:
	cd menuboss-en && flutter clean && flutter pub get && cd ios && pod install \
	&& cd .. && flutter pub run build_runner build --delete-conflicting-outputs \
	&& flutter build appbundle --release --flavor prod --no-tree-shake-icons -t lib/app/env/prod.dart

# 한국 PROD AAB
run-kr-aab:
	cd menuboss-kr && flutter clean && flutter pub get && cd ios && pod install \
	&& cd .. && flutter pub run build_runner build --delete-conflicting-outputs \
	&& flutter build appbundle --release --flavor prod --no-tree-shake-icons -t lib/app/env/prod.dart
