import 'package:flutter/material.dart';
import 'package:frontend/screens/home/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0B6F8E),
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
                  horizontal: 60,
                ),
                child: Form(
                  key: _formKey,
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
                        "Bem vinda de volta!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text("Entre com sua conta para continuar"),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "E-mail",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      TextFormField(
                        cursorColor: Color(0xFF0B6F8E),
                        decoration: const InputDecoration(
                          hintText: "seuemail@stem.br",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCBCBCB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0B6F8E)),
                          ),
                          prefixIconColor: Color(0xFF0B6F8E),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Senha",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      TextFormField(
                        cursorColor: Color(0xFF0B6F8E),
                        decoration: const InputDecoration(
                          hintText: "*********",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCBCBCB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0B6F8E)),
                          ),
                          focusColor: Color(0xFF0B6F8E),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: WidgetStatePropertyAll(
                              Color(0x00FFFFFF),
                            ),
                            textStyle: WidgetStateProperty.fromMap({
                              WidgetState.hovered: TextStyle(
                                color: Color(0xFF0B6F8E),
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor: Color(0xFF0B6F8E),
                              ),
                              WidgetState.any: TextStyle(
                                color: Color(0xFF0B6F8E),
                              ),
                            }),
                          ),
                          onPressed: () => print("Esqueci a minha senha"),
                          child: const Text(
                            "Esqueci a minha senha",
                            style: TextStyle(color: Color(0xFF0B6F8E)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox.expand(
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processando')),
                                );
                              }
                            },
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
                            child: const Text('Entrar'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Não tem uma conta?"),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            ),
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(
                                Color(0x00FFFFFF),
                              ),
                              textStyle: WidgetStateProperty.fromMap({
                                WidgetState.hovered: TextStyle(
                                  color: Color(0xFF0B6F8E),
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Color(0xFF0B6F8E),
                                ),
                                WidgetState.any: TextStyle(
                                  color: Color(0xFF0B6F8E),
                                ),
                              }),
                            ),
                            child: Text(
                              "Criar conta",
                              style: TextStyle(color: Color(0xFF0B6F8E)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
