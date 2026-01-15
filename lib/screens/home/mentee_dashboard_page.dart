import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'progress_page.dart';

class MenteeDashboardPage extends StatelessWidget {
  const MenteeDashboardPage({super.key});

  // Paleta de Cores
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: brandColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          // AQUI ESTÁ A CORREÇÃO DA MARGEM:
          // Antes era 16, agora é 24 (igual à tela de progresso)
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          "STEM Women Network",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22, // Fonte levemente maior
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      // Ícones com design unificado
                      Row(
                        children: [
                          _buildHeaderIcon(Icons.bar_chart),
                          const SizedBox(width: 12), // Mais espaço entre ícones
                          _buildHeaderIcon(Icons.calendar_month),
                          const SizedBox(width: 12),
                          _buildHeaderIcon(Icons.person),
                          const SizedBox(width: 12),
                          // Botão de Configurações
                          _buildIconButton(
                            icon: Icons.settings,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsPage()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 35), // Mais respiro vertical

                  // --- CARD PERFIL (Full Width) ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25), // Padding interno maior
                    decoration: _cardDecoration(),
                    child: Row(
                      children: [
                        // Avatar estilizado
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: coral,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Carolina Oliveira",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Ciência da Computação • 3º Semestre",
                                style: TextStyle(color: Colors.black54, fontSize: 13),
                              ),
                              const SizedBox(height: 15),
                              // Badges e Infos
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  _buildBadge("Match encontrado", Colors.green.shade50, Colors.green.shade700),
                                  _infoText(Icons.calendar_today, "Manhã e tarde"),
                                  _infoText(Icons.people_outline, "2 mentoras"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  // --- MENTORA & ENCONTRO (Layout Flexível) ---
                  IntrinsicHeight(
                    child: isMobile
                        ? Column(
                            children: [
                              _buildMentoraCard(),
                              const SizedBox(height: 25),
                              _buildEncontroCard(),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: _buildMentoraCard()),
                              const SizedBox(width: 25), // Espaço consistente
                              Expanded(child: _buildEncontroCard()),
                            ],
                          ),
                  ),
                  
                  const SizedBox(height: 25),

                  // --- HISTÓRICO DE ENCONTROS ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Histórico de encontros",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 20),
                        _buildHistoryItem("Introdução e objetivos", "15 Dez 2024 - 1h"),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(height: 1),
                        ),
                        _buildHistoryItem("Planejamento de carreiras", "22 Dez 2024 - 1h"),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  // --- GRID DE AÇÕES RÁPIDAS ---
                  // Usando Wrap ou GridView ajustado para não quebrar
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 20, // Espaçamento maior entre cards
                    mainAxisSpacing: 20,
                    childAspectRatio: isMobile ? 4.5 : 2.2, // Ajuste de proporção
                    children: [
                      _buildQuickAction(
                        Icons.bar_chart,
                        "Meu progresso",
                        "Ver linha do tempo",
                        laranja,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProgressPage()),
                          );
                        },
                      ),
                      _buildQuickAction(Icons.emoji_events, "Certificado", "Ver conquistas", coral),
                      _buildQuickAction(Icons.calendar_today, "Eventos", "Ver próximos", petroleo),
                      _buildQuickAction(Icons.menu_book, "Treinamento", "Materiais", laranja),
                      _buildQuickAction(Icons.front_hand, "Primeiro Contato", "Registrar", coral),
                    ],
                  ),
                  // Margem inferior extra para não cortar
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS DECORADOS ---

  // Decoração Unificada: Sombra suave e Borda arredondada (24)
  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      );

  Widget _buildMentoraCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Minha mentora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                  radius: 24, backgroundColor: laranja.withOpacity(0.2), child: Icon(Icons.person, color: laranja)),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ana Paula Serra", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("Dev Sênior", style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            children: [_buildTag("Desenvolvimento"), _buildTag("Data Science")],
          ),
          const Spacer(),
          const SizedBox(height: 15),
          Row(
            children: [
              _textLink("Ver perfil"),
              const SizedBox(width: 20),
              _textLink("Mensagem"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEncontroCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Próximo encontro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          _infoRow(Icons.calendar_today, "28 Janeiro, 2025", isDark: true),
          const SizedBox(height: 10),
          _infoRow(Icons.access_time, "14:00 - 15:00", isDark: true),
          const SizedBox(height: 12),
          const Text("Tópico: Revisão de Currículo",
              style: TextStyle(fontSize: 13, color: Colors.black54, fontStyle: FontStyle.italic)),
          const Spacer(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: petroleo,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text("Confirmar Presença", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String sub, Color color, {VoidCallback? onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24), // Borda consistente
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100), // Borda sutil para definição
            boxShadow: [
               BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(sub, style: const TextStyle(fontSize: 11, color: Colors.black54), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPERS VISUAIS ---

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: brandColor, size: 20),
    );
  }
  
  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: brandColor, size: 20),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: TextStyle(color: textCol, fontSize: 11, fontWeight: FontWeight.bold)),
      );

  Widget _buildTag(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200)),
        child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
      );

  Widget _infoText(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black45),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      );

  Widget _infoRow(IconData icon, String text, {bool isDark = false}) => Row(
        children: [
          Icon(icon, size: 16, color: isDark ? petroleo : Colors.black45),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.black87 : Colors.black54,
                  fontWeight: isDark ? FontWeight.w600 : FontWeight.normal)),
        ],
      );

  Widget _textLink(String text) => InkWell(
        onTap: () {},
        child: Text(text,
            style: TextStyle(
                color: petroleo, fontSize: 12, decoration: TextDecoration.underline, fontWeight: FontWeight.w700)),
      );

  Widget _buildHistoryItem(String title, String sub) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(sub, style: const TextStyle(color: Colors.black45, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: petroleo.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
            child: Text("Ver detalhes",
                style: TextStyle(color: petroleo, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      );
}