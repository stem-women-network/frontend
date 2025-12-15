import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0B6F8E),
      body: Center(
        child: SizedBox(
          width: width / 1.5,
          height: height / 1.1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsetsGeometry.symmetric(
                  vertical: 20,
                  horizontal: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 0.5,
                  children: [
                    Text(
                      "Como você deseja participar?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      "Conectando mulheres da área da tecnologia por meio de mentorias reais.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      color: Color(0xFFFE9F43),
                      child: InkWell(
                        onTap: () => debugPrint("Mentora"),
                        child: SizedBox(
                          width: 400,
                          height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Sou mentora",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Quero orientar estudantes, apoiar o crescimento de outras mulheres e compartilhar minha experiênia STEM.",
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFEF4C56),
                      child: InkWell(
                        onTap: () => debugPrint("Mentorada"),
                        child: SizedBox(
                          width: 400,
                          height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Sou mentorada",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Busco receber orientação de mentoras, aprender com profissionais STEM e desenvolver minha carreira.",
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
