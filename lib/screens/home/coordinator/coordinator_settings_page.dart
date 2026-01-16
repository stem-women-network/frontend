import 'package:flutter/material.dart';

class CoordinatorSettingsPage extends StatefulWidget {
  const CoordinatorSettingsPage({super.key});

  @override
  State<CoordinatorSettingsPage> createState() => _CoordinatorSettingsPageState();
}

class _CoordinatorSettingsPageState extends State<CoordinatorSettingsPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color errorColor = const Color(0xFFE57373);
  
  bool _notifEmail = true;

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
        title: const Text("Configurações", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // --- SEÇÃO CONTA (IGUAL AO MODELO) ---
                _buildSettingsCard(
                  title: "Perfil do Coordenador",
                  icon: Icons.admin_panel_settings_outlined,
                  children: [
                    _buildReadOnlyField("E-mail Institucional", "carlos.mendes@maua.br"),
                    const SizedBox(height: 20),
                    _buildReadOnlyField("ID Funcional", "IMT-202409"),
                    const SizedBox(height: 20),
                    const Text("Segurança", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    _buildPasswordField("Alterar Senha Atual"),
                    const SizedBox(height: 10),
                    _buildPasswordField("Nova Senha"),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: petroleo,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Salvar Senha", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- SEÇÃO INSTITUIÇÃO ---
                _buildSettingsCard(
                  title: "Instituição",
                  icon: Icons.account_balance_outlined,
                  children: [
                    const Text("Vínculo Acadêmico", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 4),
                    const Text("Instituto Mauá de Tecnologia - IMT", style: TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),
                    // Usando o estilo de botão de ação do seu código
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_note, size: 18, color: Color(0xFF3E84A2)),
                        label: const Text("Editar informações da faculdade", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          backgroundColor: Colors.blue.shade50.withOpacity(0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- PREFERÊNCIAS ---
                _buildSettingsCard(
                  title: "Preferências de Gestão",
                  icon: Icons.notifications_none,
                  children: [
                    SwitchListTile(
                      title: const Text("Notificar novos inscritos", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      subtitle: const Text("Receba alertas de novas alunas na rede", style: TextStyle(fontSize: 12)),
                      activeColor: petroleo,
                      contentPadding: EdgeInsets.zero,
                      value: _notifEmail,
                      onChanged: (v) => setState(() => _notifEmail = v),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // BOTÃO SAIR (PADRÃO BRANCO)
                TextButton.icon(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  icon: const Icon(Icons.logout, size: 20, color: Colors.white70),
                  label: const Text("Sair do Painel", style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- REUTILIZANDO SEUS WIDGETS DE ESTILO ---

  Widget _buildSettingsCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: petroleo, size: 22),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: petroleo)),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey.shade50, 
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(value, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String hint) {
    return TextField(
      obscureText: true,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: petroleo)),
      ),
    );
  }
}