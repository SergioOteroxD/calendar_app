import 'package:go_router/go_router.dart';
import '../../dominio/entities/home_param.model.dart';
import '../../presentation/pages/calendar_page.dart';
import '../../presentation/screen/home/home_screen.dart';
import '../../presentation/screen/lesson/create_lesson_screen.dart';
import '../../presentation/screen/login/loginfull_screen.dart';
import '../../presentation/screen/signature/create_signature_screen.dart';
import '../../presentation/screen/teacher/create_teacher_screen.dart';

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
    GoRoute(path: '/calendar', name: CalendarPages.name, builder: (context, state) => const CalendarPages()),
    GoRoute(path: '/teacher', name: CreateTeacherScreen.name, builder: (context, state) => const CreateTeacherScreen()),
    GoRoute(
        path: '/signature',
        name: CreateSignatureScreen.name,
        builder: (context, state) => const CreateSignatureScreen()),
    GoRoute(
        path: '/lesson',
        name: CreateLessonScreen.name,
        builder: (context, state) => const CreateLessonScreen()),
  ],
);
