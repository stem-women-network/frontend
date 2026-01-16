import 'package:flutter/material.dart';
import 'package:frontend/screens/mentora/matching.dart';
import 'package:frontend/screens/mentora/register_meeting.dart';
import 'package:frontend/widgets/default_container.dart';
import 'package:frontend/widgets/mentora_card.dart';
import 'package:frontend/widgets/mentorada_info.dart';
import 'package:frontend/widgets/proximo_encontro.dart';

class MentoraDashboard extends StatelessWidget {
  const MentoraDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color brandColor = const Color(0xFF3E84A2);
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: const Color(0xFF387B99),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    const Text(
                      "STEM Women Network",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    Container(
                      child: Wrap(
                        spacing: 3,
                        children: [
                          _buildButton(
                            icon: Icons.bar_chart,
                            onPressed: () => print("Teste"),
                          ),
                          _buildButton(
                            icon: Icons.calendar_month,
                            onPressed: () => print("Teste"),
                          ),
                          _buildButton(
                            icon: Icons.person_outline,
                            onPressed: () => print("Teste"),
                          ),
                          _buildButton(
                            icon: Icons.settings_outlined,
                            onPressed: () => print("Teste"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MentoraCard(
                      mentoraName: "Ana Paula Serra",
                      cargoAtual: "Desenvolvedora Sênior",
                      instituicaoName: "Instituto Mauá de Tecnologia",
                      areasAtuacao: [
                        "Desenvolvimento",
                        "Ciência de Dados",
                        "Engenharia",
                      ],
                      disponibilidade: ["manhã", "tarde", "noite"],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultContainer(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 5,
                            children: [
                              Text(
                                "Pedidos pendentes",
                                textScaler: TextScaler.linear(1.3),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 3,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFCECE),
                                  borderRadius: BorderRadiusGeometry.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  "1 novo",
                                  style: TextStyle(color: Color(0xFFA90000)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        MentoradaInfo(
                          mentoradaName: "Carolina Oliveira",
                          curso: "Matemática aplicada",
                          semestre: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    DefaultContainer(
                      children: [
                        Container(
                          padding: EdgeInsetsGeometry.only(bottom: 10),
                          width: double.infinity,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Text(
                                "Minhas Mentoradas",
                                textScaler: TextScaler.linear(1.3),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 3,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFCECE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  "4 mentoradas",
                                  style: TextStyle(color: Color(0xFFA90000)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        MentoradaInfo(
                          mentoradaName: "Mariana Barolis",
                          curso: "Ciência da Computação",
                          progresso: 55,
                          proximoEncontro: DateTime(2025, 12, 17),
                        ),
                        MentoradaInfo(
                          mentoradaName: "Carol Moura",
                          curso: "Matemática aplicada",
                          progresso: 55,
                          proximoEncontro: DateTime(2025, 12, 17),
                        ),
                        Container(
                          padding: EdgeInsetsGeometry.only(top: 10),
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: brandColor),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Matching()),
                            ),
                            child: Text(
                              "Buscar novas mentoradas",
                              style: TextStyle(color: brandColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: DefaultContainer(
                        children: [
                          Text("Próximos Encontros"),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          ProximoEncontro(
                            nomeMentorada: "Maria Silva",
                            topico: "Revisão de currículo",
                            dataEncontro: DateTime(2026, 01, 28, 14),
                          ),
                          ProximoEncontro(
                            nomeMentorada: "Maria Silva",
                            topico: "Revisão de currículo",
                            dataEncontro: DateTime(2026, 01, 28, 14),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: brandColor),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterMeeting(),
                              ),
                            ),
                            child: Text(
                              "Registrar Encontro",
                              style: TextStyle(color: brandColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          DefaultContainer(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: Color(0xFFFCB544),
                                      size: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Treinamento",
                                          textScaler: TextScaler.linear(1.2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Materiais e vídeos"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DefaultContainer(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.front_hand,
                                      color: Color(0xFFE4645B),
                                      size: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Primeiro Contato",
                                          textScaler: TextScaler.linear(1.2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Registrar contato inicial"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DefaultContainer(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFF0B6F8E),
                                      size: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Eventos",
                                          textScaler: TextScaler.linear(1.2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Ver próximos eventos"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DefaultContainer(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: Color(0xFFE4645B),
                                      size: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Certificado",
                                          textScaler: TextScaler.linear(1.2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Ver conquistas"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsetsGeometry.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
        ),
        child: Icon(icon),
      ),
    );
  }
}
