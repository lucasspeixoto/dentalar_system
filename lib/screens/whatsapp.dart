import 'package:dentalar/widgets/contacts_list.dart';
import 'package:dentalar/widgets/whatsapp_input_area.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WhatsappScreen extends StatelessWidget {
  const WhatsappScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text(
          'WhatsApp',
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
            child: WhatsappInputArea(),
          )
        ],
      ),
    );
  }
}
