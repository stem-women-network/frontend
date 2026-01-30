import 'package:flutter/material.dart';
import 'package:frontend/widgets/default_container.dart';
import 'package:frontend/widgets/mentorada_info.dart';

class Matching extends StatelessWidget {
  const Matching({super.key});

  @override
  Widget build(BuildContext context) {
    final Color brandColor = const Color(0xFF3E84A2);
    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
                      Text(
                        "Voltar",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top:20, left:30),
                child: Text("Matching de mentoradas", style: TextStyle(
                    color: Colors.white
                ),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top:10, left:30),
                child: Text("Perfis compatíveis com suas áreas de atuação e disponibilidade", style: TextStyle(color: Colors.white),),

              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultContainer(
                      children: [
                        MenteeInfo(
                          mentoradaName: "Carolina Oliveira",
                          curso: "Ciência da Computação",
                          semestre: 2,
                          instituicao: "FATEC",
                          objetivo: "Busco orientação para iniciar na área de ciência de dados e entender melhor as oportunidades de carreira.",
                          disponibilidade: [
                            "Manhã", "Tarde"
                          ],
                          backgroundColor: Colors.white,
                        ),
                        _MatchButtons()
                  ],),)
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultContainer(
                      children: [
                        MenteeInfo(
                          mentoradaName: "Carolina Oliveira",
                          curso: "Ciência da Computação",
                          semestre: 2,
                          instituicao: "FATEC",
                          objetivo: "Busco orientação para iniciar na área de ciência de dados e entender melhor as oportunidades de carreira.",
                          disponibilidade: [
                            "Manhã", "Tarde"
                          ],
                          backgroundColor: Colors.white,
                        ),
                        _MatchButtons()
                  ],),)
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultContainer(
                      children: [
                        MenteeInfo(
                          mentoradaName: "Carolina Oliveira",
                          curso: "Ciência da Computação",
                          semestre: 2,
                          instituicao: "FATEC",
                          objetivo: "Busco orientação para iniciar na área de ciência de dados e entender melhor as oportunidades de carreira.",
                          disponibilidade: [
                            "Manhã", "Tarde"
                          ],
                          backgroundColor: Colors.white,
                        ),
                        _MatchButtons()
                  ],),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchButtons extends StatelessWidget {
  const _MatchButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        Container(
          width: 200,
          child: FilledButton(
            onPressed: ()=> print("Aceitar match"),
            style: FilledButton.styleFrom(
              backgroundColor: brandColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ).copyWith(overlayColor: WidgetStateProperty.all(Colors.white10)),
            child: Text("Aceitar match")
          ),
        ),
        Container(
          width: 200,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(8),
              ),
              side: BorderSide(color: brandColor),
            ),
            onPressed: () => print("Recusar"),
            child: Text("Recusar", style: TextStyle(color: brandColor),),
          ),
        )
      ],
    );
  }
}
