import 'package:flutter/material.dart';
import 'add_university_page.dart'; // Importe a nova página que criaremos abaixo

class UniversityListPage extends StatefulWidget {
  const UniversityListPage({super.key});

  @override
  State<UniversityListPage> createState() => _UniversityListPageState();
}

class _UniversityListPageState extends State<UniversityListPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);

  // Lista simulada de dados
  final List<Map<String, dynamic>> _allUniversities = [
    {"name": "Instituto Mauá de Tecnologia", "coord": "Carlos Mendes", "matches": "32 Matches", "report": true},
    {"name": "USP - São Paulo", "coord": "Ana Paula Serra", "matches": "85 Matches", "report": true},
    {"name": "UNICAMP", "coord": "Marcos Silva", "matches": "64 Matches", "report": true},
    {"name": "UFSC", "coord": "Juliana Pozzi", "matches": "12 Matches", "report": false},
  ];

  // Lista que será exibida e filtrada
  List<Map<String, dynamic>> _foundUniversities = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _foundUniversities = _allUniversities;
    super.initState();
  }

  // Lógica de pesquisa
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUniversities;
    } else {
      results = _allUniversities
          .where((uni) =>
              uni["name"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              uni["coord"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUniversities = results;
    });
  }

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
        title: const Text("Universidades Inscritas", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de busca fixa no topo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: _buildSearchBar(),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 40.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    children: [
                      _buildSectionCard(
                        title: "Rede STEM Women Network",
                        child: _foundUniversities.isNotEmpty 
                          ? Column(
                              children: _foundUniversities.map((uni) {
                                return Column(
                                  children: [
                                    _buildUniversityListItem(
                                      uni["name"], 
                                      uni["coord"], 
                                      uni["matches"], 
                                      uni["report"]
                                    ),
                                    if (uni != _foundUniversities.last) const Divider(height: 32),
                                  ],
                                );
                              }).toList(),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Nenhuma universidade encontrada.", style: TextStyle(color: Colors.grey)),
                            ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // BOTÃO ADICIONAR FUNCIONAL
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const AddUniversityPage())
                          ),
                          icon: const Icon(Icons.add_business),
                          label: const Text("Cadastrar Nova Instituição", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: brandColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => _runFilter(value),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Buscar por universidade ou coordenador...",
          hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          child,
        ],
      ),
    );
  }

  Widget _buildUniversityListItem(String name, String coordinator, String stats, bool hasReport) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: petroleo.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.account_balance, color: petroleo, size: 22),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Coord: $coordinator", style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(stats, style: TextStyle(color: laranja, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text(hasReport ? "Baixar PDF" : "Sem dados", 
              style: TextStyle(color: hasReport ? petroleo : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, decoration: hasReport ? TextDecoration.underline : TextDecoration.none)),
          ],
        ),
      ],
    );
  }
}