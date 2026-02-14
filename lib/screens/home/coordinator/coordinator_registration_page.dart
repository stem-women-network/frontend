import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import '../term_signing_page.dart';

class CoordinatorRegistrationPage extends StatefulWidget {
  const CoordinatorRegistrationPage({super.key});

  @override
  State<CoordinatorRegistrationPage> createState() =>
      _CoordinatorRegistrationPageState();
}

class _CoordinatorRegistrationPageState
    extends State<CoordinatorRegistrationPage> {
  final AuthService _authService = AuthService();
  final Color textDark = const Color(0xFF2D3436);
  final Color brandColor = const Color(0xFF3E84A2);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _senhaTemporariaController =
      TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _senhaTemporariaController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  bool _obscureSenhaTemporaria = true;
  bool _obscureSenha = true;
  bool _obscureConfirmar = true;

  void _irParaTermos() {
    if (_formKey.currentState!.validate()) {
      print("Nome: ${_nomeController.text}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TermSigningPage()),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime(2026),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: brandColor,
            onSurface: textDark,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _dataNascimentoController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "Voltar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
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
                                  color: brandColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Preencha seus dados para criar seu perfil profissional",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        _buildLabel("Nome Completo"),
                        _buildTextField(
                          _nomeController,
                          "Digite seu nome",
                          Icons.person,
                        ),

                        const SizedBox(height: 20),

                        _buildReadOnlyField(
                          "Data de Nascimento",
                          "DD/MM/AAAA",
                          _dataNascimentoController,
                          onTap: () => _selectDate(context),
                        ),

                        const SizedBox(height: 20),
                        _buildLabel("E-mail Institucional"),
                        _buildTextField(
                          _emailController,
                          "exemplo@instituicao.com",
                          Icons.email,
                          isEmail: true,
                        ),

                        const SizedBox(height: 20),
                        _buildLabel("Senha recebida"),
                        _buildPasswordField(
                          _senhaTemporariaController,
                          "********",
                          _obscureSenhaTemporaria,
                          () {
                            setState(
                              () => _obscureSenhaTemporaria =
                                  !_obscureSenhaTemporaria,
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                        _buildLabel("Criar Senha"),
                        _buildPasswordField(
                          _senhaController,
                          "Mínimo 6 caracteres",
                          _obscureSenha,
                          () {
                            setState(() => _obscureSenha = !_obscureSenha);
                          },
                        ),

                        const SizedBox(height: 20),
                        _buildLabel("Confirmar Senha"),
                        _buildPasswordField(
                          _confirmarSenhaController,
                          "Repita a senha",
                          _obscureConfirmar,
                          () {
                            setState(
                              () => _obscureConfirmar = !_obscureConfirmar,
                            );
                          },
                          isConfirm: true,
                        ),

                        const SizedBox(height: 50),

                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: FilledButton(
                              onPressed: () async {
                                await _authService.registerCoordinator(
                                  name: _nomeController.text,
                                  cpf: _cpfController.text,
                                  birthDate: _dataNascimentoController.text,
                                  email: _emailController.text,
                                  password: _senhaController.text,
                                  tempPassword: _senhaTemporariaController.text,
                                );
                                _irParaTermos();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Continuar para o Termo",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: brandColor,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: brandColor.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return "Campo obrigatório";
        if (isEmail && !val.contains("@")) return "E-mail inválido";
        return null;
      },
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String hint,
    bool obscure,
    VoidCallback toggle, {
    bool isConfirm = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: brandColor.withOpacity(0.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return "Campo obrigatório";
        if (val.length < 6) return "Senha muito curta";
        if (isConfirm && val != _senhaController.text)
          return "As senhas não coincidem";
        return null;
      },
    );
  }

  Widget _buildReadOnlyField(
    String label,
    String hint,
    TextEditingController controller, {
    required VoidCallback onTap,
  }) {
    final icon = Icon(Icons.calendar_today, color: brandColor, size: 18);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: brandColor,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: icon,
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? "Campo obrigatório" : null,
          ),
        ],
      ),
    );
  }
}
