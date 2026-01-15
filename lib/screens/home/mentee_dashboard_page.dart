import 'package:flutter/material.dart';
import 'settings_page.dart'; // Certifique-se de que o arquivo existe

class MenteeDashboardPage extends StatelessWidget {
  const MenteeDashboardPage({super.key});

  // Cores Oficiais enviadas
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "STEM Women Network",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          _buildHeaderIcon(Icons.bar_chart),
                          _buildHeaderIcon(Icons.calendar_month),
                          _buildHeaderIcon(Icons.person),
                          // ÍCONE DE CONFIGURAÇÕES CLICÁVEL
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SettingsPage()),
                              );
                            },
                            icon: _buildHeaderIcon(Icons.settings),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // --- CARD PERFIL PRINCIPAL ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 45, backgroundColor: coral.withOpacity(0.8)),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Carolina Oliveira", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const Text("Ciência da Computação • 3 Semestre", style: TextStyle(color: Colors.black54, fontSize: 13)),
                              const SizedBox(height: 8),
                              _buildBadge("Match encontrado", Colors.green.shade50, Colors.green.shade700),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 15,
                                runSpacing: 8,
                                children: [
                                  _infoRow(Icons.calendar_month, "Disponível: manhã e tarde"),
                                  _infoRow(Icons.groups, "2 mentoras ativas"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- MENTORA & ENCONTRO (ALTURAS IGUAIS) ---
                  IntrinsicHeight(
                    child: isMobile 
                      ? Column(children: [_buildMentoraCard(), const SizedBox(height: 15), _buildEncontroCard()])
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _buildMentoraCard()),
                            const SizedBox(width: 15),
                            Expanded(child: _buildEncontroCard()),
                          ],
                        ),
                  ),
                  const SizedBox(height: 20),

                  // --- HISTÓRICO DE ENCONTROS ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Histórico de encontros", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        const SizedBox(height: 15),
                        _buildHistoryItem("Introdução e objetivos", "15 Dez 2024 - 1h"),
                        const Divider(height: 30),
                        _buildHistoryItem("Planejamento de carreiras", "22 Dez 2024 - 1h"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- GRID DE AÇÕES RÁPIDAS (ALTURA REDUZIDA E CLICÁVEL) ---
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: isMobile ? 4.5 : 2.5,
                    children: [
                      _buildQuickAction(Icons.bar_chart, "Meu progresso", "Ver linha do tempo", laranja),
                      _buildQuickAction(Icons.emoji_events, "Certificado", "Ver conquistas", coral),
                      _buildQuickAction(Icons.calendar_today, "Eventos", "Ver próximos eventos", petroleo),
                      _buildQuickAction(Icons.menu_book, "Treinamento", "Materiais e vídeos", laranja),
                      _buildQuickAction(Icons.front_hand, "Primeiro Contato", "Registrar contato inicial", coral),
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

  // --- COMPONENTES AUXILIARES ---

  Widget _buildMentoraCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Minha mentora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(radius: 22, backgroundColor: laranja.withOpacity(0.3)),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ana paula Serra", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text("Desenvolvedora Sênior", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 5,
            children: [_buildTag("Desenvolvimento"), _buildTag("Ciência de Dados")],
          ),
          const Spacer(),
          Row(
            children: [
              _textLink("Ver perfil"),
              const SizedBox(width: 15),
              _textLink("Enviar mensagem"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEncontroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Próximo encontro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          _infoRow(Icons.calendar_today, "28 Janeiro, 2025", isDark: true),
          const SizedBox(height: 8),
          _infoRow(Icons.access_time, "14:00 - 15:00", isDark: true),
          const SizedBox(height: 10),
          const Text("Tópico: Revisão de Currículo", style: TextStyle(fontSize: 12, color: Colors.black54)),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: petroleo,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Confirmar", style: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String sub, Color color) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          // Adicione a navegação aqui para cada ação
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 30),
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
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
  );

  Widget _buildHeaderIcon(IconData icon) => Container(
    margin: const EdgeInsets.only(left: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
    child: Icon(icon, color: brandColor, size: 22),
  );

  Widget _buildBadge(String text, Color bg, Color textCol) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: TextStyle(color: textCol, fontSize: 11, fontWeight: FontWeight.bold)),
  );

  Widget _buildTag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.black87)),
  );

  Widget _infoRow(IconData icon, String text, {bool isDark = false}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16, color: isDark ? petroleo : Colors.black45),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(fontSize: 12, color: isDark ? Colors.black87 : Colors.black54, fontWeight: isDark ? FontWeight.w500 : FontWeight.normal)),
    ],
  );

  Widget _textLink(String text) => InkWell(
    onTap: () {},
    child: Text(text, style: TextStyle(color: petroleo, fontSize: 11, decoration: TextDecoration.underline, fontWeight: FontWeight.w600)),
  );

  Widget _buildHistoryItem(String title, String sub) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(sub, style: const TextStyle(color: Colors.black45, fontSize: 12)),
        ],
      ),
      Text("Ver detalhes", style: TextStyle(color: petroleo, fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
    ],
  );
}