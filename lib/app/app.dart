import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/pages/authentication/sign_up_page.dart';
import 'package:attendance/pages/authentication/verification_page.dart';
import 'package:attendance/pages/home_page/home_page.dart';
import 'package:attendance/pages/splash_page/splash_page.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: HomePage),
    MaterialRoute(page: VerificationPage),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: SignUpPage),
    // MaterialRoute(page: SplashPage,initial: true),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
