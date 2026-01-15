import 'package:flutter/material.dart';

class WaitingAnalysisPage extends StatelessWidget {
  const WaitingAnalysisPage({super.key});

  final Color brandColor = const Color(0xFF3E84A2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone de Relógio/Análise estilizado
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: brandColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.manage_search_rounded,
                      size: 80,
                      color: brandColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Título consistente com o Cadastro
                  Text(
                    "Cadastro em análise",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: brandColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Texto explicativo
                  const Text(
                    "Recebemos suas informações com sucesso! Agora, nosso time passará a validar seu perfil para garantir que você tenha a melhor experiência de mentoria.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  const Text(
                    "Fique de olho no seu e-mail cadastrado. Enviaremos uma notificação assim que seu acesso for liberado.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Botão para voltar/ir para Home (Principal)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        // Aqui você volta para a tela inicial de Login
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Entendi, ir para o início",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}