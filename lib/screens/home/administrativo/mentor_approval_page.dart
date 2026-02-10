import 'package:flutter/material.dart';

class MentorApprovalPage extends StatefulWidget {
  const MentorApprovalPage({super.key});

  @override
  State<MentorApprovalPage> createState() => _MentorApprovalPageState();
}

class _MentorApprovalPageState extends State<MentorApprovalPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color roxo = const Color(0xFF6C63FF);
  final Color verde = const Color(0xFF43A047);
  final Color coral = const Color(0xFFE4645B);
  final Color greyBg = const Color(0xFFF0F2F5);

  final List<Map<String, dynamic>> _mentorasPendentes = [
    {
      "id": 1,
      "nome": "Beatriz Lima",
      "cargo": "Tech Lead @ Nubank",
      "formacao": "Ciência da Computação - USP",
      "linkedin": "linkedin.com/in/beatriz-lima",
      "skills": ["Liderança", "Java", "Fintech"],
      "foto": "B",
      "data_inscricao": "Hoje, 10:30"
    },
    {
      "id": 2,
      "nome": "Fernanda Torres",
      "cargo": "Engenheira Civil Sênior",
      "formacao": "Engenharia Civil - UFRJ",
      "linkedin": "linkedin.com/in/fernanda-t",
      "skills": ["Gestão de Obras", "AutoCAD", "Revit"],
      "foto": "F",
      "data_inscricao": "Ontem, 14:00"
    },
    {
      "id": 3,
      "nome": "Cláudia Reis",
      "cargo": "Pesquisadora em Bioquímica",
      "formacao": "Doutorado em Bioquímica - UNICAMP",
      "linkedin": "linkedin.com/in/claudia-reis",
      "skills": ["Pesquisa", "Academia", "Inglês"],
      "foto": "C",
      "data_inscricao": "2 dias atrás"
    },
  ];

  void _processarMentora(int index, bool aprovada) {
    setState(() {
      _mentorasPendentes.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(aprovada ? Icons.mark_email_read : Icons.cancel, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(aprovada 
                ? "Mentora aprovada! E-mail de confirmação enviado." 
                : "Mentora rejeitada."
              ),
            ),
          ],
        ),
        backgroundColor: aprovada ? verde : coral,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _confirmarEnvioEmail(int index, String nome) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.email, color: roxo),
              const SizedBox(width: 10),
              const Text("Confirmar Aprovação"),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Deseja aprovar a mentora $nome?"),
                const SizedBox(height: 10),
                const Text(
                  "Um e-mail automático será enviado informando que ela foi aceita no programa.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: verde,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Enviar E-mail e Aprovar"),
              onPressed: () {
                Navigator.of(context).pop();
                _processarMentora(index, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Validação de Mentoras", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
      body: SafeArea(
        child: _mentorasPendentes.isEmpty 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 80, color: Colors.white.withOpacity(0.5)),
                  const SizedBox(height: 20),
                  const Text("Tudo limpo!", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              itemCount: _mentorasPendentes.length,
              itemBuilder: (context, index) {
                return _buildMentorCard(_mentorasPendentes[index], index);
              },
            ),
      ),
    );
  }

  Widget _buildMentorCard(Map<String, dynamic> mentora, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: roxo.withOpacity(0.1),
            child: Text(
              mentora['foto'], 
              style: TextStyle(color: roxo, fontWeight: FontWeight.bold, fontSize: 18)
            ),
          ),
          title: Text(
            mentora['nome'],
            style: TextStyle(color: petroleo, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            mentora['cargo'],
            style: const TextStyle(color: Colors.black54, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.school, size: 16, color: roxo),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    mentora['formacao'],
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: roxo),
                const SizedBox(width: 8),
                Text(
                  "Inscrita: ${mentora['data_inscricao']}",
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: (mentora['skills'] as List).map<Widget>((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: greyBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(skill, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.link, size: 18),
                label: const Text("Ver LinkedIn"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0077B5),
                  side: const BorderSide(color: Color(0xFF0077B5)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _processarMentora(index, false),
                    style: TextButton.styleFrom(
                      foregroundColor: coral,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Rejeitar"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _confirmarEnvioEmail(index, mentora['nome']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verde,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text("Aprovar"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}