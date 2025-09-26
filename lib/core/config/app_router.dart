import 'package:go_router/go_router.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/users_page.dart';
import '../../presentation/pages/join_call_page.dart';
import '../../presentation/pages/firebase_video_call_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String users = '/users';
  static const String joinCall = '/join-call';
  static const String webrtcCall = '/webrtc-call';

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
        path: joinCall,
        name: 'join-call',
        builder: (context, state) => const JoinCallPage(),
      ),
      GoRoute(
        path: webrtcCall,
        name: 'webrtc-call',
        builder: (context, state) {
          final roomId = state.uri.queryParameters['roomId'];
          final isCaller = state.uri.queryParameters['isCaller'] == 'true';
          final callerName = state.uri.queryParameters['callerName'];
          return FirebaseVideoCallPage(
            roomId: roomId, 
            isCaller: isCaller,
            callerName: callerName,
          );
        },
      ),
    ],
    initialLocation: splash,
  );
}