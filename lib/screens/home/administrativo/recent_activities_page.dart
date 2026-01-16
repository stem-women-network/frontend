import 'package:flutter/material.dart';

class RecentActivitiesPage extends StatefulWidget {
  const RecentActivitiesPage({super.key});

  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Atividades da Rede", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // --- FILTROS DE HISTÓRICO ---
                _buildFilters(),
                
                const SizedBox(height: 25),

                // --- LISTA COMPLETA ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
                  ),
                  child: Column(
                    children: [
                      _buildFullActivityItem(Icons.handshake, "Novo Match", "Instituto Mauá: Ana C. → Maria S.", "Hoje, 10:30"),
                      const Divider(height: 32),
                      _buildFullActivityItem(Icons.file_download, "Relatório Gerado", "USP exportou dados mensais consolidados.", "Hoje, 09:45"),
                      const Divider(height: 32),
                      _buildFullActivityItem(Icons.warning_amber_rounded, "Desistência", "UFSC reportou rescisão Mentora #882.", "Hoje, 08:00"),
                      const Divider(height: 32),
                      _buildFullActivityItem(Icons.person_add, "Novo Coordenador", "Prof. Ricardo adicionado ao IMT.", "Ontem, 16:20"),
                      const Divider(height: 32),
                      _buildFullActivityItem(Icons.task_alt, "Mentoria Finalizada", "USP: 14/14 encontros concluídos.", "14 Jan, 11:00"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip("Tudo", true),
          const SizedBox(width: 10),
          _buildFilterChip("Matches", false),
          const SizedBox(width: 10),
          _buildFilterChip("Rescisões", false),
          const SizedBox(width: 10),
          _buildFilterChip("Relatórios", false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Chip(
      label: Text(label, style: TextStyle(color: isSelected ? Colors.white : brandColor, fontSize: 12, fontWeight: FontWeight.bold)),
      backgroundColor: isSelected ? petroleo : Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: isSelected ? petroleo : Colors.white),
    );
  }

  Widget _buildFullActivityItem(IconData icon, String title, String desc, String time) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: brandColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: brandColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}