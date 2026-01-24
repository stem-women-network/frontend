import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentorTrainingPage extends StatelessWidget {
  const MentorTrainingPage({super.key});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);
  final Color backgroundGrey = const Color(0xFFF8F9FA);

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
        title: const Text("Capacitação da Mentora", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                      child: Icon(Icons.school, color: laranja),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Destaque da Coordenação", style: TextStyle(fontWeight: FontWeight.bold, color: laranja, fontSize: 14)),
                          const SizedBox(height: 4),
                          const Text(
                            "Conteúdos essenciais para apoiar sua jornada de desenvolvimento como mentora.",
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _buildSectionTitle("Vídeos de Treinamento", Icons.play_circle_fill),
              const SizedBox(height: 15),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildVideoCard(
                      title: "Boas práticas de Mentoria",
                      duration: "25 min",
                      color: petroleo,
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                    const SizedBox(width: 15),
                    _buildVideoCard(
                      title: "Comunicação Não-Violenta",
                      duration: "18 min",
                      color: coral,
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                    const SizedBox(width: 15),
                     _buildVideoCard(
                      title: "Guia da Plataforma",
                      duration: "10 min",
                      color: brandColor,
                      onTap: () => _launchLink("https://youtube.com"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _buildSectionTitle("Manuais e Guias", Icons.folder),
              const SizedBox(height: 15),
              
              _buildFileTile(
                title: "Manual da Mentora 2026.pdf",
                size: "3.1 MB",
                icon: Icons.picture_as_pdf,
                iconColor: coral,
              ),
              const SizedBox(height: 10),
              _buildFileTile(
                title: "Código de Conduta.pdf",
                size: "1.2 MB",
                icon: Icons.description,
                iconColor: petroleo,
              ),

              const SizedBox(height: 30),

              _buildSectionTitle("Comunidade", Icons.link),
              const SizedBox(height: 15),
              
              _buildLinkTile(
                title: "Grupo de Mentoras no Slack",
                url: "slack.com/stem-women...",
              ),
              const SizedBox(height: 10),
              _buildLinkTile(
                title: "Agenda de Workshops",
                url: "notion.so/agenda-2026",
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

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
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
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