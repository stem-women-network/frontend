import 'package:flutter/material.dart';

class MenteeDashboardPage extends StatelessWidget {
  const MenteeDashboardPage({super.key});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color cardBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Detecta se a tela é mobile (largura menor que 600)
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        child: SingleChildScrollView(
          // Margem de 24.0 para alinhar com o padrão do seu Login/Cadastro
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850), // Mantém o limite do design
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          "STEM Women Network",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildHeaderIcon(Icons.bar_chart),
                          _buildHeaderIcon(Icons.calendar_month),
                          _buildHeaderIcon(Icons.person_outline),
                          _buildHeaderIcon(Icons.settings),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // --- PERFIL DA MENTORADA ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Wrap( // Wrap ajuda no mobile se o nome for muito longo
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.redAccent.withOpacity(0.6),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Carolina Oliveira",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text("Ciência da Computação • 3º Semestre", 
                              style: TextStyle(color: Colors.black54, fontSize: 13)),
                            const SizedBox(height: 8),
                            _buildBadge("Match encontrado", Colors.green.shade100, Colors.green.shade800),
                            const SizedBox(height: 12),
                            // No mobile, os detalhes do perfil podem ficar em coluna
                            Wrap(
                              spacing: 15,
                              runSpacing: 5,
                              children: [
                                _infoRow(Icons.calendar_today, "Disponível: manhã/tarde", Colors.black45),
                                _infoRow(Icons.people, "2 mentoras ativas", Colors.black45),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- MINHA MENTORA & PRÓXIMO ENCONTRO (RESPONSIVO) ---
                  isMobile 
                    ? Column(children: [
                        _buildMentoraCard(),
                        const SizedBox(height: 20),
                        _buildEncontroCard(),
                      ])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildMentoraCard()),
                          const SizedBox(width: 15),
                          Expanded(child: _buildEncontroCard()),
                        ],
                      ),
                  const SizedBox(height: 20),

                  // --- HISTÓRICO ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Histórico de encontros", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 15),
                        _buildHistoryItem("Introdução e objetivos", "15 Dez 2024 - 1h"),
                        const Divider(),
                        _buildHistoryItem("Planejamento de carreiras", "22 Dez 2024 - 1h"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- GRID DE AÇÕES RÁPIDAS ---
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // No mobile 1 coluna, no desktop 2 ou 3
                    crossAxisCount: isMobile ? 1 : 2, 
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: isMobile ? 3.5 : 2.5,
                    children: [
                      _buildQuickAction(Icons.bar_chart, "Meu progresso", "Ver linha do tempo", Colors.orange),
                      _buildQuickAction(Icons.emoji_events, "Certificado", "Ver conquistas", Colors.redAccent),
                      _buildQuickAction(Icons.calendar_today, "Eventos", "Ver próximos eventos", brandColor),
                      _buildQuickAction(Icons.menu_book, "Treinamento", "Materiais e vídeos", Colors.orange),
                      _buildQuickAction(Icons.handshake, "Primeiro Contato", "Registrar contato inicial", Colors.redAccent),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- SUB-WIDGETS PARA ORGANIZAÇÃO ---

  Widget _buildMentoraCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Minha mentora", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: Colors.orange.shade300),
              const SizedBox(width: 10),
              const Text("Ana Paula Serra", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 45),
            child: Text("Desenvolvedora Sênior", style: TextStyle(fontSize: 11, color: Colors.black54)),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              _buildSmallTag("Desenvolvimento"),
              _buildSmallTag("Ciência de Dados"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEncontroCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Próximo encontro", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          _infoRow(Icons.calendar_month, "28 Janeiro, 2025", brandColor),
          const SizedBox(height: 8),
          _infoRow(Icons.access_time, "14:00 - 15:00", brandColor),
          const SizedBox(height: 10),
          const Text("Tópico: Revisão de Currículo", style: TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Confirmar", style: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  // --- COMPONENTES REUTILIZÁVEIS ---

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8)),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: brandColor, size: 18),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: textCol, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSmallTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(5)),
      child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.black54)),
    );
  }

  Widget _infoRow(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildHistoryItem(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(date, style: const TextStyle(fontSize: 11, color: Colors.black45)),
              ],
            ),
          ),
          Text("Ver detalhes", style: TextStyle(color: brandColor, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String sub, Color iconCol) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Icon(icon, color: iconCol, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(fontSize: 10, color: Colors.black54), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}