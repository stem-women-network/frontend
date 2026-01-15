import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para copiar o código

class FirstContactPage extends StatefulWidget {
  const FirstContactPage({super.key});

  @override
  State<FirstContactPage> createState() => _FirstContactPageState();
}

class _FirstContactPageState extends State<FirstContactPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color backgroundGrey = const Color(0xFFF8F9FA);
  final Color errorColor = const Color(0xFFE57373);
  final Color laranja = const Color(0xFFFE9F43);

  // 0: Neutro, 1: Sucesso (Mostrar Código), 2: Problema (Reportar)
  int _contactStatus = 0; 
  
  // Este é o código que o sistema gerou para a Mentorada passar para a Mentora
  final String _generatedCode = "774123"; 
  
  final TextEditingController _helpMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: Center( // Centraliza na tela
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: ConstrainedBox( // Limita a largura para não ficar esticado
              constraints: const BoxConstraints(maxWidth: 500), 
              child: Column(
                children: [
                  // --- HEADER ---
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
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 15))
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
                              const Text("Valide o início da mentoria", 
                                style: TextStyle(fontSize: 14, color: Colors.grey)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        // --- PERGUNTA PRINCIPAL ---
                        const Text("Você já recebeu contato da mentora?", 
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildOptionBtn(
                                label: "Sim, recebi",
                                isActive: _contactStatus == 1,
                                icon: Icons.check_circle_outline,
                                activeColor: Colors.green,
                                onTap: () => setState(() => _contactStatus = 1),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildOptionBtn(
                                label: "Não recebi",
                                isActive: _contactStatus == 2,
                                icon: Icons.error_outline,
                                activeColor: errorColor,
                                onTap: () => setState(() => _contactStatus = 2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // --- ÁREA DINÂMICA ---
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: _contactStatus == 1 
                            ? // FLUXO 1: EXIBIR CÓDIGO (Para a Mentorada enviar)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.blue.shade100),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.info_outline, color: petroleo, size: 20),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Text(
                                            "Ótimo! Informe o código abaixo para sua mentora. Ela precisará digitá-lo no sistema dela para oficializar o vínculo.",
                                            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  
                                  // O CÓDIGO EM DESTAQUE 
                                  Center(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 25),
                                      decoration: BoxDecoration(
                                        color: backgroundGrey,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            _generatedCode, // Código gerado aqui
                                            style: TextStyle(
                                              fontSize: 32, 
                                              fontWeight: FontWeight.w900, 
                                              color: petroleo,
                                              letterSpacing: 6
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text("SEU CÓDIGO DE VINCULAÇÃO", 
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 20),
                                  
                                  // BOTÃO DE COPIAR
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: _generatedCode));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: const Text("Código copiado! Envie para sua mentora."), backgroundColor: petroleo),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: petroleo),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      icon: Icon(Icons.copy, color: petroleo),
                                      label: Text("Copiar Código", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: petroleo)),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 15),
                                  
                                  // Instrução final
                                  const Center(
                                    child: Text(
                                      "Aguardando a mentora validar...",
                                      style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            : // FLUXO 2: PROBLEMA (REPORTAR/AJUDA) - Mantido igual
                              Column(
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
                                            "Se você tentou contatar a mentora e não teve retorno, nós podemos ajudar.",
                                            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text("Descreva a situação (opcional)", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _helpMessageController,
                                    maxLines: 3,
                                    decoration: _inputDecoration().copyWith(
                                      hintText: "Ex: Enviei email há 3 dias e não obtive resposta...",
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
                                          SnackBar(content: const Text("Solicitação enviada. A equipe entrará em contato."), backgroundColor: errorColor),
                                        );
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: errorColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: const Text("Pedir Ajuda à Organização", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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

  // --- WIDGETS AUXILIARES ---

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