import 'package:dentalar/widgets/contacts_list.dart';
import 'package:dentalar/widgets/instagram_input_area.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InstagramScreen extends StatelessWidget {
  const InstagramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text(
          'Instagram',
          style: TextStyle(fontSize: 32),
        ),
      ),
      content: Row(
        children: const [
          Expanded(
            flex: 3,
            child: ContactsList(),
          ),
          Expanded(
            flex: 7,
            child: InstagramInputArea(),
          )
        ],
      ),
    );
  }
}
