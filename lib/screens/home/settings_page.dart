import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

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
        title: const Text(
          "Configurações",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gerencie suas informações e preferências",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // --- SEÇÃO: EDITAR PERFIL ---
                _buildSettingsCard(
                  title: "Editar Perfil",
                  icon: Icons.person_outline,
                  children: [
                    _buildTextField("Nome completo", "Carolina Oliveira"),
                    _buildTextField("E-mail", "carolina@exemplo.com"),
                    _buildTextField("LinkedIn", "linkedin.com/in/carolina"),
                    _buildTextField("Biografia", "Estudante de STEM...", maxLines: 3),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildActionButton("Salvar Alterações", () {}),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- SEÇÃO: ÁREAS DE INTERESSE (EXTRA IMPORTANTE) ---
                _buildSettingsCard(
                  title: "Áreas de Interesse",
                  icon: Icons.auto_awesome_mosaic_outlined,
                  children: [
                    const Text(
                      "Selecione as áreas que você deseja focar na mentoria",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildFilterChip("Desenvolvimento", true),
                        _buildFilterChip("Ciência de Dados", true),
                        _buildFilterChip("UX Design", false),
                        _buildFilterChip("Inteligência Artificial", false),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- SEÇÃO: ALTERAR SENHA ---
                _buildSettingsCard(
                  title: "Alterar Senha",
                  icon: Icons.lock_outline,
                  children: [
                    _buildTextField("Senha atual", "*******", obscure: true),
                    _buildTextField("Nova senha", "*******", obscure: true),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildActionButton("Alterar Senha", () {}),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- SEÇÃO: SAIR DA CONTA ---
                _buildSettingsCard(
                  title: "Sessão",
                  icon: Icons.logout,
                  children: [
                    const Text("Deseja encerrar sua sessão atual?"),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: petroleo),
                          foregroundColor: petroleo,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Sair da conta"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildSettingsCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: petroleo, size: 24),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            maxLines: maxLines,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: petroleo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool value) {},
      selectedColor: brandColor.withOpacity(0.2),
      checkmarkColor: brandColor,
      labelStyle: TextStyle(color: isSelected ? brandColor : Colors.black87, fontSize: 12),
    );
  }
}