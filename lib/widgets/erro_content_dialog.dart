import 'package:fluent_ui/fluent_ui.dart';

class ErrorContentDialog extends StatefulWidget {
  final String title;
  final String content;
  final String buttonText;
  const ErrorContentDialog(this.title, this.content, this.buttonText,
      {Key? key})
      : super(key: key);

  @override
  State<ErrorContentDialog> createState() => _ErrorContentDialogState();
}

class _ErrorContentDialogState extends State<ErrorContentDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        Button(
          child: Text(widget.buttonText),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
