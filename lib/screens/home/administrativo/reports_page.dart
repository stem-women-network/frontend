import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color greyBorder = const Color(0xFFE0E0E0);
  final Color textDark = const Color(0xFF2D3436);

  // Variáveis de Estado para os Filtros
  String? _selectedCategory;
  String? _selectedPeriod;

  // Opções dos Dropdowns
  final List<String> _categories = [
    "Consolidado Geral (Tudo)",
    "Lista de Mentoras",
    "Lista de Mentoradas",
    "Status dos Matches",
    "Desistências e Feedbacks",
    "Engajamento por Universidade"
  ];

  final List<String> _periods = [
    "Últimos 30 dias",
    "Este Semestre",
    "Ano Atual (2025)",
    "Todo o Período"
  ];

  void _simulateDownload() {
    if (_selectedCategory == null || _selectedPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selecione o Tipo de Dado e o Período."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Simulação do Download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text("Gerando $_selectedCategory ($_selectedPeriod)...")),
          ],
        ),
        backgroundColor: petroleo,
        duration: const Duration(seconds: 3),
      ),
    );
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
        title: const Text("Central de Relatórios", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- SEÇÃO 1: GERADOR PERSONALIZADO ---
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.tune, color: brandColor),
                          const SizedBox(width: 10),
                          const Text("Exportação Personalizada", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text("Selecione os parâmetros para gerar o arquivo CSV.", 
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                      
                      const SizedBox(height: 30),
                      
                      // Dropdowns Lado a Lado (Responsivo)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Row(
                              children: [
                                Expanded(child: _buildDropdown("Tipo de Dado", _categories, _selectedCategory, (v) => setState(() => _selectedCategory = v))),
                                const SizedBox(width: 20),
                                Expanded(child: _buildDropdown("Período", _periods, _selectedPeriod, (v) => setState(() => _selectedPeriod = v))),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                _buildDropdown("Tipo de Dado", _categories, _selectedCategory, (v) => setState(() => _selectedCategory = v)),
                                const SizedBox(height: 20),
                                _buildDropdown("Período", _periods, _selectedPeriod, (v) => setState(() => _selectedPeriod = v)),
                              ],
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.icon(
                          onPressed: _simulateDownload,
                          icon: const Icon(Icons.download),
                          label: const Text("BAIXAR RELATÓRIO AGORA", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: FilledButton.styleFrom(
                            backgroundColor: brandColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // --- SEÇÃO 2: RELATÓRIOS RÁPIDOS (PRESETS) ---
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 15),
                  child: Text("Downloads Rápidos", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),

                _buildQuickDownloadCard(
                  title: "Relatório de Engajamento Mensal",
                  subtitle: "Resumo automático de matches ativos e sessões realizadas em Setembro.",
                  icon: Icons.bar_chart,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(height: 15),
                _buildQuickDownloadCard(
                  title: "Lista Completa de Universidades",
                  subtitle: "Contatos de coordenadores e estatísticas por campus.",
                  icon: Icons.school,
                  color: Colors.green,
                ),
                const SizedBox(height: 15),
                _buildQuickDownloadCard(
                  title: "Auditoria de Matches (Log)",
                  subtitle: "Histórico técnico de todas as alterações de status.",
                  icon: Icons.security,
                  color: petroleo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildDropdown(String label, List<String> items, String? current, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: current,
          icon: Icon(Icons.keyboard_arrow_down, color: brandColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: greyBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: brandColor, width: 2)),
          ),
          hint: const Text("Selecione...", style: TextStyle(fontSize: 14)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildQuickDownloadCard({required String title, required String subtitle, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2D3436))),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Baixando $title..."), backgroundColor: color));
            },
            icon: Icon(Icons.download_rounded, color: Colors.grey[400]),
          )
        ],
      ),
    );
  }
}