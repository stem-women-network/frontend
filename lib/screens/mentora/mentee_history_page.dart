import 'package:flutter/material.dart';
import 'package:frontend/services/mentor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeHistoryPage extends StatefulWidget {
  const MenteeHistoryPage({super.key});

  @override
  State<MenteeHistoryPage> createState() => _MenteeHistoryPageState();
}

class _MenteeHistoryPageState extends State<MenteeHistoryPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color verdeSucesso = const Color(0xFF2E7D32);
  final Color cinzaStatus = const Color(0xFF757575);
  final Color vermelhoErro = const Color(0xFFD32F2F);

  MentorService mentorService = MentorService();
  late List<dynamic> _allMentees;

  Future<List<dynamic>?> getMentees() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    token ??= "";
    final mentees = await mentorService.getMenteeHistory(token: token);
    if (mentees == null) {
      return null;
    }
    return mentees;
  }

  String _filter = "Todos";
  final TextEditingController _searchController = TextEditingController();

  late final Future fetchData;

  @override
  void initState() {
    fetchData = getMentees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              "Voltar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Histórico",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 25),

                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "Buscar por nome...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: brandColor),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Filtros (Chips)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["Todos", "Ativa", "Concluída", "Cancelada"]
                          .map((status) {
                            final isSelected = _filter == status;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                label: Text(status),
                                selected: isSelected,
                                onSelected: (val) =>
                                    setState(() => _filter = status),
                                backgroundColor: brandColor.withOpacity(
                                  0.5,
                                ), // Cor inativa (translucida)
                                selectedColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: isSelected ? brandColor : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            // --- LISTA DE CARDS (CORPO BRANCO ARREDONDADO) ---
            FutureBuilder(
              future: fetchData,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  if (asyncSnapshot.data == null) {
                    return _buildEmptyState();
                  }
                  _allMentees = asyncSnapshot.data!;
                  final filteredList = _allMentees.where((mentee) {
                    final matchesFilter =
                        _filter == "Todos" ||
                        mentee['status'] ==
                            _filter.toLowerCase().replaceFirst("í", "i");
                    final matchesSearch = mentee['name']
                        .toString()
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase());
                    return matchesFilter && matchesSearch;
                  }).toList();
                  return Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xFFF5F5F5,
                        ), // Fundo levemente cinza para destacar os cards brancos
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: filteredList.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.all(24),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return _buildMenteeCard(filteredList[index]);
                              },
                            ),
                    ),
                  );
                } else {
                  return _buildEmptyState();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenteeCard(Map<String, dynamic> data) {
    Color statusColor;
    Color statusBg;
    String status = data['status'];

    switch (data['status']) {
      case 'ativa':
        statusColor = verdeSucesso;
        statusBg = verdeSucesso.withOpacity(0.1);
        break;
      case 'concluida':
        statusColor = petroleo;
        statusBg = petroleo.withOpacity(0.1);
        data['status'] = "concluída";
        break;
      case 'cancelada':
        statusColor = vermelhoErro;
        statusBg = vermelhoErro.withOpacity(0.1);
        break;
      default:
        statusColor = cinzaStatus;
        statusBg = Colors.grey.withOpacity(0.1);
    }
    print(data['status']);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: brandColor.withOpacity(0.1),
                child: Text(
                  data['name'].substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brandColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['course'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconInfo(Icons.calendar_today, data['period']),
              _buildIconInfo(
                Icons.history_edu,
                "${data['meetings']} Encontros",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 15),
          Text(
            "Nenhuma mentorada encontrada",
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }
}
