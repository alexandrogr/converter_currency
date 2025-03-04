# Makefile for Flutter project 

# execute
# make {command}

# Variables
OBFUSCATE_PATH :=  /Volumes/Source/Mobile/flutter/_obfuscate/currency_calculator/


#function
build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

build_runner_watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

# android

build_apk:
	# @echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build apk --obfuscate --split-debug-info=${OBFUSCATE_PATH}

build_apk_release:
	# @echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build apk --obfuscate --split-debug-info=${OBFUSCATE_PATH} --dart-define-from-file=env/release.json --flavor=prod

build_apk_demo:
	# @echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build apk --obfuscate --split-debug-info=${OBFUSCATE_PATH} --dart-define-from-file=env/demo.json --flavor=dev

build_appbundle_release:
	# @echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build appbundle --obfuscate --split-debug-info=${OBFUSCATE_PATH} --dart-define-from-file=env/release.json --flavor=prod


# ios

ios_pod_install:
	# cd ios; bundle exec pod install --repo-update
	cd ios; pod install --repo-update

ios_pod_install_verbose:
	cd ios; pod install --repo-update --verbose


# https://docs.flutter.dev/deployment/ios
# Run flutter build ipa to produce an Xcode build archive (.xcarchive file) in your project's build/ios/archive/ directory and an App Store app bundle (.ipa file) in build/ios/ipa.
build_ios_ipa:
	# @echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build ipa --obfuscate --split-debug-info=${OBFUSCATE_PATH} --dart-define-from-file=env/release.json

build_ios_ipa_and_upload:
	@echo "Release with obfuscation to \"${OBFUSCATE_PATH}\"" #printing this log on console
	flutter build ipa --obfuscate --split-debug-info=${OBFUSCATE_PATH} --dart-define-from-file=env/release.json; xcrun altool --upload-app --type ios -f build/ios/ipa/*.ipa --apiKey your_api_key --apiIssuer your_issuer_id