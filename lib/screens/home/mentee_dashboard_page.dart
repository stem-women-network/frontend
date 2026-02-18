import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/mentee_service.dart';
import 'package:frontend/widgets/mentorada_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'progress_page.dart';
import 'certificates_page.dart';
import 'events_page.dart';
import 'training_materials_page.dart';
import 'first_contact_page.dart';
import 'chat_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';

class MenteeDashboardPage extends StatefulWidget {
  const MenteeDashboardPage({super.key});

  @override
  State<MenteeDashboardPage> createState() => _MenteeDashboardPageState();
}

class _MenteeDashboardPageState extends State<MenteeDashboardPage> {
  final MenteeService _menteeService = MenteeService();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);

  XFile? _dashboardImage;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: const MeetingControlModal(),
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: const SupportDialog(),
      ),
    );
  }

  late Future _fetchData;

  Future getMenteeInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    token ??= "";
    return _menteeService.getMenteeCardInfo(token: token);
  }

  @override
  void initState() {
    _fetchData = getMenteeInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    var children = [
      _buildQuickAction(
        Icons.bar_chart,
        "Meu progresso",
        "Ver linha do tempo",
        laranja,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProgressPage()),
          );
        },
      ),
      _buildQuickAction(
        Icons.emoji_events,
        "Certificado",
        "Ver conquistas",
        coral,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CertificatesPage()),
          );
        },
      ),
      _buildQuickAction(
        Icons.calendar_today,
        "Eventos",
        "Ver próximos",
        petroleo,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventsPage()),
          );
        },
      ),
      _buildQuickAction(
        Icons.menu_book,
        "Treinamento",
        "Materiais",
        laranja,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TrainingMaterialsPage(),
            ),
          );
        },
      ),
      _buildQuickAction(
        Icons.front_hand,
        "Primeiro Contato",
        "Registrar",
        coral,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FirstContactPage()),
          );
        },
      ),
      _buildQuickAction(
        Icons.support_agent,
        "Ouvidoria",
        "Fale com a organização",
        brandColor,
        onTap: () => _showSupportDialog(context),
      ),
    ];

    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          "STEM Women Network",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildHeaderIcon(Icons.bar_chart),
                          const SizedBox(width: 12),
                          _buildIconButton(
                            icon: Icons.calendar_month,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EventsPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          _buildIconButton(
                            icon: Icons.person,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfilePage(),
                                ),
                              );
                              if (result != null && result is XFile) {
                                setState(() {
                                  _dashboardImage = result;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 12),
                          _buildIconButton(
                            icon: Icons.settings,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),
                  FutureBuilder(
                    future: _fetchData,
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        final mentee = asyncSnapshot.data;
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: _cardDecoration(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MenteeInfo(
                                          mentoradaName: mentee["name"],
                                          curso: mentee["course"],
                                          semestre: mentee["semester"],
                                          disponibilidade: [
                                            mentee["availability"],
                                          ],
                                          estadoMentoria: mentee["status"],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: _cardDecoration(),
                        );
                      }
                    },
                  ),

                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(25),
                  //   decoration: _cardDecoration(),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.all(4),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                  //           ],
                  //         ),
                  //         child: CircleAvatar(
                  //           radius: 42,
                  //           backgroundColor: coral,
                  //           backgroundImage: _dashboardImage != null
                  //               ? (kIsWeb
                  //                   ? NetworkImage(_dashboardImage!.path)
                  //                   : FileImage(File(_dashboardImage!.path)) as ImageProvider)
                  //               : null,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 20),

                  //       // Expanded(
                  //       //   child: Column(
                  //       //     crossAxisAlignment: CrossAxisAlignment.start,
                  //       //     children: [
                  //       //       const Text("Carolina Oliveira", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  //       //       const SizedBox(height: 6),
                  //       //       const Text("Ciência da Computação • 3º Semestre", style: TextStyle(color: Colors.black54, fontSize: 13)),
                  //       //       const SizedBox(height: 15),
                  //       //       Wrap(
                  //       //         spacing: 10,
                  //       //         runSpacing: 10,
                  //       //         children: [
                  //       //           _buildBadge("Match encontrado", Colors.green.shade50, Colors.green.shade700),
                  //       //           _infoText(Icons.calendar_today, "Manhã e tarde"),
                  //       //           _infoText(Icons.people_outline, "2 mentoras"),
                  //       //         ],
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 25),

                  IntrinsicHeight(
                    child: isMobile
                        ? Column(
                            children: [
                              _buildMentoraCard(),
                              const SizedBox(height: 25),
                              _buildEncontroCard(context),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: _buildMentoraCard()),
                              const SizedBox(width: 25),
                              Expanded(child: _buildEncontroCard(context)),
                            ],
                          ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Histórico de encontros",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildHistoryItem(
                          "Introdução e objetivos",
                          "15 Dez 2024",
                          "#8832",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(height: 1),
                        ),
                        _buildHistoryItem(
                          "Planejamento de carreiras",
                          "22 Dez 2024",
                          "#9941",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: isMobile ? 4.5 : 2.2,
                    children: children,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  Widget _buildMentoraCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Minha mentora",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: laranja.withOpacity(0.2),
                child: Icon(Icons.person, color: laranja),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ana Paula Serra",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Dev Sênior",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            children: [_buildTag("Desenvolvimento"), _buildTag("Data Science")],
          ),
          const Spacer(),
          const SizedBox(height: 15),
          Row(
            children: [
              _textLink("Ver perfil"),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatPage(otherId: "", actor: "mentee"),
                    ),
                  );
                },
                child: Text(
                  "Mensagem",
                  style: TextStyle(
                    color: petroleo,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEncontroCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Próximo encontro",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _infoRow(Icons.calendar_today, "28 Janeiro, 2025", isDark: true),
          const SizedBox(height: 10),
          _infoRow(Icons.access_time, "14:00 - 15:00", isDark: true),
          const SizedBox(height: 12),
          const Text(
            "Tópico: Revisão de Currículo",
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _showConfirmationDialog(context),
              style: FilledButton.styleFrom(
                backgroundColor: petroleo,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Registrar Encontro",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String date, String code) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            "CÓD: $code",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(
    IconData icon,
    String title,
    String sub,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: brandColor, size: 20),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: brandColor, size: 20),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textCol,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildTag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _infoText(IconData icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 14, color: Colors.black45),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
    ],
  );

  Widget _infoRow(IconData icon, String text, {bool isDark = false}) => Row(
    children: [
      Icon(icon, size: 16, color: isDark ? petroleo : Colors.black45),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.black87 : Colors.black54,
          fontWeight: isDark ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    ],
  );

  Widget _textLink(String text) => InkWell(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        color: petroleo,
        fontSize: 12,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

// =========================================================
// MODAL DE CONFIRMAÇÃO DE ENCONTRO (Restaurado Estilo Bonito)
// =========================================================
class MeetingControlModal extends StatefulWidget {
  const MeetingControlModal({super.key});

  @override
  State<MeetingControlModal> createState() => _MeetingControlModalState();
}

class _MeetingControlModalState extends State<MeetingControlModal> {
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color inputGrey = const Color.fromARGB(255, 217, 217, 217);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
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
                    child: Icon(
                      Icons.verified_user_outlined,
                      color: petroleo,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Double Check de Encontro",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: petroleo,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Confirme a reunião com o código",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Em que data ocorreu?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(primary: petroleo),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    _dateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  });
                }
              },
              decoration: _inputDecoration().copyWith(
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: petroleo,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Código de Validação",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _codeController,
              decoration: _inputDecoration().copyWith(
                hintText: "Digite o código (ex: #1234)",
                prefixIcon: Icon(
                  Icons.vpn_key_outlined,
                  size: 18,
                  color: petroleo,
                ),
              ),
            ),

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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: petroleo,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Encontro validado com sucesso!",
                            ),
                            backgroundColor: petroleo,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: petroleo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Confirmar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: inputGrey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: petroleo, width: 1.5),
      ),
    );
  }
}

// ==========================================
// MODAL DE SUPORTE (OUVIDORIA)
// ==========================================
class SupportDialog extends StatefulWidget {
  const SupportDialog({super.key});

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color inputGrey = const Color.fromARGB(255, 217, 217, 217);
  final TextEditingController _msgController = TextEditingController();
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
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
                    child: Icon(Icons.support_agent, color: petroleo, size: 30),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Ouvidoria & Suporte",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: petroleo,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Como podemos ajudar você hoje?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Motivo do contato",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedReason,
              items: [
                "Troca de Mentor",
                "Suporte Técnico",
                "Denúncia",
                "Outros",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedReason = v),
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sua mensagem",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _msgController,
              maxLines: 4,
              decoration: _inputDecoration().copyWith(
                hintText: "Descreva sua solicitação...",
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Mensagem enviada com sucesso!"),
                      backgroundColor: petroleo,
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: petroleo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Enviar Solicitação",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: inputGrey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: petroleo, width: 1.5),
      ),
    );
  }
}
