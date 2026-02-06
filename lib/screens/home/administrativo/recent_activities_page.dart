import 'package:flutter/material.dart';

class RecentActivitiesPage extends StatefulWidget {
  const RecentActivitiesPage({super.key});

  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  String _selectedFilter = "Tudo";

  final List<String> _filters = ["Tudo", "Matches", "Rescisões", "Relatórios", "Gestão"];

  final List<Map<String, dynamic>> _allActivities = [
    {
      "icon": Icons.handshake,
      "title": "Novo Match",
      "desc": "Instituto Mauá: Ana C. → Maria S.",
      "time": "Hoje, 10:30",
      "category": "Matches"
    },
    {
      "icon": Icons.file_download,
      "title": "Relatório Gerado",
      "desc": "USP exportou dados mensais consolidados.",
      "time": "Hoje, 09:45",
      "category": "Relatórios"
    },
    {
      "icon": Icons.warning_amber_rounded,
      "title": "Desistência",
      "desc": "UFSC reportou rescisão Mentora #882.",
      "time": "Hoje, 08:00",
      "category": "Rescisões"
    },
    {
      "icon": Icons.person_add,
      "title": "Novo Coordenador",
      "desc": "Prof. Ricardo adicionado ao IMT.",
      "time": "Ontem, 16:20",
      "category": "Gestão"
    },
    {
      "icon": Icons.task_alt,
      "title": "Mentoria Finalizada",
      "desc": "USP: 14/14 encontros concluídos.",
      "time": "14 Jan, 11:00",
      "category": "Matches"
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredActivities = _selectedFilter == "Tudo"
        ? _allActivities
        : _allActivities.where((item) => item['category'] == _selectedFilter).toList();

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
                _buildFilters(),
                
                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
                  ),
                  child: filteredActivities.isEmpty 
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Nenhuma atividade encontrada.", style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredActivities.length,
                      separatorBuilder: (context, index) => const Divider(height: 32),
                      itemBuilder: (context, index) {
                        final item = filteredActivities[index];
                        return _buildFullActivityItem(
                          item['icon'],
                          item['title'],
                          item['desc'],
                          item['time'],
                        );
                      },
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
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Chip(
                label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : brandColor, fontSize: 12, fontWeight: FontWeight.bold)),
                backgroundColor: isSelected ? petroleo : Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: BorderSide(color: isSelected ? petroleo : Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
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