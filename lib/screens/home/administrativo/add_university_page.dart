import 'package:flutter/material.dart';
import 'package:frontend/services/university_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../coordinator/coordinator_registration_page.dart';

class AddUniversityPage extends StatefulWidget {
  const AddUniversityPage({super.key});

  @override
  State<AddUniversityPage> createState() => _AddUniversityPageState();
}

class _AddUniversityPageState extends State<AddUniversityPage> {
  final UniversityService _universityService = UniversityService();
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  // 1. Variável para controlar a visibilidade do botão "escondido"
  bool _mostrarBotaoVerCadastro = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityNameController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _universityNameController.dispose();
    super.dispose();
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
        title: const Text(
          "Nova Instituição Parceira",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Container(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dados Cadastrais",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildFieldLabel("Nome da Instituição"),
                    _buildTextField(
                      "Ex: Instituto Mauá de Tecnologia",
                      Icons.business,
                      _universityNameController
                    ),
                    const SizedBox(height: 20),

                    _buildFieldLabel("CNPJ"),
                    _buildTextField("00.000.000/0001-00", Icons.description),
                    const SizedBox(height: 20),

                    const Divider(height: 40),
                    const Text(
                      "Coordenador Responsável",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildFieldLabel("Nome Completo"),
                    _buildTextField(
                      "Ex: Prof. Dr. Carlos Mendes",
                      Icons.person,
                    ),
                    const SizedBox(height: 20),

                    _buildFieldLabel("E-mail Acadêmico"),
                    _buildTextField("carlos.mendes@maua.br", Icons.email, _emailController),
                    const SizedBox(height: 20),

                    _buildFieldLabel("WhatsApp de Coordenação"),
                    _buildTextField("(11) 98888-7777", Icons.phone_android),

                    const SizedBox(height: 40),

                    // --- BOTÃO SALVAR ---
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var token = prefs.getString("token");
                          token ??= "";
                          _universityService.createUniversity(
                            token: token,
                            email: _emailController.text,
                            universityName: _universityNameController.text
                          );
                          if (_formKey.currentState!.validate()) {
                            // 2. Aciona a visibilidade do botão escondido
                            setState(() {
                              _mostrarBotaoVerCadastro = true;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Universidade e Coordenador cadastrados!",
                                ),
                                backgroundColor: petroleo,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Salvar e Enviar Convite",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "O coordenador receberá um e-mail para criar sua senha.",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ),

                    // --- 3. LOGICA DO BOTÃO "ESCONDIDO" ---
                    if (_mostrarBotaoVerCadastro) ...[
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Simulação de Fluxo:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CoordinatorRegistrationPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.person_search, size: 20),
                              label: const Text(
                                "Ver tela que o Coordenador verá",
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: petroleo,
                                side: BorderSide(color: petroleo),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Seus widgets auxiliares permanecem os mesmos...
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, [TextEditingController? controller]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: brandColor),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: brandColor, width: 1.5),
        ),
      ),
    );
  }
}
