import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/mentora/matching.dart';
import 'package:frontend/screens/mentora/register_meeting.dart';

class MentoraDashboard extends StatefulWidget {
  const MentoraDashboard({super.key});

  @override
  State<MentoraDashboard> createState() => _MentoraDashboardState();
}

class _MentoraDashboardState extends State<MentoraDashboard> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);
  final Color verdeSucesso = const Color(0xFF2E7D32); // Verde padronizado
  final Color inputGrey = const Color.fromARGB(255, 240, 240, 240);

  String _dataProxima = "28/01/2026";
  String _horarioProxima = "14:00";
  String _temaProxima = "Revisão de Currículo";
  String _linkMeet = "meet.google.com/abc-defg-hij";

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
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: petroleo.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit_calendar, color: petroleo, size: 30),
                    ),
                    const SizedBox(height: 15),
                    Text("Reagendar por Imprevisto",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: petroleo)),
                    const SizedBox(height: 5),
                    const Text("Atualize os detalhes da reunião.",
                        style: TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildStyledLabel("Tema da Reunião"),
              _buildStyledField(temaController, "Ex: Revisão de metas", Icons.topic),
              const SizedBox(height: 20),
              _buildStyledLabel("Nova Data"),
              _buildStyledField(dataController, "Selecione a data", Icons.calendar_today, isDate: true),
              const SizedBox(height: 20),
              _buildStyledLabel("Novo Horário"),
              _buildStyledField(horaController, "Selecione o horário", Icons.access_time, isTime: true),
              const SizedBox(height: 20),
              _buildStyledLabel("Link do Meet"),
              _buildStyledField(linkController, "Link do Google Meet", Icons.link),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: petroleo),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Cancelar",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: petroleo)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 50,
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
                        style: FilledButton.styleFrom(
                          backgroundColor: petroleo,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Salvar",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
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
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 35),
                  _buildSectionTitle("Mentorada Ativa"),
                  const SizedBox(height: 15),
                  _buildActiveMenteeCard(),
                  const SizedBox(height: 25),
                  IntrinsicHeight(
                    child: isMobile
                        ? Column(children: [
                            _buildRegisterCard(),
                            const SizedBox(height: 20),
                            _buildNextMeetingCard(),
                          ])
                        : Row(children: [
                            Expanded(child: _buildRegisterCard()),
                            const SizedBox(width: 25),
                            Expanded(child: _buildNextMeetingCard()),
                          ]),
                  ),
                  const SizedBox(height: 35),
                  _buildSectionTitle("Histórico de Encontros"),
                  const SizedBox(height: 15),
                  _buildMeetingHistory(),
                  const SizedBox(height: 35),
                  _buildSectionTitle("Ações e Suporte"),
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


  Widget _buildRegisterCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.history_edu, color: verdeSucesso, size: 32), // Ícone em verde
          const SizedBox(height: 15),
          const Text("Registrar Encontro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 8),
          const Text("Lance o resumo e defina o próximo passo.", style: TextStyle(fontSize: 12, color: Colors.black45)),
          const Spacer(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterMeeting())),
              style: FilledButton.styleFrom(backgroundColor: verdeSucesso, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), // Botão em verde
              child: const Text("Registrar", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextMeetingCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.video_camera_front, color: petroleo, size: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                child: Text("Agendado", style: TextStyle(color: Colors.green.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(_temaProxima, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          Text("$_dataProxima às $_horarioProxima", style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              children: [
                const Icon(Icons.link, size: 16, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text(_linkMeet, style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _reagendarReuniao,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: petroleo), // Borda em azul (petroleo)
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Imprevisto", style: TextStyle(color: petroleo, fontWeight: FontWeight.bold, fontSize: 12)), // Texto em azul
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(backgroundColor: petroleo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text("Meet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
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
      crossAxisCount: isMobile ? 1 : 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: isMobile ? 4.5 : 2.2,
      children: [
        _actionBtn(Icons.bar_chart, "Desempenho", "Estatísticas", laranja),
        _actionBtn(Icons.calendar_today, "Eventos", "Próximas datas", petroleo),
        _actionBtn(Icons.library_books, "Materiais", "Arquivos de apoio", laranja),
        _actionBtn(Icons.front_hand, "Primeiro Contato", "Registrar", verdeSucesso), // Atualizado para verde
        _actionBtn(Icons.history, "Mentoradas", "Histórico", petroleo),
        _actionBtn(Icons.support_agent, "Ouvidoria", "Suporte", brandColor, onTap: _showSupportDialog),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "STEM Women Network",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _buildHeaderIconButton(Icons.bar_chart),
            const SizedBox(width: 12),
            _buildHeaderIconButton(Icons.calendar_month),
            const SizedBox(width: 12),
            _buildHeaderIconButton(Icons.person_outline),
            const SizedBox(width: 12),
            _buildHeaderIconButton(Icons.settings),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIconButton(IconData icon) {
    return Container(
      height: 45, width: 45,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: brandColor, size: 22),
    );
  }

  Widget _buildActiveMenteeCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 35, backgroundColor: laranja.withOpacity(0.1), child: Icon(Icons.person, color: laranja, size: 30)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Carolina Oliveira", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("Ciência da Computação • 3º Semestre", style: TextStyle(color: Colors.black45, fontSize: 13)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildBadge("Em andamento", petroleo.withOpacity(0.1), petroleo),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {},
                          child: Text("Ver perfil", 
                            style: TextStyle(color: petroleo, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline, color: petroleo)),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Progresso do Ciclo", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
              Text("60%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: petroleo)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.6, backgroundColor: Colors.grey.shade100, color: petroleo, minHeight: 8, borderRadius: BorderRadius.circular(10)),
        ],
      ),
    );
  }

  Widget _buildMeetingHistory() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _historyItem("Revisão de Currículo", "15/01/2026", "Validado"),
          const Divider(height: 30),
          _historyItem("Primeiro Contato", "08/01/2026", "Validado"),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String title, String sub, Color color, {VoidCallback? onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade100)),
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 22)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(fontSize: 10, color: Colors.black45))])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyItem(String title, String date, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(date, style: const TextStyle(color: Colors.black45, fontSize: 12))]),
        _buildBadge(status, Colors.green.withOpacity(0.1), Colors.green),
      ],
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 8))]);
  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _buildBadge(String text, Color bg, Color txt) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)), child: Text(text, style: TextStyle(color: txt, fontSize: 10, fontWeight: FontWeight.bold)));

  Widget _buildStyledLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)));
  Widget _buildStyledField(TextEditingController controller, String hint, IconData icon, {bool isDate = false, bool isTime = false}) {
    return TextField(
      controller: controller,
      readOnly: isDate || isTime,
      onTap: () async {
        if (isDate) {
          DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2030));
          if (picked != null) controller.text = "${picked.day}/${picked.month}/${picked.year}";
        } else if (isTime) {
          TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
          if (picked != null) controller.text = picked.format(context);
        }
      },
      decoration: InputDecoration(hintText: hint, suffixIcon: Icon(icon, color: petroleo, size: 18), filled: true, fillColor: inputGrey, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
    );
  }

  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Ouvidoria", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Deseja entrar em contato com o suporte da rede?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: brandColor), child: const Text("Confirmar")),
        ],
      ),
    );
  }
}