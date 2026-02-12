import 'package:flutter/material.dart';
import 'package:frontend/services/admin_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeApprovalPage extends StatefulWidget {
  const MenteeApprovalPage({super.key});

  @override
  State<MenteeApprovalPage> createState() => _MenteeApprovalPageState();
}

class _MenteeApprovalPageState extends State<MenteeApprovalPage> {
  final AdminService _adminService = AdminService();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color roxo = const Color(0xFF6C63FF);
  final Color verde = const Color(0xFF43A047);
  final Color coral = const Color(0xFFE4645B);
  final Color greyBg = const Color(0xFFF0F2F5);

  late Future _fetchData;

  Future _getApprovals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    token ??= "";
    return _adminService.getApprovalsMentee(token: token);
  }

  List<dynamic> _mentoradasPendentes = [];

  @override
  void initState() {
    _fetchData = _getApprovals();
    super.initState();
  }

  void _processarMentee(String menteeId, bool aprovada) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    token ??= "";

    await _adminService.updateApprovalMentee(
      menteeId: menteeId,
      token: token,
      approved: aprovada,
    );
    setState(() {
        _fetchData = _getApprovals();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              aprovada ? Icons.mark_email_read : Icons.cancel,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                aprovada
                    ? "Mentee aprovada! E-mail de confirmação enviado."
                    : "Mentee rejeitada.",
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

  Future<void> _confirmarEnvioEmail(String menteeId, String nome) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                Text("Deseja aprovar a mentorada $nome?"),
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
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: verde,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Enviar E-mail e Aprovar"),
              onPressed: () {
                Navigator.of(context).pop();
                _processarMentee(menteeId, true);
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
          "Validação de Menteeas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchData,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              _mentoradasPendentes = asyncSnapshot.data;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                itemCount: _mentoradasPendentes.length,
                itemBuilder: (context, index) {
                  return _buildMenteeCard(_mentoradasPendentes[index], index);
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Tudo limpo!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMenteeCard(Map<String, dynamic> mentorada, int index) {
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
          ),
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
              mentorada['foto'] ?? mentorada['nome'][0],
              style: TextStyle(
                color: roxo,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          title: Text(
            mentorada['nome'],
            style: TextStyle(
              color: petroleo,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            mentorada['curso'],
            style: const TextStyle(color: Colors.black54, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            const Divider(),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Icon(Icons.calendar_today, size: 16, color: roxo),
            //     const SizedBox(width: 8),
            //     Text(
            //       "Inscrita: ${mentorada['data_inscricao']}",
            //       style: const TextStyle(fontSize: 13, color: Colors.black87),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: (mentorada['skills'] as List).map<Widget>((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: greyBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  print(mentorada['linkedin']);
                },
                icon: const Icon(Icons.link, size: 18),
                label: const Text("Ver LinkedIn"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0077B5),
                  side: const BorderSide(color: Color(0xFF0077B5)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _processarMentee(mentorada['id'], false),
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
                    onPressed: () =>
                        _confirmarEnvioEmail(mentorada['id'], mentorada['nome']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verde,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text("Aprovar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
