import 'package:flutter/material.dart';

class MentorFirstContactPage extends StatefulWidget {
  const MentorFirstContactPage({super.key});

  @override
  State<MentorFirstContactPage> createState() => _MentorFirstContactPageState();
}

class _MentorFirstContactPageState extends State<MentorFirstContactPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color backgroundGrey = const Color(0xFFF8F9FA);
  final Color errorColor = const Color(0xFFE57373);
  final Color verdeSucesso = const Color(0xFF2E7D32);

  int _contactStatus = 0; 
  
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _helpMessageController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _helpMessageController.dispose();
    super.dispose();
  }

  void _validarVinculo() {
    if (_codeController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O código deve ter 6 dígitos.")),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Vínculo oficializado com sucesso!"), backgroundColor: verdeSucesso),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500), 
              child: Column(
                children: [
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

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 15))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text("Primeiro Contato", 
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: petroleo)
                              ),
                              const SizedBox(height: 8),
                              const Text("Oficialize o vínculo com sua mentorada", 
                                style: TextStyle(fontSize: 14, color: Colors.grey)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        const Text("Você já conseguiu falar com a mentorada?", 
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildOptionBtn(
                                label: "Sim, consegui",
                                isActive: _contactStatus == 1,
                                icon: Icons.check_circle_outline,
                                activeColor: verdeSucesso,
                                onTap: () => setState(() => _contactStatus = 1),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildOptionBtn(
                                label: "Não consegui",
                                isActive: _contactStatus == 2,
                                icon: Icons.error_outline,
                                activeColor: errorColor,
                                onTap: () => setState(() => _contactStatus = 2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: _contactStatus == 1 
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.green.shade100),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.vpn_key_outlined, color: verdeSucesso, size: 20),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Text(
                                            "Perfeito! Peça o código de 6 dígitos que aparece no aplicativo da sua mentorada e digite abaixo para confirmar o início das atividades.",
                                            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  
                                  const Text("Código da Mentorada", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _codeController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 8),
                                    decoration: _inputDecoration().copyWith(
                                      counterText: "",
                                      hintText: "000000",
                                      hintStyle: TextStyle(color: Colors.grey.shade300),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 25),
                                  
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: FilledButton(
                                      onPressed: _validarVinculo,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: petroleo,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: const Text("Confirmar Vínculo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.red.shade100),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.support_agent, color: errorColor, size: 24),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Text(
                                            "Caso você tenha tentado contato por canais oficiais e não obteve resposta, reporte o problema à coordenação.",
                                            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text("Descreva a dificuldade (opcional)", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _helpMessageController,
                                    maxLines: 3,
                                    decoration: _inputDecoration().copyWith(
                                      hintText: "Ex: Tentei contato via WhatsApp e e-mail sem sucesso...",
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: const Text("A coordenação foi notificada."), backgroundColor: errorColor),
                                        );
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: errorColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: const Text("Reportar à Organização", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    ),
                                  ),
                                ],
                              ),
                          crossFadeState: _contactStatus == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                        ),
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

  Widget _buildOptionBtn({
    required String label, 
    required bool isActive, 
    required IconData icon,
    Color? activeColor,
    required VoidCallback onTap
  }) {
    final color = activeColor ?? petroleo;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80, 
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isActive ? color : Colors.grey.shade300, 
            width: isActive ? 2 : 1
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? color : Colors.grey, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? color : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
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