part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();
  const factory SettingsState.initial(SettingsStateData form) =
      _InitialSettings;
  const factory SettingsState.loading(
      SettingsStateData form, bool isFirstLoading) = _LoadingSettings;
  const factory SettingsState.loaded(SettingsStateData form) = _LoadedSettings;
  const factory SettingsState.error(SettingsStateData form, String error) =
      _ErrorSettings;

  bool get isFirstLoading => maybeWhen(
      loading: (_, isFirstLoading) => isFirstLoading, orElse: () => false);
}
