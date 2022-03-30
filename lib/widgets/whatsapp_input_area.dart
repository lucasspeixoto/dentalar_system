import 'package:fluent_ui/fluent_ui.dart';

class WhatsappInputArea extends StatelessWidget {
  const WhatsappInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 2,
        bottom: 30,
      ),
      alignment: Alignment.center,
      child: const Center(
        child: Text(
          'Input Text area',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
