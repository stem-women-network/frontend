import 'package:flutter/material.dart';
import 'coordinator/coordinator_dashboard_page.dart';
import 'administrativo/admin_dashboard_page.dart';
import 'signup_page.dart';
import '../mentora/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  // Modal de recuperação centralizado e consistente
  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 330),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Recuperar Senha", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                  ],
                ),
                const SizedBox(height: 15),
                const Text("Insira seu e-mail para receber o link de recuperação.", 
                  style: TextStyle(color: Colors.black54, fontSize: 13), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "seuemail@exemplo.com",
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text("Link enviado!"), backgroundColor: brandColor)
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: brandColor, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                    child: const Text("Enviar Link"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("STEM WOMEN NETWORK", style: TextStyle(color: brandColor, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    const SizedBox(height: 25),
                    const Text("Bem-vinda de volta!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    const Text("Entre com sua conta para continuar", style: TextStyle(color: Colors.black54, fontSize: 14)),
                    const SizedBox(height: 35),
                    _buildLabel("E-mail"),
                    const SizedBox(height: 8),
                    TextFormField(decoration: _inputDecoration("seuemail@stem.br")),
                    const SizedBox(height: 20),
                    _buildLabel("Senha"),
                    const SizedBox(height: 8),
                    TextFormField(obscureText: true, decoration: _inputDecoration("*********")),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showForgotPasswordDialog(context),
                        style: TextButton.styleFrom(foregroundColor: brandColor),
                        child: const Text("Esqueci a minha senha"),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CoordinatorDashboardPage()));
                          }
                        },
                        style: FilledButton.styleFrom(backgroundColor: brandColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text("Entrar", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Não tem uma conta? ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage())),
                          child: Text("Criar conta", style: TextStyle(color: brandColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    
                    // ACESSO RÁPIDO COORDENADOR
                    TextButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoordinatorDashboardPage())),
                      icon: const Icon(Icons.admin_panel_settings, color: Colors.red),
                      label: const Text("Acesso Rápido Coordenador", style: TextStyle(color: Colors.red)),
                    ),
                    
                    // ACESSO RÁPIDO ADMINISTRATIVO
                    TextButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboardPage())),
                      icon: const Icon(Icons.security, color: Colors.indigo),
                      label: const Text("Acesso Rápido Administrativo", style: TextStyle(color: Colors.indigo)),
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

  Widget _buildLabel(String text) => Align(alignment: Alignment.centerLeft, child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)));

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black12)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: brandColor, width: 1.5)),
  );
}
