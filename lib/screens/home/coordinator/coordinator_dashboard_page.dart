import 'package:flutter/material.dart';
import 'manage_students_page.dart';
import 'reports_page.dart';
import 'new_event_page.dart';
import 'manage_events_page.dart';
import 'student_list_page.dart';
import 'active_matches_page.dart'; // Import da página de matches

class CoordinatorDashboardPage extends StatefulWidget {
  const CoordinatorDashboardPage({super.key});

  @override
  State<CoordinatorDashboardPage> createState() => _CoordinatorDashboardPageState();
}

class _CoordinatorDashboardPageState extends State<CoordinatorDashboardPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);
  final Color coral = const Color(0xFFE4645B);
  final Color verde = const Color(0xFF43A047);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

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
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "STEM Women Network",
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Painel do Coordenador - IMT",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildHeaderIcon(Icons.notifications_none),
                          const SizedBox(width: 12),
                          _buildHeaderIcon(Icons.settings),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: _cardDecoration(),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: petroleo,
                            child: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 35),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Prof. Carlos Mendes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              const Text("Coordenador • Instituto Mauá de Tecnologia", style: TextStyle(color: Colors.black54, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- STATS COM LINKS ---
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentListPage())),
                          child: _buildStatCard("Alunas Inscritas", "47", Icons.school, laranja),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveMatchesPage())),
                          child: _buildStatCard("Matches Ativos", "32", Icons.handshake, verde),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageEventsPage())),
                          child: _buildStatCard("Eventos Criados", "5", Icons.event_note, coral),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text("Gestão da Universidade", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 3.5,
                    children: [
                      _buildQuickAction(
                        Icons.event_available, 
                        "Meus Eventos", 
                        "Ver QR Code e Presenças", 
                        petroleo, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageEventsPage())),
                      ),
                      
                      _buildQuickAction(
                        Icons.groups, 
                        "Gerenciar Alunas", 
                        "Lista de inscritas", 
                        laranja, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageStudentsPage())),
                      ),
                      
                      _buildQuickAction(
                        Icons.add_box, 
                        "Novo Evento", 
                        "Criar para universidade", 
                        coral, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewEventPage())),
                      ),
                      
                      _buildQuickAction(
                        Icons.analytics, 
                        "Relatórios", 
                        "Taxa de adesão", 
                        brandColor, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsPage())),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Eventos da Universidade", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageEventsPage())), 
                              child: const Text("Ver todos")
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        _buildEventItem("Workshop: Carreira em Dados", "15 Fev • Auditório A", true),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Divider(height: 1)),
                        _buildEventItem("Roda de Conversa: Mulheres em Tech", "20 Fev • Sala 302", true),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Divider(height: 1)),
                        _buildEventItem("Palestra Internacional (Online)", "10 Mar • Zoom", false),
                      ],
                    ),
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
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 8))],
  );

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey.shade600), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String subtitle, Color color, {required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventItem(String title, String info, bool isActive) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageEventsPage())),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive ? laranja.withOpacity(0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.calendar_today, color: isActive ? laranja : Colors.grey, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isActive ? Colors.black87 : Colors.grey)),
                const SizedBox(height: 4),
                Text(info, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
              child: Text("Ativo", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
            ),
        ],
      ),
    );
  }
}