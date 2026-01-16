import 'package:flutter/material.dart';

// --- IMPORT CORRIGIDO PARA SUA ESTRUTURA ATUAL ---
// O arquivo está dentro de home/coordinator, então o caminho é direto:
import 'coordinator/coordinator_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "STEM WOMEN NETWORK",
                      style: TextStyle(
                        color: brandColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Bem-vinda de volta!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Entre com sua conta para continuar",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 35),
                    
                    _buildLabel("E-mail"),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: _inputDecoration("seuemail@stem.br"),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildLabel("Senha"),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      decoration: _inputDecoration("*********"),
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: brandColor,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text("Esqueci a minha senha"),
                      ),
                    ),
                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ).copyWith(
                          overlayColor: WidgetStateProperty.all(Colors.white10),
                        ),
                        child: const Text("Entrar", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Não tem uma conta? ", style: TextStyle(color: Colors.black87)),
                        GestureDetector(
                          onTap: () {
                            // Navegar para SignUp
                          },
                          child: Text(
                            "Criar conta",
                            style: TextStyle(
                              color: brandColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // --- BOTÃO DE COORDENADOR (APAGAR DEPOIS) ---
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          // Import corrigido, agora deve funcionar
                          MaterialPageRoute(builder: (context) => const CoordinatorDashboardPage()),
                        );
                      },
                      icon: const Icon(Icons.admin_panel_settings, color: Colors.red),
                      label: const Text("Acesso Rápido Coordenador", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: brandColor, width: 1.5),
      ),
    );
  }
}