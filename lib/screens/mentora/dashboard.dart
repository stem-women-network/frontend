import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/screens/mentora/matching.dart';
import 'package:frontend/screens/mentora/register_meeting.dart';
import 'package:frontend/screens/mentora/send_materials_page.dart';
import 'package:frontend/screens/home/chat_page.dart';
import 'package:frontend/screens/home/settings_page.dart';
import 'package:frontend/screens/mentora/mentee_history_page.dart';
import 'package:frontend/screens/mentora/mentor_training_page.dart';

class MentoraDashboard extends StatefulWidget {
  const MentoraDashboard({super.key});

  @override
  State<MentoraDashboard> createState() => _MentoraDashboardState();
}

class _MentoraDashboardState extends State<MentoraDashboard> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);
  final Color verdeSucesso = const Color(0xFF2E7D32);
  final Color inputGrey = const Color.fromARGB(255, 240, 240, 240);

  String _dataProxima = "28/01/2026";
  String _horarioProxima = "14:00";
  String _temaProxima = "Revisão de Currículo";
  String _linkMeet = "meet.google.com/abc-defg-hij";

  Future<void> _abrirMeet() async {
    final Uri url = Uri.parse(_linkMeet.startsWith('http') ? _linkMeet : 'https://$_linkMeet');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Não foi possível abrir o link.")));
      }
    }
  }

  void _reagendarReuniao() {
    final TextEditingController temaController = TextEditingController(text: _temaProxima);
    final TextEditingController dataController = TextEditingController(text: _dataProxima);
    final TextEditingController horaController = TextEditingController(text: _horarioProxima);
    final TextEditingController linkController = TextEditingController(text: _linkMeet);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: petroleo.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(Icons.edit_calendar, color: petroleo, size: 30),
                ),
              ),
              const SizedBox(height: 15),
              Center(child: Text("Editar Próximo Encontro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: petroleo))),
              const SizedBox(height: 25),
              _buildStyledLabel("Tema"),
              _buildStyledField(temaController, "Tema da reunião", Icons.topic),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildStyledLabel("Data"), _buildStyledField(dataController, "Data", Icons.calendar_today, isDate: true)])),
                  const SizedBox(width: 15),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildStyledLabel("Horário"), _buildStyledField(horaController, "Hora", Icons.access_time, isTime: true)])),
                ],
              ),
              const SizedBox(height: 15),
              _buildStyledLabel("Link do Meet"),
              _buildStyledField(linkController, "Cole o link aqui", Icons.link),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side: BorderSide(color: petroleo), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text("Cancelar", style: TextStyle(color: petroleo, fontWeight: FontWeight.bold)))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          _temaProxima = temaController.text;
                          _dataProxima = dataController.text;
                          _horarioProxima = horaController.text;
                          _linkMeet = linkController.text;
                        });
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(backgroundColor: petroleo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text("Salvar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  
                  _buildSectionTitle("Mentorada Ativa"),
                  const SizedBox(height: 15),
                  _buildMainMenteeCard(),
                  
                  const SizedBox(height: 30),
                  
                  _buildSectionTitle("Gestão da Mentoria"),
                  const SizedBox(height: 15),
                  isMobile 
                    ? Column(children: [_buildRegisterCard(), const SizedBox(height: 15), _buildNextMeetingCard()]) 
                    : IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(child: _buildRegisterCard()), const SizedBox(width: 20), Expanded(child: _buildNextMeetingCard())])),
                  
                  const SizedBox(height: 30),
                  
                  _buildSectionTitle("Acesso Rápido"),
                  const SizedBox(height: 15),
                  _buildQuickActionsGrid(isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Olá, Mentora", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
            const Text("STEM Women Network", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            _buildHeaderIcon(Icons.notifications_none, () {}),
            const SizedBox(width: 10),
            _buildHeaderIcon(Icons.settings, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()))),
            const SizedBox(width: 10),
            _buildHeaderIcon(Icons.person_outline, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45, width: 45,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: brandColor, size: 22),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold));

  Widget _buildMainMenteeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 32, backgroundColor: laranja.withOpacity(0.1), child: Icon(Icons.person, color: laranja, size: 30)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Carolina Oliveira", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const Text("Ciência da Computação • 3º Semestre", style: TextStyle(color: Colors.black54, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(children: [Icon(Icons.check_circle, size: 14, color: verdeSucesso), const SizedBox(width: 4), Text("Mentoria Ativa", style: TextStyle(color: verdeSucesso, fontSize: 11, fontWeight: FontWeight.bold))]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Progresso do Ciclo", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)), Text("60%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: petroleo))]),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: 0.6, backgroundColor: inputGrey, color: petroleo, minHeight: 8)),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenteeAction(Icons.chat_bubble_outline, "Mensagens", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()))),
              _verticalDivider(),
              _buildMenteeAction(Icons.person_search, "Ver Perfil", () {}),
              _verticalDivider(),
              _buildMenteeAction(Icons.upload_file, "Materiais", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SendMaterialsPage())), isPrimary: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenteeAction(IconData icon, String label, VoidCallback onTap, {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: isPrimary ? petroleo : Colors.black54, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal, color: isPrimary ? petroleo : Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _verticalDivider() => Container(height: 24, width: 1, color: Colors.grey.shade200);

  Widget _buildRegisterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.history_edu, color: verdeSucesso, size: 28),
          const SizedBox(height: 15),
          const Text("Registrar Encontro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          const Text("Valide a presença e o conteúdo.", style: TextStyle(fontSize: 12, color: Colors.black45)),
          const Spacer(),
          const SizedBox(height: 15),
          SizedBox(width: double.infinity, height: 45, child: FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterMeeting())), style: FilledButton.styleFrom(backgroundColor: verdeSucesso, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Registrar", style: TextStyle(fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }

  Widget _buildNextMeetingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.video_camera_front, color: petroleo, size: 28),
          const SizedBox(height: 15),
          Text(_temaProxima, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text("$_dataProxima às $_horarioProxima", style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: inputGrey, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [const Icon(Icons.link, size: 14, color: Colors.blue), const SizedBox(width: 8), Expanded(child: Text(_linkMeet, style: const TextStyle(fontSize: 11, color: Colors.blue), overflow: TextOverflow.ellipsis))]),
          ),
          const Spacer(),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: SizedBox(height: 45, child: OutlinedButton(onPressed: _reagendarReuniao, style: OutlinedButton.styleFrom(side: BorderSide(color: petroleo), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Icon(Icons.edit, size: 18)))),
              const SizedBox(width: 10),
              Expanded(flex: 2, child: SizedBox(height: 45, child: FilledButton(onPressed: _abrirMeet, style: FilledButton.styleFrom(backgroundColor: petroleo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Abrir Meet", style: TextStyle(fontWeight: FontWeight.bold))))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2, 
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 3.2, 
      children: [
        _buildWideActionBtn(Icons.calendar_month, "Eventos", "Ver próximos", petroleo),
        _buildWideActionBtn(Icons.bar_chart, "Meu Progresso", "Ver linha do tempo", laranja),
        _buildWideActionBtn(Icons.front_hand, "Primeiro Contato", "Registrar", verdeSucesso),
        _buildWideActionBtn(
          Icons.history, 
          "Histórico", 
          "Mentorias passadas", 
          petroleo,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MenteeHistoryPage())),
        ),
        _buildWideActionBtn(
          Icons.folder_shared, 
          "Treinamento", 
          "Materiais de apoio", 
          laranja,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MentorTrainingPage())),
        ),
        _buildWideActionBtn(Icons.support_agent, "Ouvidoria", "Fale com a organização", brandColor, onTap: _showSupportDialog),
      ],
    );
  }

  Widget _buildWideActionBtn(IconData icon, String label, String subLabel, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: _cardDecoration(), 
        child: Row(
          children: [
            Container(
              height: 50, width: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 15),
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                  Text(subLabel, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.circular(20), 
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))]
  );
  
  Widget _buildStyledLabel(String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)));
  
  Widget _buildStyledField(TextEditingController c, String h, IconData i, {bool isDate = false, bool isTime = false}) => TextField(controller: c, readOnly: isDate || isTime, onTap: () async { if (isDate) { DateTime? p = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2030)); if (p != null) c.text = "${p.day}/${p.month}/${p.year}"; } else if (isTime) { TimeOfDay? p = await showTimePicker(context: context, initialTime: TimeOfDay.now()); if (p != null) c.text = p.format(context); } }, decoration: InputDecoration(hintText: h, prefixIcon: Icon(i, color: petroleo, size: 18), filled: true, fillColor: inputGrey, contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)));

  void _showSupportDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), title: const Text("Ouvidoria", style: TextStyle(fontWeight: FontWeight.bold)), content: const Text("Contatar suporte?"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")), FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: brandColor), child: const Text("Confirmar"))]));
  }
}