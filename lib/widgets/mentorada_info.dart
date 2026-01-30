import 'package:flutter/material.dart';

final Color brandColor = const Color(0xFF3E84A2);
final Color laranja = const Color(0xFFFE9F43);
final Color petroleo = const Color(0xFF0B6F8E);
final Color inputGrey = const Color.fromARGB(255, 240, 240, 240);
final Color verdeSucesso = const Color(0xFF2E7D32);

class MenteeInfo extends StatelessWidget {
  final Image? mentoradaImage;
  final String mentoradaName;
  final String? estadoMentoria;
  final String curso;
  final int? semestre;
  final String? instituicao;
  final String? objetivo;
  final List<String>? disponibilidade;
  final int? progresso;
  final DateTime? proximoEncontro;
  final Color? backgroundColor;

  const MenteeInfo({
    super.key,
    this.mentoradaImage,
    required this.mentoradaName,
    required this.curso,
    this.estadoMentoria,
    this.semestre,
    this.instituicao,
    this.objetivo,
    this.disponibilidade,
    this.progresso,
    this.proximoEncontro,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 20,
            children: [
              CircleAvatar(
                foregroundImage: mentoradaImage?.image,
                backgroundColor: laranja.withOpacity(0.1),
                radius: 32,
                child: Icon(Icons.person, color: laranja, size: 30),
              ),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    mentoradaName,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "$curso${semestre != null ? ' • $semestre° semestre' : ''}${instituicao != null ? ' • $instituicao' : ''}",
                      ),
                    ],
                  ),

                  if (objetivo != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Objetivo:",
                          style: TextStyle(
                            color: Color(0xFF4A5464),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(objetivo!),
                      ],
                    ),
                  if (disponibilidade != null)
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 25),
                        Text("Disponível:"),
                        ...disponibilidade!.map(
                          (value) => Container(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 3,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFEFEFEF),
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(value),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                if (estadoMentoria == "ativa") ...[
                  Icon(Icons.check_circle, size: 14, color: verdeSucesso),
                  const SizedBox(width: 4),
                  Text(
                    "Mentoria Ativa",
                    style: TextStyle(
                      color: verdeSucesso,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Icon(Icons.error_rounded, size: 14, color: Color(0xFFFF0000)),
                  const SizedBox(width: 4),
                  Text(
                    "Mentoria Não Ativa",
                    style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (progresso != null)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ProgressBar(progresso: progresso),
            ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progresso});

  final int? progresso;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsGeometry.only(top: 5),
          child: Wrap(
            runSpacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.start,
            children: [
              Text(
                "Progresso do Ciclo",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Text(
                "$progresso%",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: petroleo,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  backgroundColor: inputGrey,
                  color: petroleo,
                  minHeight: 8,
                  value: progresso! / 100,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
