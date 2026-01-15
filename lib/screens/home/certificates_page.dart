import 'package:flutter/material.dart';
// Certifique-se de que o arquivo survey_page.dart existe e está na mesma pasta ou ajuste o caminho
import 'survey_page.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  // Paleta de Cores Oficial
  final Color brandColor = const Color(0xFF0B6F8E);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color laranja = const Color(0xFFFE9F43);
  final Color coral = const Color(0xFFE4645B);
  final Color linkedinColor = const Color(0xFF0B6F8E);

  // Controle de estado
  bool _isSurveyCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor, // Fundo Azul da Marca
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Certificados",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Título e Subtítulo ---
            const Text(
              "Suas Conquistas",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Desbloqueie seu certificado oficial do STEM Women Network após concluir a avaliação.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // CARD 1: CERTIFICADO DE CONCLUSÃO (COM LÓGICA)
            // ==================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ícone Dinâmico (Cadeado ou Medalha)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _isSurveyCompleted ? laranja.withOpacity(0.15) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _isSurveyCompleted ? Icons.workspace_premium : Icons.lock,
                          color: _isSurveyCompleted ? laranja : Colors.grey.shade400,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Certificado Oficial",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _isSurveyCompleted
                                  ? "Disponível para download."
                                  : "Pendente: Responda à pesquisa de satisfação para liberar.",
                              style: TextStyle(
                                fontSize: 13,
                                color: _isSurveyCompleted ? Colors.green : Colors.black54,
                                height: 1.4,
                                fontWeight: _isSurveyCompleted ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botão de Ação Dinâmico
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _isSurveyCompleted
                        ? OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: const Text("Baixando certificado..."), backgroundColor: petroleo),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: petroleo, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: Icon(Icons.download_rounded, color: petroleo),
                            label: Text("Baixar PDF", style: TextStyle(color: petroleo, fontWeight: FontWeight.bold, fontSize: 16)),
                          )
                        : FilledButton.icon(
                            onPressed: () async {
                              // --- NAVEGAÇÃO PARA A PESQUISA ---
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SurveyPage()),
                              );

                              // Se voltou da pesquisa (assumindo que completou), libera o certificado
                              // Para garantir, você pode fazer o SurveyPage retornar 'true' no Navigator.pop(context, true)
                              setState(() {
                                _isSurveyCompleted = true; 
                              });
                              
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: const Text("Obrigada! Certificado liberado."), backgroundColor: petroleo),
                                );
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: petroleo,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.star_rate_rounded, size: 20),
                            label: const Text("Avaliar para Liberar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // CARD 2: BADGE LINKEDIN
            // ==================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Badge Visual
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [petroleo, brandColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(Icons.stars_rounded, color: Colors.white, size: 36),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Badge LinkedIn",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Mostre sua conquista para sua rede profissional.",
                              style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: linkedinColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      label: const Text("Adicionar ao Perfil", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}