import 'package:flutter/material.dart';
// Certifique-se que o caminho do import está correto no seu projeto
import 'package:frontend/screens/home/term_signing_page.dart';
import 'package:frontend/services/auth_service.dart';

class MenteeRegistrationPage extends StatefulWidget {
  const MenteeRegistrationPage({super.key});

  @override
  State<MenteeRegistrationPage> createState() => _MenteeRegistrationPageState();
}

class _MenteeRegistrationPageState extends State<MenteeRegistrationPage> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  // --- Controladores de Texto ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _expectationsController = TextEditingController();
  final TextEditingController _experiencesController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  // --- Variáveis de Estado (Seleções) ---
  String? _isFatecStudent; // "Sim" ou "Não"
  String? _gender;
  String? _race;
  String? _wasMentee; // "Sim" ou "Não"

  // --- Checkboxes de Termos ---
  bool _canCommit = false;
  bool _authorized = false;

  @override
  void dispose() {
    // Limpeza dos controladores
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _linkedinController.dispose();
    _birthDateController.dispose();
    _courseController.dispose();
    _semesterController.dispose();
    _expectationsController.dispose();
    _experiencesController.dispose();
    _skillsController.dispose();
    _hobbiesController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  // Função para selecionar data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: brandColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
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
                        _buildHeader(),
                        const SizedBox(height: 40),

                        // --- 1. Identificação Básica ---
                        _buildSectionTitle("Identificação"),

                        _buildRadioGroup(
                          "Você é estudante matriculada na FATEC Ipiranga?",
                          ["Sim", "Não"],
                          _isFatecStudent,
                          (val) => setState(() => _isFatecStudent = val),
                        ),
                        const SizedBox(height: 15),

                        _buildField(
                          "Nome Completo",
                          "Seu nome",
                          controller: _nameController,
                          required: true,
                        ),
                        _buildRow([
                          _buildField(
                            "E-mail",
                            "seu@email.com",
                            controller: _emailController,
                            required: true,
                            isEmail: true,
                          ),
                          _buildField(
                            "Celular / WhatsApp",
                            "(00) 00000-0000",
                            controller: _phoneController,
                            required: true,
                          ),
                        ]),

                        _buildRow([
                          _buildReadOnlyField(
                            "Data de Nascimento",
                            "DD/MM/AAAA",
                            _birthDateController,
                            onTap: () => _selectDate(context),
                          ),
                          _buildField(
                            "Link do LinkedIn",
                            "https://linkedin.com/in/...",
                            controller: _linkedinController,
                          ),
                        ]),

                        // Campos temporários
                        _buildRow([
                          _buildField(
                            "CPF",
                            "000.000.000-00",
                            controller: _cpfController,
                          ),
                          _buildField(
                            "Senha",
                            "**********",
                            controller: _passwordController,
                          ),
                        ]),

                        const SizedBox(height: 30),

                        // --- 2. Dados Demográficos e Acadêmicos ---
                        _buildSectionTitle("Perfil Acadêmico e Demográfico"),

                        _buildField(
                          "Qual o seu curso?",
                          "Ex: Gestão Comercial",
                          controller: _courseController,
                          required: true,
                        ),
                        _buildField(
                          "Em que semestre está cursando?",
                          "Ex: 3º semestre",
                          controller: _semesterController,
                          required: true,
                        ),

                        _buildRow([
                          _buildDropdownField(
                            "Gênero",
                            [
                              "Feminino",
                              "Masculino",
                              "Não-binário",
                              "Prefiro não dizer",
                              "Outro",
                            ],
                            _gender,
                            (val) => setState(() => _gender = val),
                          ),
                          _buildDropdownField(
                            "Raça/etnia",
                            [
                              "Amarela",
                              "Branca",
                              "Indígena",
                              "Parda",
                              "Preta",
                              "Prefiro não dizer",
                            ],
                            _race,
                            (val) => setState(() => _race = val),
                          ),
                        ]),
                        const Text(
                          "* Apenas para fins demográficos e de matching",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // --- 3. Mentoria ---
                        _buildSectionTitle("Sobre a Mentoria"),

                        _buildField(
                          "Quais suas expectativas sobre o programa?",
                          "Descreva suas expectativas...",
                          controller: _expectationsController,
                          maxLines: 3,
                          required: true,
                        ),
                        _buildField(
                          "Quais experiências gostaria de compartilhar com a sua mentora?",
                          "Experiências...",
                          controller: _experiencesController,
                          maxLines: 3,
                          required: true,
                        ),
                        _buildField(
                          "Quais competências você gostaria de desenvolver?",
                          "Ex: Liderança, Python, Oratória...",
                          controller: _skillsController,
                          maxLines: 3,
                          required: true,
                        ),

                        const SizedBox(height: 15),
                        _buildRadioGroup(
                          "Você já foi mentorada em algum outro programa?",
                          ["Sim", "Não"],
                          _wasMentee,
                          (val) => setState(() => _wasMentee = val),
                        ),
                        const SizedBox(height: 15),

                        _buildField(
                          "Quais os seus hobbies e interesses?",
                          "O que você gosta de fazer...",
                          controller: _hobbiesController,
                          maxLines: 2,
                          required: true,
                        ),

                        const SizedBox(height: 30),

                        // --- 4. Termos e Compromisso ---
                        _buildSectionTitle("Compromisso e Autorização"),

                        _buildCheckboxTile(
                          value: _canCommit,
                          title:
                              "Você pode se comprometer com sessões de mentoria quinzenais no período de Maio a Outubro de 2025?",
                          subtitle:
                              "Os horários das mentorias devem ser pela tarde e priorizadas pela agenda do mentor.",
                          onChanged: (val) => setState(() => _canCommit = val!),
                        ),

                        const SizedBox(height: 15),

                        _buildCheckboxTile(
                          value: _authorized,
                          title:
                              "Declaro que tenho interesse no programa de mentoria e autorizo o armazenamento e compartilhamento do meu contato.",
                          subtitle:
                              "Autorizo a FATEC Ipiranga e o programa STEM Women Network a compartilharem meu contato com meu futuro mentor.",
                          onChanged: (val) =>
                              setState(() => _authorized = val!),
                        ),

                        const SizedBox(height: 20),
                        _buildField(
                          "Outros comentários, perguntas e/ou preocupações?",
                          "Algo mais?",
                          controller: _commentsController,
                          maxLines: 2,
                        ),

                        const SizedBox(height: 40),

                        // --- Botão Enviar ---
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 54,
                            child: FilledButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Validações manuais de Radio e Checkbox
                                  if (_isFatecStudent == null ||
                                      _wasMentee == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Por favor, responda todas as perguntas de Sim/Não.",
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  if (!_canCommit || !_authorized) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "É necessário aceitar o compromisso e a autorização para prosseguir.",
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  final response = await authService
                                      .registerMentee(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        cpf: _cpfController.text,
                                        password: _passwordController.text,
                                        phone: _phoneController.text,
                                        linkedin: _linkedinController.text,
                                        birthDate: _birthDateController.text,
                                        course: _courseController.text,
                                        year:
                                            int.parse(
                                              _semesterController.text,
                                            ) %
                                            2,
                                        semester: int.parse(
                                          _semesterController.text,
                                        ),
                                        gender: _gender!,
                                        race: _race!,
                                        wasMentee: _wasMentee == "Sim"
                                            ? true
                                            : false,
                                        skills: _skillsController.text,
                                        expectations:
                                            _expectationsController.text,
                                        hobbies: _hobbiesController.text,
                                        experiences:
                                            _experiencesController.text,
                                        comments: _commentsController.text,
                                      );
                                  print(response);
                                  // Navegação
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TermSigningPage(),
                                    ),
                                  );
                                }
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                "Enviar Cadastro",
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

  // --- Widgets Auxiliares ---

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Text(
            "Ficha de Registro",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: brandColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Programa de Mentoria STEM Women Network",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: brandColor,
          ),
        ),
        Divider(height: 25, color: brandColor.withOpacity(0.3)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: e,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint, {
    TextEditingController? controller,
    bool required = false,
    bool isEmail = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: _inputDecoration(hint),
            validator: (value) {
              if (required && (value == null || value.isEmpty))
                return "Campo obrigatório";
              if (isEmail && value != null && !value.contains("@"))
                return "E-mail inválido";
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Campo de texto que abre DatePicker (somente leitura)
  Widget _buildReadOnlyField(
    String label,
    String hint,
    TextEditingController controller, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            decoration: _inputDecoration(hint).copyWith(
              suffixIcon: Icon(
                Icons.calendar_today,
                color: brandColor,
                size: 20,
              ),
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? "Campo obrigatório" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? currentValue,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: currentValue,
            iconEnabledColor: brandColor,
            dropdownColor: Colors.white,
            decoration: _inputDecoration("Selecione"),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            validator: (val) => val == null ? "Obrigatório" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(
    String title,
    List<String> options,
    String? groupValue,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: options.map((opt) {
            return Row(
              children: [
                Radio<String>(
                  value: opt,
                  groupValue: groupValue,
                  activeColor: brandColor,
                  onChanged: onChanged,
                ),
                Text(opt),
                const SizedBox(width: 15),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckboxTile({
    required bool value,
    required String title,
    String? subtitle,
    required Function(bool?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: CheckboxListTile(
        activeColor: brandColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: const TextStyle(fontSize: 12))
            : null,
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: brandColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
