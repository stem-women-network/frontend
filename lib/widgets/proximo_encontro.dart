import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProximoEncontro extends StatelessWidget {
  const ProximoEncontro({
    super.key,
    required this.nomeMentorada,
    required this.dataEncontro,
    required this.topico,
  });

  final String nomeMentorada;
  final DateTime dataEncontro;
  final String topico;

  @override
  Widget build(BuildContext context) {
    final Color brandColor = const Color(0xFF3E84A2);
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        spacing: 3,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.calendar_month, color: brandColor),
              Text(
                "${dataEncontro.day} ${DateFormat.MMM().format(dataEncontro)} • ${DateFormat.Hm().format(dataEncontro)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Text("Com $nomeMentorada"),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Tópico $topico"),
                FilledButton(
                  onPressed: () => print("Detalhes"),
                  style:
                      FilledButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.white10),
                      ),
                  child: Text("Ver perfil"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
