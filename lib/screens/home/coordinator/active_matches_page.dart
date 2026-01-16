import 'package:flutter/material.dart';

class ActiveMatchesPage extends StatefulWidget {
  const ActiveMatchesPage({super.key});

  @override
  State<ActiveMatchesPage> createState() => _ActiveMatchesPageState();
}

class _ActiveMatchesPageState extends State<ActiveMatchesPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  List<Map<String, dynamic>> activeMatches = [
    {"student": "Alice Ferreira", "mentor": "Ana Paula Serra", "company": "Google", "date": "10/01/2026"},
    {"student": "Carolina Souza", "mentor": "Mariana Luz", "company": "Microsoft", "date": "05/01/2026"},
  ];

  // Modal Simples para Troca
  void _showSwitchModal(BuildContext context, int index, bool isStudent) {
  // Lista de opções para pesquisa
  final List<Map<String, String>> allOptions = isStudent 
    ? [
        {"name": "Fernanda Lima", "sub": "Engenharia"},
        {"name": "Beatriz Silva", "sub": "Computação"},
        {"name": "Mariana Luz", "sub": "Sistemas"},
        {"name": "Julia Costa", "sub": "Produção"},
      ]
    : [
        {"name": "Fernanda Lima", "sub": "Amazon"},
        {"name": "Beatriz Silva", "sub": "Meta"},
        {"name": "Mariana Luz", "sub": "Google"},
        {"name": "Carla Souza", "sub": "Microsoft"},
      ];

  // Estado local para o filtro de pesquisa
  String query = "";

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder( // StatefulBuilder para atualizar a lista ao digitar
      builder: (context, setModalState) {
        // Filtra a lista com base no que foi digitado
        final filteredOptions = allOptions
            .where((opt) => opt["name"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 330), // Largura consistente
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isStudent ? "Trocar Aluna" : "Trocar Mentora",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Campo de Pesquisa Funcional
                  TextField(
                    onChanged: (value) {
                      setModalState(() => query = value); // Atualiza a lista filtrada
                    },
                    decoration: InputDecoration(
                      hintText: "Pesquisar nome...",
                      prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF8F9FA),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Lista de Opções Filtrada
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: filteredOptions.isEmpty 
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text("Nenhum resultado", style: TextStyle(color: Colors.grey))),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: filteredOptions.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final item = filteredOptions[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 16,
                                backgroundColor: petroleo.withOpacity(0.1),
                                child: Icon(Icons.person, color: petroleo, size: 16),
                              ),
                              title: Text(item["name"]!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                              subtitle: Text(item["sub"]!, style: const TextStyle(fontSize: 12)),
                              onTap: () {
                                setState(() {
                                  if (isStudent) activeMatches[index]["student"] = item["name"];
                                  else activeMatches[index]["mentor"] = item["name"];
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildOptionItem(String name, String sub, int index, bool isStudent) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: petroleo.withOpacity(0.1), child: Icon(Icons.person, color: petroleo, size: 20)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.add_circle_outline, color: Colors.green),
      onTap: () {
        setState(() {
          if (isStudent) activeMatches[index]["student"] = name;
          else activeMatches[index]["mentor"] = name;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Match atualizado com sucesso!")));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text("Matches Ativos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            _buildSearchField(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: activeMatches.length,
                itemBuilder: (context, index) {
                  final match = activeMatches[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Lado Aluna
                            Expanded(
                              child: InkWell(
                                onTap: () => _showSwitchModal(context, index, true),
                                child: _buildPersonBox("Aluna", match["student"], Icons.school, Colors.orange),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.sync, color: Colors.grey, size: 18),
                            ),
                            // Lado Mentora
                            Expanded(
                              child: InkWell(
                                onTap: () => _showSwitchModal(context, index, false),
                                child: _buildPersonBox("Mentora", match["mentor"], Icons.business_center, petroleo, isRight: true),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(match["company"], style: TextStyle(fontWeight: FontWeight.bold, color: petroleo, fontSize: 13)),
                            Text(match["date"], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonBox(String label, String name, IconData icon, Color color, {bool isRight = false}) {
    return Column(
      crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isRight) Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            if (isRight) ...[const SizedBox(width: 4), Icon(icon, size: 12, color: color)],
          ],
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis),
        Text("Tocar para trocar", style: TextStyle(fontSize: 9, color: petroleo.withOpacity(0.6))),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Buscar match...",
        prefixIcon: Icon(Icons.search, color: petroleo, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }
}