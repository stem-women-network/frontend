import 'package:flutter/material.dart';

class MatchAuthorizationPage extends StatefulWidget {
  const MatchAuthorizationPage({super.key});

  @override
  State<MatchAuthorizationPage> createState() => _MatchAuthorizationPageState();
}

class _MatchAuthorizationPageState extends State<MatchAuthorizationPage> {
  // Paleta de Cores Oficial
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);
  final Color coral = const Color(0xFFE4645B);
  final Color verde = const Color(0xFF43A047);
  final Color greyBg = const Color(0xFFF0F2F5);

  // Lista simulada
  final List<Map<String, dynamic>> _matchesSugeridos = [
    {
      "id": 1,
      "score": "98%",
      "motivo": "Interesse comum em Inteligência Artificial e Carreira Internacional.",
      "mentora": {
        "nome": "Dra. Elena Souza",
        "cargo": "Eng. Sênior @ Google",
        "skills": ["AI", "Python", "Liderança"],
        "foto": "E"
      },
      "mentorada": {
        "nome": "Julia Martins",
        "curso": "Eng. Computação",
        "objetivo": "Entrar em Big Techs",
        "foto": "J"
      }
    },
    {
      "id": 2,
      "score": "85%",
      "motivo": "Foco em Bioengenharia e Pesquisa Acadêmica.",
      "mentora": {
        "nome": "Mariana Lima",
        "cargo": "Pesquisadora FAPESP",
        "skills": ["Biotech", "Gestão", "Pesquisa"],
        "foto": "M"
      },
      "mentorada": {
        "nome": "Beatriz Silva",
        "curso": "Biomedicina",
        "objetivo": "Mestrado no Exterior",
        "foto": "B"
      }
    },
    {
      "id": 3,
      "score": "72%",
      "motivo": "Match por Soft Skills: Liderança e Comunicação.",
      "mentora": {
        "nome": "Fernanda Costa",
        "cargo": "Gerente de Projetos",
        "skills": ["Agile", "Scrum", "Comunicação"],
        "foto": "F"
      },
      "mentorada": {
        "nome": "Carla Dias",
        "curso": "Sist. de Informação",
        "objetivo": "Transição para Gestão",
        "foto": "C"
      }
    },
  ];

  void _processarMatch(int index, bool aprovado) {
    setState(() {
      _matchesSugeridos.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(aprovado 
          ? "Match Aprovado! Contratos enviados." 
          : "Match Rejeitado. Perfis liberados."
        ),
        backgroundColor: aprovado ? verde : coral,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor, // Fundo consistente com Dashboard
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Aprovação de Matches", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
      body: SafeArea(
        child: _matchesSugeridos.isEmpty 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 80, color: Colors.white.withOpacity(0.5)),
                  const SizedBox(height: 20),
                  const Text("Tudo limpo!", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text("Nenhum match pendente.", style: TextStyle(color: Colors.white70)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemCount: _matchesSugeridos.length,
              itemBuilder: (context, index) {
                return _buildMatchCard(_matchesSugeridos[index], index);
              },
            ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Consistente com Dashboard
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          // Header do Card: Score e Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: verde.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: verde, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      match['score'], 
                      style: TextStyle(color: verde, fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: laranja.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Pendente", style: TextStyle(color: laranja, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Perfis (Mentora e Mentorada)
          Row(
            children: [
              Expanded(child: _buildProfileInfo(match['mentora'], "Mentora", petroleo)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.compare_arrows, color: Colors.grey[300], size: 32),
              ),
              Expanded(child: _buildProfileInfo(match['mentorada'], "Mentorada", brandColor)),
            ],
          ),

          const SizedBox(height: 24),

          // Motivo (Box cinza claro)
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: greyBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("POR QUE ESSE MATCH?", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(match['motivo'], style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botões de Ação
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _processarMatch(index, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: coral),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Rejeitar", style: TextStyle(color: coral, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () => _processarMatch(index, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: verde,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("Aprovar", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> data, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.1),
          child: Text(
            data['foto'], 
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label.toUpperCase(),
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        const SizedBox(height: 4),
        Text(
          data['nome'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          data['cargo'] ?? data['curso'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}