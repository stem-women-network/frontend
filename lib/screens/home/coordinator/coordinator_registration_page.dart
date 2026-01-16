import 'package:flutter/material.dart';
import '../term_signing_page.dart';

class CoordinatorRegistrationPage extends StatefulWidget {
  const CoordinatorRegistrationPage({super.key});

  @override
  State<CoordinatorRegistrationPage> createState() => _CoordinatorRegistrationPageState();
}

class _CoordinatorRegistrationPageState extends State<CoordinatorRegistrationPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final _formKey = GlobalKey<FormState>();
  
  // Controllers para capturar os dados
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _obscureConfirmar = true;

  void _irParaTermos() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode imprimir os dados ou salvar temporariamente
      print("Nome: ${_nomeController.text}");
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TermSigningPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          // Botão Voltar (Seguindo seu padrão)
          Positioned(
            top: 40,
            left: 20,
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              label: const Text("Voltar", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600), // Card um pouco mais estreito que o de termos
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Cadastro de Coordenador",
                                style: TextStyle(
                                  fontSize: 26, 
                                  fontWeight: FontWeight.w900, 
                                  color: brandColor
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Preencha seus dados para criar seu perfil profissional",
                                textAlign: TextAlign.center, // Agora o Flutter entende o alinhamento
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        _buildLabel("Nome Completo"),
                        _buildTextField(_nomeController, "Digite seu nome", Icons.person),

                        const SizedBox(height: 20),
                        _buildLabel("E-mail Institucional"),
                        _buildTextField(_emailController, "exemplo@instituicao.com", Icons.email, isEmail: true),

                        const SizedBox(height: 20),
                        _buildLabel("Criar Senha"),
                        _buildPasswordField(_senhaController, "Mínimo 6 caracteres", _obscureSenha, () {
                          setState(() => _obscureSenha = !_obscureSenha);
                        }),

                        const SizedBox(height: 20),
                        _buildLabel("Confirmar Senha"),
                        _buildPasswordField(_confirmarSenhaController, "Repita a senha", _obscureConfirmar, () {
                          setState(() => _obscureConfirmar = !_obscureConfirmar);
                        }, isConfirm: true),

                        const SizedBox(height: 50),

                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: FilledButton(
                              onPressed: _irParaTermos,
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text(
                                "Continuar para o Termo",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTES VISUAIS AUXILIARES ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: brandColor.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return "Campo obrigatório";
        if (isEmail && !val.contains("@")) return "E-mail inválido";
        return null;
      },
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint, bool obscure, VoidCallback toggle, {bool isConfirm = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(Icons.lock_outline, color: brandColor.withOpacity(0.5)),
        suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility), onPressed: toggle),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return "Campo obrigatório";
        if (val.length < 6) return "Senha muito curta";
        if (isConfirm && val != _senhaController.text) return "As senhas não coincidem";
        return null;
      },
    );
  }
}