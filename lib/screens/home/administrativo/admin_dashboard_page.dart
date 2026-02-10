import 'package:flutter/material.dart';
import 'package:frontend/screens/home/administrativo/recent_activities_page.dart';
import 'university_list_page.dart';
import 'reports_page.dart';
import 'match_authorization_page.dart'; 
import 'mentor_approval_page.dart'; 

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);
  final Color coral = const Color(0xFFE4645B);
  final Color verde = const Color(0xFF43A047);
  final Color roxo = const Color(0xFF6C63FF); 

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 35),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const UniversityListPage())
                          ),
                          child: _buildStatCard("Universidades", "12", Icons.account_balance, petroleo),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(child: _buildStatCard("Mentoras", "154", Icons.groups, laranja)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildStatCard("Matches Ativos", "312", Icons.handshake, verde)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildStatCard("Desistências", "4%", Icons.trending_down, coral)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text("Ações Pendentes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  _buildAlertCard(
                    color: laranja,
                    icon: Icons.notifications_active,
                    title: "Matches Sugeridos",
                    subtitle: "O algoritmo encontrou 5 novos pares compatíveis.",
                    buttonText: "REVISAR MATCHES",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchAuthorizationPage())),
                  ),

                  const SizedBox(height: 15),

                  _buildAlertCard(
                    color: roxo,
                    icon: Icons.person_add_alt_1,
                    title: "Novas Mentoras Inscritas",
                    subtitle: "8 perfis aguardando validação de LinkedIn e Experiência.",
                    buttonText: "VALIDAR MENTORAS",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MentorApprovalPage()));
                    },
                  ),

                  const SizedBox(height: 30),

                  if (isMobile) 
                    _buildUniversitiesSection()
                  else
                    _buildUniversitiesSection(),

                  const SizedBox(height: 30),

                  _buildSectionCard(
                    title: "Atividades Recentes",
                    headerAction: TextButton(
                      onPressed: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const RecentActivitiesPage())
                      ),
                      style: TextButton.styleFrom(foregroundColor: petroleo),
                      child: const Text("Ver tudo", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    child: Column(
                      children: [
                        _buildActivityRow("Novo match aprovado", "Instituto Mauá: Ana C. → Maria S.", "2h atrás"),
                        const Divider(height: 24),
                        _buildActivityRow("Relatório Gerado", "USP exportou dados mensais consolidados.", "45 min atrás"),
                        const Divider(height: 24),
                        _buildActivityRow("Nova Mentora Cadastrada", "Beatriz L. aguardando validação.", "1h atrás"),
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

  Widget _buildAlertCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: Text(buttonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Administrador STEM", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text("Gestão Global da Rede STEM Women Network", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
        Row(
          children: [
            _buildHeaderIcon(Icons.analytics_outlined),
            const SizedBox(width: 10),
            _buildHeaderIcon(Icons.language),
            const SizedBox(width: 10),
            _buildHeaderIcon(Icons.person_search),
            const SizedBox(width: 10),
            _buildHeaderIcon(Icons.settings),
          ],
        ),
      ],
    );
  }

  Widget _buildUniversitiesSection() {
    return _buildSectionCard(
      title: "Universidades Parceiras",
      child: Column(
        children: [
          _buildUniversityItem("Instituto Mauá de Tecnologia", "Coordenador: Carlos Mendes", "32 Matches"),
          const Divider(),
          _buildUniversityItem("USP - São Paulo", "Coordenadora: Ana Paula", "85 Matches"),
          const Divider(),
          _buildUniversityItem("UNICAMP", "Coordenador: Marcos Silva", "64 Matches"),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsPage()));
              },
              icon: const Icon(Icons.download, size: 18),
              label: const Text("Baixar Relatórios Consolidados (CSV)"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child, Widget? headerAction}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              if (headerAction != null) headerAction,
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 10, color: Colors.grey.shade600), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String title, String sub, String time) {
    return Row(children: [
      const Icon(Icons.circle, size: 8, color: Colors.blue),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(sub, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ])),
      Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
    ]);
  }

  Widget _buildUniversityItem(String name, String coord, String stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: brandColor.withOpacity(0.1), child: const Icon(Icons.business, size: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(coord, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ]),
          ),
          Text(stats, style: TextStyle(color: petroleo, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 45, height: 45,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Icon(icon, color: brandColor, size: 22),
    );
  }
}