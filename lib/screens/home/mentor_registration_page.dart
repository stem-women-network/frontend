import 'package:flutter/material.dart';
import 'package:frontend/screens/home/term_signing_page.dart';
import 'package:frontend/services/auth_service.dart';

class MentorRegistrationPage extends StatefulWidget {
  const MentorRegistrationPage({super.key});

  @override
  State<MentorRegistrationPage> createState() => _MentorRegistrationPageState();
}

class _MentorRegistrationPageState extends State<MentorRegistrationPage> {
  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  // Estados
  List<String> selectedAreas = [];
  String? comoSoube;
  bool aceitouTermos = false;

  final TextEditingController _outraAreaController = TextEditingController();
  final TextEditingController _outroComoSoubeController =
      TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final List<String> areasAtuacao = [
    "Engenharia",
    "Ciências de Dados",
    "Desenvolvimento",
    "Física",
    "Matemática",
    "Química",
    "Biologia",
    "TI",
    "Outros",
  ];

  String? _nome;
  String? _cpf;
  String? _email;
  String? _celular;
  String? _senha;
  String? _linkedin;
  String? _formacao;
  String? _cargoAtual;

  @override
  void dispose() {
    _outraAreaController.dispose();
    _outroComoSoubeController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

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
                        offset: const Offset(0, 10),
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
                        _buildRow([
                          _buildField(
                            "Nome completo",
                            "Seu nome",
                            onSaved: (value) => setState(() {
                              _nome = value;
                            }),
                            required: true,
                          ),
                          _buildField(
                            "CPF",
                            "000.000.000-00",
                            onSaved: (value) => setState(() {
                              _cpf = value;
                            }),
                            required: true,
                          ),
                        ]),
                        _buildRow([
                          _buildField(
                            "E-mail",
                            "seu@email.com",
                            onSaved: (value) => setState(() {
                              _email = value;
                            }),
                            required: true,
                            isEmail: true,
                          ),
                          _buildField(
                            "WhatsApp",
                            "(00) 00000-0000",
                            onSaved: (value) => setState(() {
                              _celular = value;
                            }),
                            required: true,
                          ),
                        ]),
                        _buildRow([
                          _buildField(
                            "Senha",
                            "*********",
                            onSaved: (value) => setState(() {
                              _senha = value;
                            }),
                            obscure: true,
                            required: true,
                          ),
                          _buildField(
                            "LinkedIn (opcional)",
                            "URL do perfil",
                            onSaved: (value) => setState(() {
                              _linkedin = value;
                            }),
                          ),
                        ]),

                        _buildRow([
                          _buildReadOnlyField(
                            "Data de Nascimento",
                            "DD/MM/AAAA",
                            _birthDateController,
                            onTap: () => _selectDate(context),
                          ),
                        ]),

                        const SizedBox(height: 30),
                        _buildSectionTitle("Perfil Profissional"),
                        _buildRow([
                          _buildField(
                            "Formação",
                            "Sua graduação",
                            onSaved: (value) => setState(() {
                              _formacao = value;
                            }),
                            required: true,
                          ),
                          _buildField(
                            "Cargo atual",
                            "Ex: Tech Lead",
                            onSaved: (value) => setState(() {
                              _cargoAtual = value;
                            }),
                            required: true,
                          ),
                        ]),

                        const SizedBox(height: 25),
                        const Text(
                          "Áreas de atuação (pode marcar várias)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: areasAtuacao
                              .map(
                                (area) => FilterChip(
                                  label: Text(area),
                                  selected: selectedAreas.contains(area),
                                  selectedColor: brandColor.withOpacity(0.15),
                                  checkmarkColor: brandColor,
                                  labelStyle: TextStyle(
                                    color: selectedAreas.contains(area)
                                        ? brandColor
                                        : Colors.black87,
                                    fontWeight: selectedAreas.contains(area)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      color: selectedAreas.contains(area)
                                          ? brandColor
                                          : Colors.grey[300]!,
                                    ),
                                  ),
                                  onSelected: (val) {
                                    setState(() {
                                      val
                                          ? selectedAreas.add(area)
                                          : selectedAreas.remove(area);
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),

                        if (selectedAreas.contains("Outros")) ...[
                          const SizedBox(height: 15),
                          _buildField(
                            "Especifique a área",
                            "Qual área?",
                            controller: _outraAreaController,
                            required: true,
                          ),
                        ],

                        const SizedBox(height: 30),
                        const Text(
                          "Como ficou sabendo do programa?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          iconEnabledColor: brandColor,
                          decoration: _inputDecoration("Selecione"),
                          items:
                              [
                                    "Instagram",
                                    "Amigos",
                                    "Professora",
                                    "Evento",
                                    "LinkedIn",
                                    "Outros",
                                  ]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) => setState(() => comoSoube = val),
                          validator: (val) =>
                              val == null ? "Campo obrigatório" : null,
                        ),

                        if (comoSoube == "Outros") ...[
                          const SizedBox(height: 15),
                          _buildField(
                            "Especifique como soube",
                            "Escreva aqui",
                            controller: _outroComoSoubeController,
                            required: true,
                          ),
                        ],

                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Checkbox(
                              value: aceitouTermos,
                              activeColor: brandColor,
                              onChanged: (val) =>
                                  setState(() => aceitouTermos = val!),
                            ),
                            const Expanded(
                              child: Text(
                                "Li e aceito os termos de uso e privacidade.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 50,
                            child: FilledButton(
                              onPressed: aceitouTermos
                                  ? () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
                                        if (selectedAreas.contains("Outros") &&
                                            !selectedAreas.contains(
                                              _outraAreaController.text,
                                            )) {
                                          selectedAreas.add(
                                            _outraAreaController.text,
                                          );
                                        }
                                        final response = await authService
                                            .registerMentor(
                                              email: _email!,
                                              password: _senha!,
                                              phone: _celular!,
                                              cpf: _cpf!,
                                              areasAtuacao: selectedAreas
                                                  .where(
                                                    (area) => area != "Outros",
                                                  )
                                                  .toList(),
                                              cargoAtual: _cargoAtual!,
                                              linkedin: _linkedin,
                                              birthDate:
                                                  _birthDateController.text,
                                              formacao: _formacao!,
                                              name: _nome!,
                                              comoFicouSabendo:
                                                  _outroComoSoubeController
                                                          .text !=
                                                      ""
                                                  ? _outroComoSoubeController
                                                        .text
                                                  : comoSoube!,
                                            );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TermSigningPage(),
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                disabledBackgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Criar conta",
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
            "Cadastro de Mentora",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: brandColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Preencha todos os campos obrigatórios",
            style: TextStyle(color: Colors.black45),
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
        const Divider(height: 30),
      ],
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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
    bool obscure = false,
    bool required = false,
    bool isEmail = false,
    TextEditingController? controller,
    void Function(String)? onSaved,
  }) {
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
        const SizedBox(height: 6),
        if (onSaved == null)
          TextFormField(
            controller: controller,
            obscureText: obscure,
            decoration: _inputDecoration(hint),
            validator: (value) {
              if (required && (value == null || value.isEmpty))
                return "Campo obrigatório";
              if (isEmail && value != null && !value.contains("@"))
                return "E-mail inválido";
              return null;
            },
          )
        else
          TextFormField(
            obscureText: obscure,
            decoration: _inputDecoration(hint),
            validator: (value) {
              if (required && (value == null || value.isEmpty))
                return "Campo obrigatório";
              if (isEmail && value != null && !value.contains("@"))
                return "E-mail inválido";
              return null;
            },
            onSaved: (value) {
              onSaved(value ?? "");
            },
          ),
      ],
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
