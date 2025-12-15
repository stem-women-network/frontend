import 'package:flutter/material.dart';
import 'package:frontend/screens/home/login_page.dart';
import 'package:frontend/screens/home/signup_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width / 1.5,
          height: height / 1.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsetsGeometry.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 0.5,
                  children: [
                    Spacer(),
                    Text(
                      "STEM WOMEN NETWORK",
                      style: TextStyle(
                        color: Color(0xFF0B6F8E),
                        fontSize: 20,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      "Bem vinda ao STEM Women Network",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Conectando mulheres da área da tecnologia por meio de mentorias reais.",
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SizedBox.expand(
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Color(0xFF1581A3),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    7,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text("Criar Conta"),
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage())),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(top: 2),
                        child: SizedBox.expand(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Color(0xFFFFFFFF),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Color(0xFF1581A3),
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(color: Color(0xFF1581A3)),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    7,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text("Entrar"),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Transformando o futuro de mulheres STEM!",
                      textScaler: TextScaler.linear(0.9),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF0B6F8E),
    );
  }
}
