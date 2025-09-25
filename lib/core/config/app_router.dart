import 'package:go_router/go_router.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/users_page.dart';
import '../../presentation/pages/video_call_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String users = '/users';
  static const String videoCall = '/video-call';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: users,
        name: 'users',
        builder: (context, state) => const UsersPage(),
      ),
      GoRoute(
        path: videoCall,
        name: 'video-call',
        builder: (context, state) => const VideoCallPage(),
      ),
    ],
    initialLocation: splash,
  );
}