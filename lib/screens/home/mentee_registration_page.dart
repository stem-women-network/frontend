import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/home/term_signing_page.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/university_service.dart';

class MenteeRegistrationPage extends StatefulWidget {
  const MenteeRegistrationPage({super.key});

  @override
  State<MenteeRegistrationPage> createState() => _MenteeRegistrationPageState();
}

class _MenteeRegistrationPageState extends State<MenteeRegistrationPage> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color greyBorder = const Color(0xFFE0E0E0);
  final Color textDark = const Color(0xFF2D3436);

  bool _senhaVisivel = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _periodoController = TextEditingController();

  String? _gender;
  String? _race;
  String? _wasMentee;
  String? _formacaoAcademica;
  String? _disponibilidade;
  String? _momentoCarreira;
  String? _focoPrincipal;
  String? _universidadeSelecionada;

  List<String> _idiomasSelecionados = [];
  List<String> _competenciasDesejadas = [];
  List<String> _hobbiesSelecionados = [];

  bool _canCommit = false;
  bool _authorized = false;

  final List<String> _opcoesHobbies = [
    "Tecnologia",
    "Esportes",
    "Leitura",
    "Música",
    "Culinária",
    "Viagens",
    "Artes",
    "Jogos",
    "Voluntariado",
    "Fotografia",
    "Idiomas",
    "Dança",
    "Cinema",
    "Jardinagem",
    "Investimentos",
    "Moda",
    "Escrita",
    "Astronomia",
    "Yoga/Meditação",
    "Board Games",
    "Pets",
    "DIY (Faça você mesmo)",
  ];

  final List<String> _opcoesCompetencias = [
    "Transição de Carreira",
    "Primeiro Emprego ou Estágio",
    "Preparação para Entrevistas",
    "Autoconfiança e Insegurança",
    "Plano de Carreira Prático",
    "Conhecimento STEM",
    "Habilidades Práticas (Dia a Dia)",
    "Comunicação Clara e Eficaz",
    "Networking e Visão de Mercado",
    "Liderança e Gestão",
    "Inteligência Emocional",
    "Análise de Dados e Inovação",
    "Empreendedorismo",
    "Mentoria de Carreira",
    "Uso de Tecnologias Educacionais",
  ];

  Future _getUniversities() async {
    final UniversityService universityService = UniversityService();
    return await universityService.getUniversitiesNames();
  }

  late Future _fetchData;

  @override
  void initState() {
    _fetchData = _getUniversities();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _linkedinController.dispose();
    _birthDateController.dispose();
    _courseController.dispose();
    _periodoController.dispose();
    super.dispose();
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
        _birthDateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _validarEEnviar() async {
    if (!_formKey.currentState!.validate()) return;

    if (_idiomasSelecionados.length < 2) {
      _showSnackBar("Selecione pelo menos 2 idiomas!");
      return;
    }

    if (_competenciasDesejadas.length < 2) {
      _showSnackBar("Selecione pelo menos 2 competências!");
      return;
    }

    if (_hobbiesSelecionados.length < 2) {
      _showSnackBar("Selecione pelo menos 2 hobbies!");
      return;
    }

    if (!_canCommit ||
        !_authorized ||
        _disponibilidade == null ||
        _momentoCarreira == null) {
      _showSnackBar("Preencha as seleções obrigatórias e aceite os termos.");
      return;
    }

    final response = await authService.registerMentee(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      cpf: _cpfController.text,
      password: _passwordController.text,
      birthDate: _birthDateController.text,
      linkedin: _linkedinController.text,
      gender: _gender!,
      race: _race!,
      course: _courseController.text,
      semester: int.parse(_periodoController.text),
      year: int.parse(_periodoController.text) % 2,
      skills: _competenciasDesejadas,
      hobbies: _hobbiesSelecionados,
      languages: _idiomasSelecionados,
      university: _universidadeSelecionada!,
      stemArea: _formacaoAcademica!,
      currentSituation: _momentoCarreira!,
      mentoringGoal: _focoPrincipal!,
      availability: _disponibilidade!,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermSigningPage()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
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

                        _buildSectionTitle("Dados Pessoais"),
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
                            "WhatsApp",
                            "(00) 00000-0000",
                            controller: _phoneController,
                            required: true,
                            isNumber: true,
                          ),
                        ]),
                        _buildRow([
                          _buildField(
                            "CPF",
                            "000.000.000-00",
                            controller: _cpfController,
                            required: true,
                            isNumber: true,
                          ),
                          _buildField(
                            "Senha",
                            "**********",
                            controller: _passwordController,
                            required: true,
                            obscure: true,
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
                            "LinkedIn (Opcional)",
                            "linkedin.com/in/perfil",
                            controller: _linkedinController,
                          ),
                        ]),
                        _buildRow([
                          _buildDropdownField(
                            "Gênero",
                            ["Feminino", "Masculino", "Não-binário", "Outro"],
                            _gender,
                            (v) => setState(() => _gender = v),
                          ),
                          _buildDropdownField(
                            "Raça/etnia",
                            ["Amarela", "Branca", "Indígena", "Parda", "Preta"],
                            _race,
                            (v) => setState(() => _race = v),
                          ),
                        ]),

                        const SizedBox(height: 35),
                        _buildSectionTitle("Perfil Acadêmico"),
                        _buildAutocompleteUniversity(),
                        const SizedBox(height: 20),
                        _buildDropdownField(
                          "Área do Curso (STEM)",
                          [
                            "TI e Dados",
                            "Engenharia",
                            "Ciências",
                            "Matemáticas",
                            "Arquitetura",
                            "Outros",
                          ],
                          _formacaoAcademica,
                          (v) => setState(() => _formacaoAcademica = v),
                          isRequired: true,
                        ),
                        _buildRow([
                          _buildField(
                            "Nome do Curso",
                            "Ex: ADS",
                            controller: _courseController,
                            required: true,
                          ),
                          _buildField(
                            "Ano ou Semestre Atual",
                            "Ex: 4º Semestre",
                            controller: _periodoController,
                            required: true,
                          ),
                        ]),

                        const SizedBox(height: 35),
                        _buildSectionTitle("Matching Inteligente"),
                        _buildChoiceBox(
                          "Qual seu momento atual?",
                          [
                            "Buscando transição de carreira",
                            "Buscando 1º estágio/emprego",
                            "Já trabalho na área",
                            "Apenas estudando",
                          ],
                          _momentoCarreira,
                          (v) => setState(() => _momentoCarreira = v),
                        ),
                        const SizedBox(height: 25),
                        _buildChoiceBox(
                          "Onde quer focar na mentoria?",
                          [
                            "Hard Skills (Técnico)",
                            "Soft Skills (Comportamental)",
                            "Networking e Carreira",
                          ],
                          _focoPrincipal,
                          (v) => setState(() => _focoPrincipal = v),
                        ),

                        const SizedBox(height: 30),
                        const Text(
                          "Idiomas (Mínimo 2)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMultiSelect([
                          "Português",
                          "Espanhol",
                          "Inglês",
                        ], _idiomasSelecionados),

                        const SizedBox(height: 30),
                        const Text(
                          "Competências para desenvolver (Mín 2, Máx 4)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMultiSelect(
                          _opcoesCompetencias,
                          _competenciasDesejadas,
                          maxSelection: 4,
                        ),

                        const SizedBox(height: 30),
                        const Text(
                          "Seus Hobbies (Mínimo 2)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMultiSelect(_opcoesHobbies, _hobbiesSelecionados),

                        const SizedBox(height: 35),
                        _buildChoiceBox(
                          "Disponibilidade para sessões",
                          ["Manhã", "Tarde", "Noite"],
                          _disponibilidade,
                          (v) => setState(() => _disponibilidade = v),
                        ),

                        const SizedBox(height: 35),
                        _buildSectionTitle("Compromisso"),
                        _buildCheckboxTile(
                          value: _canCommit,
                          title: "Compromisso Quinzenal",
                          subtitle:
                              "Declaro que posso me comprometer com sessões quinzenais.",
                          onChanged: (v) => setState(() => _canCommit = v!),
                        ),
                        _buildCheckboxTile(
                          value: _authorized,
                          title: "Autorização de Dados",
                          subtitle:
                              "Autorizo o compartilhamento do perfil para fins de matching.",
                          onChanged: (v) => setState(() => _authorized = v!),
                        ),

                        const SizedBox(height: 45),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 54,
                            child: FilledButton(
                              onPressed: _validarEEnviar,
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Finalizar Inscrição",
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

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Text(
            "Cadastro de Mentorada",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: brandColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Preencha os campos para o matching inteligente",
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
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: brandColor,
          ),
        ),
        Divider(height: 25, color: brandColor.withOpacity(0.3)),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildField(
    String label,
    String hint, {
    TextEditingController? controller,
    bool required = false,
    bool isEmail = false,
    bool isNumber = false,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscure ? !_senhaVisivel : false,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters: isNumber
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            decoration: _inputDecoration(hint).copyWith(
              suffixIcon: obscure
                  ? IconButton(
                      icon: Icon(
                        _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                        color: brandColor,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _senhaVisivel = !_senhaVisivel),
                    )
                  : null,
            ),
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

  Widget _buildAutocompleteUniversity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Universidade / Instituição",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder(
          future: _fetchData,
          builder: (context, asyncSnapshot) {
            List<dynamic> _universidadesBanco = [];
            if (asyncSnapshot.hasData) {
              _universidadesBanco = asyncSnapshot.data;
            }
            return Autocomplete<String>(
              optionsBuilder: (textValue) => _universidadesBanco.map((entry) {
                if (entry['name'].toLowerCase().contains(
                  textValue.text.toLowerCase(),
                )) {
                  return entry['name'];
                } else {
                  return '';
                }
              }),
              onSelected: (sel) => setState(() {
                var universityEntry = _universidadesBanco
                    .where((entry) => entry['name'] == sel)
                    .firstOrNull;
                if (universityEntry != null) {
                  _universidadeSelecionada = universityEntry['id'];
                } else {
                  _universidadeSelecionada = null;
                }
              }),
              fieldViewBuilder: (ctx, ctrl, node, onComplete) => TextFormField(
                controller: ctrl,
                focusNode: node,
                decoration: _inputDecoration("Selecione sua faculdade"),
                validator: (v) =>
                    (_universidadeSelecionada == null || v!.isEmpty)
                    ? "Selecione da lista"
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChoiceBox(
    String label,
    List<String> options,
    String? current,
    Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((opt) {
            bool isSelected = current == opt;
            return ChoiceChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (v) => onSelect(opt),
              selectedColor: petroleo.withOpacity(0.2),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? petroleo : textDark,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: isSelected ? petroleo : greyBorder),
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMultiSelect(
    List<String> options,
    List<String> target, {
    int? maxSelection,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((o) {
        bool sel = target.contains(o);
        return FilterChip(
          label: Text(o),
          selected: sel,
          onSelected: (v) {
            setState(() {
              if (v) {
                if (maxSelection == null || target.length < maxSelection)
                  target.add(o);
              } else {
                target.remove(o);
              }
            });
          },
          selectedColor: petroleo.withOpacity(0.2),
          backgroundColor: Colors.white,
          checkmarkColor: petroleo,
          labelStyle: TextStyle(
            color: sel ? petroleo : textDark,
            fontWeight: sel ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: sel ? petroleo : greyBorder),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCheckboxTile({
    required bool value,
    required String title,
    required String subtitle,
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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildReadOnlyField(
    String label,
    String hint,
    TextEditingController controller, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            decoration: _inputDecoration(hint).copyWith(
              suffixIcon: Icon(
                Icons.calendar_today,
                color: brandColor,
                size: 18,
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
    String? current,
    Function(String?) onChanged, {
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: current,
            iconEnabledColor: brandColor,
            dropdownColor: Colors.white,
            decoration: _inputDecoration("Selecione"),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 14)),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            validator: (val) =>
                (isRequired && val == null) ? "Obrigatório" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
