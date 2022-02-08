
// import 'package:audio_service/audio_service.dart';

import 'package:get_it/get_it.dart';
import 'package:attendance/services/locator.config.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
// import 'package:just_audio/just_audio.dart';

GetIt getIt = GetIt.instance;

// AppPreferences preferences = locator<AppPreferences>();
// AudioHandler audioHandler = locator<AudioHandler>();
//
Future<void> setupServiceLocator() async {
  try {
    $initGetIt(locator);

    var instance = await AppPreferences.getInstance();
    locator.registerSingleton<AppPreferences>(instance);
  } catch (e) {
    print(e);
  }
  // services
  // getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  // getIt.registerLazySingleton<PageManager>(() => PageManager());
}

