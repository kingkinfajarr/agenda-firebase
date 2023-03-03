import 'package:get/get.dart';
import 'package:testdeptech/splash_page.dart';

import '../modules/create_agenda/bindings/create_agenda_binding.dart';
import '../modules/create_agenda/views/create_agenda_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/update_agenda/bindings/update_agenda_binding.dart';
import '../modules/update_agenda/views/update_agenda_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_AGENDA,
      page: () => const CreateAgendaView(),
      binding: CreateAgendaBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_AGENDA,
      page: () => const UpdateAgendaView(),
      binding: UpdateAgendaBinding(),
    ),
  ];
}
