// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:attendance/services/locator.config.dart';
import 'package:attendance/services/preferences_service.dart';

final locator = GetIt.instance;
// AudioHandler audioHandler = locator<AudioHandler>();

@injectableInit
Future<void> setupLocator() async {
  try {
    $initGetIt(locator);
    // Firebase.initializeApp();
    // locator.registerSingleton<AudioHandler>(await initAudioService());
    // Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyD6vxHeoWOtc586VTz8X5B-WD2NTqYyaIA',
    //   //   // authDomain: 'react-native-firebase-testing.firebaseapp.com',
    //   //   // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
    //     projectId: 'fir-test-a9a5e',
    //   //   // storageBucket: 'react-native-firebase-testing.appspot.com',
    //     messagingSenderId: '173628410666',
    //     appId: '1:173628410666:android:12cbd7a3da4ba72a60ac53',
    //   //   // measurementId: 'G-0N1G9FLDZE',
    //   ),
    // );
    //
    var instance = await AppPreferences.getInstance();
    locator.registerSingleton<AppPreferences>(instance);
    // var fireBase =  FirebaseAnalytics.instance;
    // locator.registerSingleton<FirebaseAnalytics>(fireBase);

  } catch (e) {
    print(e);
  }

//   try {
//     $initGetIt(locator);
//
// //   // services
// //   getIt.registerSingleton<AudioHandler>(await initAudioService());
// //   getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());
// //
// //   // page state
// //   getIt.registerLazySingleton<PageManager>(() => PageManager());
//
//     // var instance = await AppPreferences.getInstance();
//     // locator.registerSingleton<AppPreferences>(instance);
//     // locator.registerLazySingleton(() => PushNotificationService());
//
//   } catch (e) {
//     print(e);
//   }
}

/*Future initAudioService() async {
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.eurika.eurika',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
}

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler() {
    _player.setUrl("https://exampledomain.com/song.mp3");
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();
}*/
