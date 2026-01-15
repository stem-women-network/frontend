import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingMaterialsPage extends StatelessWidget {
  const TrainingMaterialsPage({super.key});

  // PALETA OFICIAL DO PROJETO
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);
  
  final Color backgroundGrey = const Color(0xFFF8F9FA); // Cinza bem claro para fundos

  // Função para abrir links
  Future<void> _launchLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Não foi possível abrir o link: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Materiais da Mentoria", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- MENSAGEM DA MENTORA (Estilo Laranja) ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: laranja.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: laranja.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.tips_and_updates, color: laranja),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Curadoria da Mentora", style: TextStyle(fontWeight: FontWeight.bold, color: laranja, fontSize: 14)),
                          const SizedBox(height: 4),
                          const Text(
                            "Separei estes materiais para te ajudar no nosso próximo tópico sobre Liderança.",
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // SEÇÃO 1: VÍDEOS (Cores da Paleta)
              // =========================
              _buildSectionTitle("Vídeos Recomendados", Icons.play_circle_fill),
              const SizedBox(height: 15),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildVideoCard(
                      title: "Mulheres na Liderança Tech",
                      duration: "15 min",
                      color: petroleo, // Cor do projeto
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                    const SizedBox(width: 15),
                    _buildVideoCard(
                      title: "Como pedir aumento?",
                      duration: "8 min",
                      color: coral, // Cor do projeto
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                    const SizedBox(width: 15),
                     _buildVideoCard(
                      title: "Síndrome do Impostor",
                      duration: "20 min",
                      color: brandColor, // Cor do projeto
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // SEÇÃO 2: ARQUIVOS (Ícones Coloridos)
              // =========================
              _buildSectionTitle("Arquivos de Apoio", Icons.folder),
              const SizedBox(height: 15),
              
              _buildFileTile(
                title: "Guia de Carreira em TI.pdf",
                size: "2.4 MB",
                icon: Icons.picture_as_pdf,
                iconColor: coral, // PDF geralmente associado a vermelho/coral
              ),
              const SizedBox(height: 10),
              _buildFileTile(
                title: "Template de Currículo.docx",
                size: "500 KB",
                icon: Icons.description,
                iconColor: petroleo, // Docs associados a azul/petroleo
              ),

              const SizedBox(height: 30),

              // =========================
              // SEÇÃO 3: LINKS
              // =========================
              _buildSectionTitle("Links Importantes", Icons.link),
              const SizedBox(height: 15),
              
              _buildLinkTile(
                title: "Vagas afirmativas no LinkedIn",
                url: "linkedin.com/feed/...",
              ),
              const SizedBox(height: 10),
              _buildLinkTile(
                title: "Artigo: O futuro do Java",
                url: "medium.com/java-futures",
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: petroleo),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildVideoCard({required String title, required String duration, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail colorida com a paleta
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2), // Fundo suave da cor escolhida
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileTile({required String title, required String size, required IconData icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(size, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          // Botão de download discreto
          IconButton(
            icon: Icon(Icons.download_rounded, color: petroleo),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({required String title, required String url}) {
    return InkWell(
      onTap: () => _launchLink("https://$url"),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.link, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(url, style: TextStyle(color: petroleo, fontSize: 12, decoration: TextDecoration.underline)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}