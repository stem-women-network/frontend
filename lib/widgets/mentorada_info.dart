import 'package:flutter/material.dart';

final Color brandColor = const Color(0xFF3E84A2);

class MentoradaInfo extends StatelessWidget {
  final Image? mentoradaImage;
  final String mentoradaName;
  final String curso;
  final int? semestre;
  final int? progresso;
  final DateTime? proximoEncontro;

  const MentoradaInfo({
    super.key,
    this.mentoradaImage,
    required this.mentoradaName,
    required this.curso,
    this.semestre,
    this.progresso,
    this.proximoEncontro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
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
                backgroundColor: Color(0xFFE4645B),
                radius: 40,
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
                        "$curso${semestre != null ? ' • $semestre semestre' : ''}",
                      ),
                    ],
                  ),
                ],
              ),
              ],),
              if (progresso != null)
                ProgressBar(progresso: progresso, proximoEncontro: proximoEncontro)
              else
                FilledButton(
                  onPressed: () => print("Ver perfil"),
                  style: FilledButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ).copyWith(overlayColor: WidgetStateProperty.all(Colors.white10)),
                  child: Text("Ver perfil"),
                ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progresso, required this.proximoEncontro});

  final int? progresso;
  final DateTime? proximoEncontro;

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
              Text("Progresso", textAlign: TextAlign.left),
              Text("$progresso%", textAlign: TextAlign.right),
              LinearProgressIndicator(
                value: progresso! / 100,
                color: Color(0xFFFCB544),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsetsGeometry.only(top: 10),
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.spaceAround,
            children: [
              Text("Próximo encontro: ${proximoEncontro!.day}/${proximoEncontro!.month}/${proximoEncontro!.year}"),
              FilledButton(
                onPressed: () => print("Ver perfil"),
                style: FilledButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ).copyWith(overlayColor: WidgetStateProperty.all(Colors.white10)),
                child: Text("Ver perfil"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
