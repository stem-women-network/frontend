import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color backgroundGrey = const Color(0xFFF8F9FA);

  // Estados dos Filtros
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedReportType = 'Taxa de Adesão';
  bool _isGenerating = false;

  final List<String> _reportTypes = [
    'Taxa de Adesão',
    'Desempenho de Mentoras',
    'Evasão/Desistências',
    'Matches Realizados'
  ];

  // Função para formatar data
  String _formatDate(DateTime? date) {
    if (date == null) return "DD/MM/AAAA";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  // Selecionar Data (Modal Pequeno)
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: petroleo,
            colorScheme: ColorScheme.light(primary: petroleo),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  // Simulação de Download com Feedback Visual Real
  Future<void> _generateAndDownloadPdf() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, selecione o período completo."), backgroundColor: Colors.red),
      );
      return;
    }

    // Mostra Dialog de Carregamento
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: petroleo),
                const SizedBox(width: 20),
                const Text("Gerando PDF..."),
              ],
            ),
          ),
        );
      },
    );

    // Simula tempo de processamento
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pop(context); // Fecha o Dialog de loading

      // Mostra Confirmação (Simulando o arquivo baixado)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text("Download Concluído", style: TextStyle(fontSize: 18)),
              ],
            ),
            content: Text(
              "O relatório '${_selectedReportType}_${_startDate!.day}-${_endDate!.day}.pdf' foi salvo no seu dispositivo.",
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                child: Text("Abrir", style: TextStyle(color: petroleo, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Fechar", style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
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
        title: const Text("Relatórios & Métricas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- ÁREA DE FILTROS ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Configurar Relatório", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    
                    _buildLabel("Tipo de Análise"),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedReportType,
                          isExpanded: true,
                          items: _reportTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) => setState(() => _selectedReportType = newValue!),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildLabel("Período de Análise"),
                    const SizedBox(height: 8),
                    
                    // --- SELETOR DE DATAS NOVO (Estilo Input Pequeno) ---
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: petroleo),
                                  const SizedBox(width: 8),
                                  Text(_formatDate(_startDate), style: TextStyle(color: _startDate == null ? Colors.grey : Colors.black87)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("até", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: petroleo),
                                  const SizedBox(width: 8),
                                  Text(_formatDate(_endDate), style: TextStyle(color: _endDate == null ? Colors.grey : Colors.black87)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- DASHBOARD (Prévia) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Prévia dos Dados", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    
                    Row(
                      children: [
                        Expanded(child: _buildMetricCard("Taxa de Adesão", "78%", "+12%", Colors.green)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildMetricCard("Evasão", "4%", "-2%", Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: _buildMetricCard("Novas Mentoras", "15", "+5", Colors.blue)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildMetricCard("Matches Feitos", "42", "+8", Colors.orange)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Crescimento Mensal", style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildBar("Jan", 40),
                                _buildBar("Fev", 60),
                                _buildBar("Mar", 50),
                                _buildBar("Abr", 80),
                                _buildBar("Mai", 70),
                                _buildBar("Jun", 95, isActive: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- BOTÃO DE EXPORTAR ---
              Container(
                padding: const EdgeInsets.all(24),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton.icon(
                    onPressed: _isGenerating ? null : _generateAndDownloadPdf,
                    style: FilledButton.styleFrom(
                      backgroundColor: petroleo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.download),
                    label: const Text(
                      "Baixar Relatório Completo (PDF)",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
    );
  }

  Widget _buildMetricCard(String title, String value, String variation, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              variation,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double heightPerc, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: (120 * heightPerc) / 100,
          decoration: BoxDecoration(
            color: isActive ? petroleo : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}