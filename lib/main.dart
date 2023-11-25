import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'infrastructure/database/database_helper.dart';

Future<void> main() async {
  await DataBaseHelper.instance.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkmode = ref.watch(isDarkmodeProvider);
    // final selectedColor = ref.watch(selectedColorProvider);

    return MaterialApp.router(
      title: 'Flutter Calendario',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).theme(),
    );
  }
}
