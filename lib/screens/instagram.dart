import 'package:fluent_ui/fluent_ui.dart';

class InstagramScreen extends StatelessWidget {
  const InstagramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Instagram'),
      ),
      content: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: const [
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: TextBox(
                placeholder: 'Pesquisa...',
              ),
            ),
            SizedBox(height: 20),
            ContendD(),
          ],
        ),
      ),
    );
  }
}

class ContendD extends StatelessWidget {
  const ContendD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: const Text('Abrir Dialog'),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return ContentDialog(
                title: const Text('Título'),
                content: const Text('Conteúdo'),
                actions: [
                  Button(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Button(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
