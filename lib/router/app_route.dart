import 'package:bmi_manager/screen/home_screen.dart';
import 'package:bmi_manager/screen/knowledge_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: "/knowledge",
        name: 'knowledge',
        builder: (context, state) => KnowledgeScreen(extra: state.extra as String),
      ),
    ],
  );
}
