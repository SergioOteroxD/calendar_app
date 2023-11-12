import 'package:go_router/go_router.dart';
import '../../dominio/home_param.model.dart';
import '../../presentation/screen/home/home_screen.dart';
import '../../presentation/screen/login/loginfull_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: LoginFullScreen.name,
      builder: (context, state) => const LoginFullScreen(),
    ),
    GoRoute(
        path: '/home',
        name: HomeScreen.name,
        builder: (context, state) {
          HomeParamModel homeModel = state.extra as HomeParamModel;
          return HomeScreen(homeParamModel: homeModel);
        }),
  ],
);
