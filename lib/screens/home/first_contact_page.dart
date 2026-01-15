import 'package:flutter/material.dart';

class FirstContactPage extends StatefulWidget {
  const FirstContactPage({super.key});

  @override
  State<FirstContactPage> createState() => _FirstContactPageState();
}

class _FirstContactPageState extends State<FirstContactPage> {
  // Cores do Projeto (Consistentes)
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color backgroundGrey = const Color(0xFFF8F9FA);

  // Estados
  bool? _contactMade;
  String? _responseTime;
  bool _hasProblem = false;
  final TextEditingController _problemController = TextEditingController();

  final List<String> _responseOptions = [
    'Imediato (mesmo dia)',
    '1 a 2 dias',
    '3 a 5 dias',
    'Mais de uma semana',
    'Não houve resposta'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            children: [
              // --- HEADER SIMPLIFICADO ---
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Voltar",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- CARD PRINCIPAL ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30), // Mais arredondado
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Center(
                      child: Column(
                        children: [
                          Text("Primeiro Contato", 
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: petroleo)
                          ),
                          const SizedBox(height: 8),
                          const Text("Registre o início da mentoria", 
                            style: TextStyle(fontSize: 14, color: Colors.grey)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),

                    // --- BOX DE INFO (Clean) ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: backgroundGrey,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMatchRow("Mentorada", "Maria Silva"),
                          const Divider(height: 25),
                          _buildMatchRow("Curso", "Ciência da Computação - USP"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // --- PERGUNTA 1 ---
                    const Text("Você já entrou em contato?", 
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOptionBtn(
                            label: "Sim",
                            isActive: _contactMade == true,
                            onTap: () => setState(() => _contactMade = true),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildOptionBtn(
                            label: "Ainda não",
                            isActive: _contactMade == false,
                            onTap: () => setState(() => _contactMade = false),
                          ),
                        ),
                      ],
                    ),

                    // --- PERGUNTA 2 (Condicional) ---
                    AnimatedCrossFade(
                      firstChild: Container(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          const Text("Tempo de resposta da mentorada:", 
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _responseTime,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            decoration: _inputDecoration(),
                            items: _responseOptions.map((opt) => DropdownMenuItem(value: opt, child: Text(opt, style: const TextStyle(fontSize: 14)))).toList(),
                            onChanged: (val) => setState(() => _responseTime = val),
                            hint: const Text("Selecione o tempo..."),
                          ),
                        ],
                      ),
                      crossFadeState: _contactMade == true ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),

                    const SizedBox(height: 30),

                    InkWell(
                      onTap: () => setState(() => _hasProblem = !_hasProblem),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(
                              _hasProblem ? Icons.check_box : Icons.check_box_outline_blank,
                              color: _hasProblem ? Colors.redAccent : Colors.grey,
                            ),
                            const SizedBox(width: 10),
                            Text("Tive problemas no contato", 
                              style: TextStyle(
                                color: _hasProblem ? Colors.redAccent : Colors.grey.shade700,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_hasProblem) ...[
                      const SizedBox(height: 10),
                      TextField(
                        controller: _problemController,
                        maxLines: 3,
                        decoration: _inputDecoration().copyWith(
                          hintText: "Descreva o problema brevemente...",
                          fillColor: const Color.fromARGB(255, 243, 243, 243), 
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),

                    // --- BOTÃO DE AÇÃO ---
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                           Navigator.pop(context);
                           // Lógica de salvar...
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: petroleo,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: const Text("Salvar Registro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES (Design System) ---

  Widget _buildMatchRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildOptionBtn({required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? petroleo.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isActive ? petroleo : Colors.grey.shade300, 
            width: isActive ? 1.5 : 1
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? petroleo : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: backgroundGrey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: petroleo, width: 1.5)),
    );
  }
}