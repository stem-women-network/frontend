import 'package:flutter/material.dart';

class MenteeRegistrationPage extends StatefulWidget {
  const MenteeRegistrationPage({super.key});

  @override
  State<MenteeRegistrationPage> createState() => _MenteeRegistrationPageState();
}

class _MenteeRegistrationPageState extends State<MenteeRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  // Estados
  String? selectedDisponibilidade;
  String? comoSoube;
  bool aceitouTermos = false;

  // Controllers para lógica de "Outros"
  final TextEditingController _outroComoSoubeController = TextEditingController();

  @override
  void dispose() {
    _outroComoSoubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          // Botão Voltar
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, 
                        blurRadius: 20, 
                        offset: const Offset(0, 10)
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 40),
                        
                        _buildSectionTitle("Dados Pessoais"),
                        _buildRow([
                          _buildField("Nome completo", "Seu nome", required: true),
                          _buildField("CPF", "000.000.000-00", required: true),
                        ]),
                        _buildRow([
                          _buildField("E-mail", "seu@email.com", required: true, isEmail: true),
                          _buildField("WhatsApp", "(00) 00000-0000", required: true),
                        ]),
                        _buildRow([
                          _buildField("Senha", "*********", obscure: true, required: true),
                          _buildField("LinkedIn (opcional)", "URL do perfil"),
                        ]),

                        const SizedBox(height: 30),
                        _buildSectionTitle("Perfil Acadêmico"),
                        _buildField("Curso / Área STEM", "Ex: Ciência da Computação", required: true),
                        _buildField("Universidade / Instituição", "Nome da instituição", required: true),
                        _buildRow([
                          _buildField("Ano", "Ex: 2025", required: true),
                          _buildField("Semestre", "Ex: 2 ano", required: true),
                        ]),
                        
                        const SizedBox(height: 15),
                        _buildField(
                          "Objetivo na mentoria", 
                          "Conte-nos o que você espera realizar na mentoria...", 
                          maxLines: 4, 
                          required: true
                        ),

                        const SizedBox(height: 25),
                        const Text("Disponibilidade", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: ["Manhã", "Tarde", "Noite"].map((periodo) => ChoiceChip(
                            label: Text(periodo),
                            selected: selectedDisponibilidade == periodo,
                            selectedColor: brandColor.withOpacity(0.15),
                            labelStyle: TextStyle(
                              color: selectedDisponibilidade == periodo ? brandColor : Colors.black87,
                              fontWeight: selectedDisponibilidade == periodo ? FontWeight.bold : FontWeight.normal,
                            ),
                            shape: StadiumBorder(side: BorderSide(color: selectedDisponibilidade == periodo ? brandColor : Colors.grey[300]!)),
                            onSelected: (val) => setState(() => selectedDisponibilidade = val ? periodo : null),
                          )).toList(),
                        ),

                        const SizedBox(height: 30),
                        const Text("Como ficou sabendo do programa?", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          iconEnabledColor: brandColor,
                          decoration: _inputDecoration("Selecione"),
                          items: ["Instagram", "Amigos", "Professora", "Evento", "LinkedIn", "Outros"]
                              .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (val) => setState(() => comoSoube = val),
                          validator: (val) => val == null ? "Campo obrigatório" : null,
                        ),

                        if (comoSoube == "Outros") ...[
                          const SizedBox(height: 15),
                          _buildField("Especifique como soube", "Escreva aqui", controller: _outroComoSoubeController, required: true),
                        ],

                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Checkbox(
                              value: aceitouTermos,
                              activeColor: brandColor,
                              onChanged: (val) => setState(() => aceitouTermos = val!),
                            ),
                            const Expanded(child: Text("Li e aceito os termos de uso e privacidade.", style: TextStyle(fontSize: 13, color: Colors.black54))),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 50,
                            child: FilledButton(
                              onPressed: aceitouTermos ? () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedDisponibilidade == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Selecione sua disponibilidade!"))
                                    );
                                    return;
                                  }
                                  // Lógica de cadastro aqui
                                }
                              } : null,
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                disabledBackgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Criar conta", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Text("Cadastro de Mentorada", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: brandColor)),
          const SizedBox(height: 8),
          const Text("Preencha seus dados para começar sua jornada", style: TextStyle(color: Colors.black45)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: brandColor)),
        const Divider(height: 30),
      ],
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: e))).toList(),
      ),
    );
  }

  Widget _buildField(String label, String hint, {bool obscure = false, bool required = false, bool isEmail = false, TextEditingController? controller, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          maxLines: maxLines,
          decoration: _inputDecoration(hint),
          validator: (value) {
            if (required && (value == null || value.isEmpty)) return "Campo obrigatório";
            if (isEmail && value != null && !value.contains("@")) return "E-mail inválido";
            return null;
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: brandColor, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
    );
  }
}