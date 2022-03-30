import 'package:fluent_ui/fluent_ui.dart';

class InstagramInputArea extends StatelessWidget {
  const InstagramInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 2,
        bottom: 30,
      ),
      alignment: Alignment.center,
      child: const Center(
        child: Text(
          'Instagram area',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
