import 'package:dentalar/utils/colors_palette.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WhatsappInputArea extends StatelessWidget {
  const WhatsappInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 2,
        bottom: 30,
      ),
      alignment: Alignment.center,
      child: Center(
        child: TextFormBox(
            maxLines: 8,
            header: 'Mensagem',
            placeholder: 'Entre com a mensagem...',
            style: const TextStyle(fontSize: 28, color: Palette.formText)),
      ),
    );
  }
}
