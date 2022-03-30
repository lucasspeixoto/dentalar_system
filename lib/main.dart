import 'package:dentalar/models/contact_list.dart';
import 'package:dentalar/screens/navigations_screen.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:system_theme/system_theme.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';

const String appTitle = 'Plataforma Dentalar';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentInstance;
  }

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      //await windowManager.setTitleBarStyle('hidden');
      await windowManager.setSize(const Size(1300, 700));
      await windowManager.setMinimumSize(const Size(1300, 700));
      await windowManager.setMaximumSize(const Size(1300, 700));
      await windowManager.center();
      await windowManager.show();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactList(),
      child: FluentApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors
              .teal, /* iconTheme: const IconThemeData(size: 24, color: Palette.highlight) */
        ),
        home: const NavigationScreen(),
      ),
    );
  }
}
