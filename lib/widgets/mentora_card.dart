import 'package:flutter/material.dart';
import 'package:frontend/widgets/default_container.dart';

class MentoraCard extends StatelessWidget {
  final Image? mentoraImage;
  final String mentoraName;
  final String cargoAtual;
  final String instituicaoName;
  final List<String> areasAtuacao;
  final List<String> disponibilidade;

  const MentoraCard({
    super.key,
    this.mentoraImage,
    required this.mentoraName,
    required this.cargoAtual,
    required this.instituicaoName,
    required this.areasAtuacao,
    required this.disponibilidade,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      maxWidth: MediaQuery.sizeOf(context).width,
      children: [
        Row(
          spacing: 20,
          children: [
            CircleAvatar(
              foregroundImage: mentoraImage?.image,
              backgroundColor: Color(0xFFF3A850),
              radius: 50,
            ),
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: TextStyle(fontWeight: FontWeight.w600),
                  mentoraName,
                ),
                Row(
                  children: [
                    Text(cargoAtual),
                    Text(" • "),
                    Text(instituicaoName),
                  ],
                ),
                Wrap(
                  spacing: 5,
                  children: areasAtuacao
                      .map(
                        (area) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(5),
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            child: Text(area),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text("Disponível: "),
                    ),
                    Text(
                      disponibilidade
                          .asMap()
                          .map((index, item) {
                            if (index == 0) {
                              return MapEntry(index, item);
                            } else if (index == disponibilidade.length - 1) {
                              return MapEntry(index, " e $item");
                            } else {
                              return MapEntry(index, ", $item");
                            }
                          })
                          .values
                          .join(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
