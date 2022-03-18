import 'package:dentalar/utils/colors_palette.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: Container(
        color: Palette.secondaryColor,
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: screenWidth,
                height: (screenHeight * 0.48),
                color: Palette.primaryColor,
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/whatsapp.png',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Image.asset(
                      'assets/images/instagram.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Copyright © 2022 Automatizações Dental A.R. Todos os direitos reservados.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
