import 'package:dentalar/screens/home.dart';
import 'package:dentalar/screens/instagram.dart';
import 'package:dentalar/screens/whatsapp.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIdex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        leading: Center(
          child: Icon(FluentIcons.auto_deploy_settings, size: 40),
        ),
      ),
      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: const Text('Automações Dental A.R'),
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.add_home),
            title: const Text('Home'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.skype_message),
            title: const Text('WhatsApp'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.photo2),
            title: const Text('Instagram'),
          ),
        ],
        selected: _currentIdex,
        displayMode: PaneDisplayMode.compact,
        onChanged: (index) {
          setState(() {
            _currentIdex = index;
          });
        },
      ),
      content: NavigationBody(
        index: _currentIdex,
        children: const [
          Home(),
          WhatsappScreen(),
          InstagramScreen(),
        ],
      ),
    );
  }
}
