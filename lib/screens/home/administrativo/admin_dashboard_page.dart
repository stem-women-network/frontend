import 'package:flutter/material.dart';
import 'package:frontend/screens/home/administrativo/recent_activities_page.dart';
import 'university_list_page.dart';

// Importação fictícia da página de histórico
// import 'recent_activities_page.dart'; 

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
                  // --- HEADER GLOBAL ---
                  _buildHeader(),

                  const SizedBox(height: 35),

                  // --- MÉTRICAS DE IMPACTO GLOBAL ---
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

                  // --- LAYOUT PRINCIPAL: INSIGHTS E GESTÃO ---
                  if (isMobile) ...[
                    _buildUniversitiesSection(),
                    const SizedBox(height: 20),
                    _buildInsightsSection(),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildUniversitiesSection()),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _buildInsightsSection()),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // --- ATIVIDADES RECENTES COM "VER TUDO" ---
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
                        _buildActivityRow("Alerta de Desistência", "UFSC reportou rescisão Mentora #882.", "2h atrás"),
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

  // --- WIDGETS DE CONTEÚDO ---

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
              onPressed: () {},
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

  Widget _buildInsightsSection() {
    return _buildSectionCard(
      title: "Insights",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Engajamento nos 14 encontros", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 20),
          _buildProgressBar("Meta de Matches", 0.85, verde),
          const SizedBox(height: 15),
          _buildProgressBar("Taxa de Retenção", 0.96, petroleo),
          const SizedBox(height: 15),
          _buildProgressBar("Diários de Bordo", 0.62, laranja),
        ],
      ),
    );
  }

  // --- COMPONENTES ATÔMICOS ---

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

  Widget _buildProgressBar(String label, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Text("${(pct * 100).toInt()}%", style: const TextStyle(fontSize: 12)),
        ]),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: pct, backgroundColor: Colors.grey.shade200, color: color, minHeight: 6),
      ],
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