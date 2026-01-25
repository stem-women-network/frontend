import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/home/term_signing_page.dart';

class MentorRegistrationPage extends StatefulWidget {
  const MentorRegistrationPage({super.key});

  @override
  State<MentorRegistrationPage> createState() => _MentorRegistrationPageState();
}

class _MentorRegistrationPageState extends State<MentorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color greyBorder = const Color(0xFFE0E0E0);
  final Color textDark = const Color(0xFF2D3436);

  int _currentStep = 1;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _whatsAppController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _dataNascController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _outroFormacaoController = TextEditingController();
  final TextEditingController _outroComoSoubeController = TextEditingController();
  final TextEditingController _outroCompromissoController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _areaOutroController = TextEditingController();
  final TextEditingController _ajudaController = TextEditingController();
  final TextEditingController _experienciasCompartilharController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _historiaController = TextEditingController();
  final TextEditingController _comentariosFinaisController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  String? _genero;
  String? _formacaoAcademica;
  String? _compromissoQuinzenal;
  String? _comoSoube;
  String? _estado;
  String? _raca;
  String? _areaAtuacao;
  String? _formacaoMentoria;
  String? _foiMentor;
  String? _foiMentorado;
  String? _permitePromover;
  String? _compromisso14Sessoes;

  List<String> _idiomasSelecionados = [];
  List<String> _competenciasSelecionadas = [];
  List<String> _hobbiesSelecionados = [];

  final List<String> _emailDomains = ["@gmail.com", "@outlook.com", "@hotmail.com", "@icloud.com"];
  
  final List<String> _estadosBrasil = [
    "Acre AC", "Alagoas AL", "Amapá AP", "Amazonas AM", "Bahia BA", "Ceará CE",
    "Distrito Federal DF", "Espírito Santo ES", "Goiás GO", "Maranhão MA",
    "Mato Grosso MT", "Mato Grosso do Sul MS", "Minas Gerais MG", "Pará PA",
    "Paraíba PB", "Paraná PR", "Pernambuco PE", "Piauí PI", "Rio de Janeiro RJ",
    "Rio Grande do Norte RN", "Rio Grande do Sul RS", "Rondônia RO", 
    "Roraima RR", "Santa Catarina SC", "São Paulo SP", "Sergipe SE", "Tocantins TO"
  ];

  final List<String> _cidadesPrincipais = [
    "São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza", 
    "Belo Horizonte", "Manaus", "Curitiba", "Recife", "Goiânia", "Belém", 
    "Porto Alegre", "Guarulhos", "Campinas", "São Luís", "São Gonçalo", 
    "Maceió", "Duque de Caxias", "Campo Grande", "Natal", "Teresina", 
    "São Bernardo do Campo", "Nova Iguaçu", "João Pessoa", "Santo André", 
    "Osasco", "São José dos Campos", "Jaboatão dos Guararapes", "Ribeirão Preto", 
    "Uberlândia", "Contagem", "Sorocaba", "Aracaju", "Feira de Santana", 
    "Cuiabá", "Joinville", "Florianópolis", "Londrina", "Juiz de Fora", 
    "Niterói", "Ananindeua", "Porto Velho", "Palmas", "Macapá", "Boa Vista", "Rio Branco"
  ];

  final List<String> _opcoesHobbies = [
    "Tecnologia", "Esportes", "Leitura", "Música", "Culinária", "Viagens", 
    "Artes", "Jogos", "Voluntariado", "Fotografia", "Idiomas", "Dança", 
    "Cinema", "Jardinagem", "Investimentos", "Moda", "Escrita", "Astronomia",
    "Yoga/Meditação", "Board Games", "Pets", "DIY (Faça você mesmo)"
  ];

  final List<String> _opcoesCompetencias = [
    "Conhecimento STEM", "Pensamento crítico", "Comunicação", "Liderança", 
    "Networking", "Gestão de Projetos", "Inteligência Emocional", 
    "Resolução de Conflitos", "Oratória", "Branding Pessoal", 
    "Metodologias Ágeis", "Análise de Dados", "Inovação", 
    "Empreendedorismo", "Mentoria de Carreira"
  ];

  String _removeAcentos(String str) {
    var comAcento = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }
    return str;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: brandColor, onPrimary: Colors.white, surface: Colors.white, onSurface: textDark),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _dataNascController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _validarETriagem() {
    if (!_formKey.currentState!.validate()) return;
    List<String> areasSTEM = ["TI ou Computação e Dados", "Engenharia", "Ciências (Física, Química, Outras)", "Matemáticas"];
    bool isSTEM = areasSTEM.contains(_formacaoAcademica) || 
                  (_outroFormacaoController.text.toLowerCase().contains("eng")) ||
                  (_outroFormacaoController.text.toLowerCase().contains("ti"));

    if (isSTEM) {
      setState(() => _currentStep = 2);
    } else {
      _mostrarDialogoBackup();
    }
  }

  void _irParaTermos() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermSigningPage()),
    ).then((aceitou) {
      if (aceitou == true) {
        _finalizarCadastroReal();
      }
    });
  }

  void _finalizarCadastroReal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Cadastro Realizado!", style: TextStyle(color: brandColor, fontWeight: FontWeight.bold)),
        content: const Text("Suas informações foram unificadas e registradas com sucesso. Entraremos em contato em breve."),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: brandColor),
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context); 
            },
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoBackup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Inscrição Recebida", style: TextStyle(color: brandColor, fontWeight: FontWeight.bold)),
        content: const Text("Obrigado pelo seu interesse! No momento, seu perfil ficará em nossa base de reserva para futuras oportunidades."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("ENTENDIDO", style: TextStyle(color: brandColor, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Positioned(
            top: 50, left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 60, left: 0, right: 0,
            child: Column(
              children: [
                const Text("STEM Women Network", style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text(_currentStep == 1 ? "Inscrição de Mentoria" : "Detalhes do Perfil", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _currentStep == 1 ? _buildForm1() : _buildForm2(),
                          const SizedBox(height: 40),
                          _buildSubmitButton(),
                        ],
                      ),
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

  Widget _buildForm1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Informações de Contato"),
        _buildField("E-mail *", "seu@email.com", controller: _emailController, isRequired: true),
        _buildEmailSuggestions(),
        const SizedBox(height: 20),
        _buildField("Nome Completo *", "Digite seu nome", controller: _nomeController, isRequired: true),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildField(
                "WhatsApp *", 
                "DDD + Número", 
                controller: _whatsAppController, 
                isRequired: true,
                isNumber: true,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Obrigatório";
                  // Aceita de 10 (fixo) a 13 (celular com código 55) dígitos
                  if (val.length < 10 || val.length > 13) return "Número inválido";
                  return null;
                }
              )
            ),
            const SizedBox(width: 20),
            Expanded(child: _buildField("LinkedIn *", "URL do perfil", controller: _linkedinController, isRequired: true)),
          ],
        ),
        const SizedBox(height: 30),
        _buildSectionTitle("Perfil e Localização"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildClickableField("Nascimento *", "DD/MM/AAAA", _dataNascController, () => _selectDate(context))),
            const SizedBox(width: 20),
            Expanded(child: _buildAutocompleteCity()),
          ],
        ),
        const SizedBox(height: 20),
        _buildDropdown("Gênero *", ["Masculino", "Feminino", "Não Binário", "Prefiro não dizer"], (v) => setState(() => _genero = v)),
        const SizedBox(height: 20),
        _buildDropdown("Formação Acadêmica *", [
          "TI ou Computação e Dados", "Engenharia", "Ciências (Física, Química, Outras)",
          "Matemáticas", "Arquitetura", "Negócios ou Administração", "Comunicação ou Marketing", "Outros"
        ], (v) => setState(() => _formacaoAcademica = v)),
        if (_formacaoAcademica == "Outros") Padding(padding: const EdgeInsets.only(top: 15), child: _buildField("Especifique sua formação", "Qual área?", controller: _outroFormacaoController)),
        const SizedBox(height: 20),
        _buildChoiceBox("Você pode se comprometer com sessões quinzenais?", ["Sim", "Não", "Talvez"], _compromissoQuinzenal, (v) => setState(() => _compromissoQuinzenal = v)),
        const SizedBox(height: 20),
        _buildDropdown("Como soube do programa? *", ["Recomendação", "Empresa parceira", "Universidade", "Google/Bing", "LinkedIn", "Mídias Sociais", "Eventos", "Outros"], (v) => setState(() => _comoSoube = v)),
      ],
    );
  }

  Widget _buildForm2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Detalhes Profissionais"),
        _buildField("Confirme seu E-mail *", "Corrija se necessário", controller: _emailController, readOnly: false),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildAutocompleteState()),
            const SizedBox(width: 20),
            Expanded(child: _buildDropdown("Raça/Etnia *", ["Africano", "Negro", "Asiático", "Latino", "Branco", "Outro", "Prefiro não responder"], (v) => _raca = v)),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Idiomas *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(["Português", "Espanhol", "Inglês"], _idiomasSelecionados),
        const SizedBox(height: 30),
        _buildSectionTitle("Experiência Atual"),
        Row(
          children: [
            Expanded(child: _buildField("Empresa *", "Nome da empresa", controller: _empresaController, isRequired: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildField("Cargo *", "Ex: Tech Lead", controller: _cargoController, isRequired: true)),
          ],
        ),
        const SizedBox(height: 20),
        _buildDropdown("Área de Atuação *", ["Desenvolvimento", "Arquitetura", "Business Partner", "TI", "Engenharia", "Dados", "Vendas ou Negócios", "Outros"], (v) => setState(() => _areaAtuacao = v)),
        const SizedBox(height: 20),
        _buildChoiceBox("Possui formação em mentoria ou coach?", ["Sim", "Não"], _formacaoMentoria, (v) => setState(() => _formacaoMentoria = v)),
        const SizedBox(height: 20),
        _buildField("Como podes ajudar? *", "Descreva aqui", controller: _ajudaController, maxLines: 3, isRequired: true),
        const SizedBox(height: 20),
        const Text("Principais Competências *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(_opcoesCompetencias, _competenciasSelecionadas),
        const SizedBox(height: 20),
        const Text("Seus Hobbies (Máx 4) *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 10),
        _buildMultiSelect(_opcoesHobbies, _hobbiesSelecionados, maxSelection: 4),
        const SizedBox(height: 20),
        _buildChoiceBox("Já foi mentor antes?", ["Sim", "Não"], _foiMentor, (v) => setState(() => _foiMentor = v)),
        const SizedBox(height: 20),
        _buildChoiceBox("Podemos promover seu perfil? *", ["Sim", "Não"], _permitePromover, (v) => setState(() => _permitePromover = v)),
      ],
    );
  }

  Widget _buildAutocompleteState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Estado *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
        const SizedBox(height: 8),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue val) {
            if (val.text.isEmpty) return const Iterable<String>.empty();
            String inputNormalized = _removeAcentos(val.text.toLowerCase());
            return _estadosBrasil.where((s) {
              String stateNormalized = _removeAcentos(s.toLowerCase());
              return stateNormalized.contains(inputNormalized);
            });
          },
          onSelected: (s) => setState(() => _estado = s),
          fieldViewBuilder: (ctx, ctrl, node, onComplete) => TextFormField(
            controller: ctrl, focusNode: node, onEditingComplete: onComplete,
            decoration: _inputDecoration("Selecione um estado"),
            style: TextStyle(fontSize: 15, color: textDark),
            validator: (v) {
              if (v == null || v.isEmpty) return "Obrigatório";
              if (!_estadosBrasil.contains(v)) return "Selecione da lista";
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAutocompleteCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cidade *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
        const SizedBox(height: 8),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue val) {
            if (val.text.isEmpty) return const Iterable<String>.empty();
            String inputNormalized = _removeAcentos(val.text.toLowerCase());
            return _cidadesPrincipais.where((s) {
              String cityNormalized = _removeAcentos(s.toLowerCase());
              return cityNormalized.contains(inputNormalized);
            });
          },
          onSelected: (s) => setState(() => _cidadeController.text = s),
          fieldViewBuilder: (ctx, ctrl, node, onComplete) => TextFormField(
            controller: ctrl, focusNode: node, onEditingComplete: onComplete,
            decoration: _inputDecoration("Digite sua cidade"),
            style: TextStyle(fontSize: 15, color: textDark),
            validator: (v) => (v == null || v.isEmpty) ? "Obrigatório" : null,
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceBox(String label, List<String> options, String? current, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options.map((opt) {
            bool isSelected = current == opt;
            return ChoiceChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (v) => onSelect(opt),
              selectedColor: petroleo.withOpacity(0.2),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(color: isSelected ? petroleo : textDark, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              shape: RoundedRectangleBorder(side: BorderSide(color: isSelected ? petroleo : greyBorder), borderRadius: BorderRadius.circular(10)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandColor)),
      const SizedBox(height: 5),
      Container(height: 2, width: 40, color: brandColor.withOpacity(0.3)),
      const SizedBox(height: 20),
    ],
  );

  Widget _buildField(String label, String hint, {TextEditingController? controller, int maxLines = 1, bool isRequired = false, bool readOnly = false, bool isNumber = false, String? Function(String?)? validator}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller, maxLines: maxLines, readOnly: readOnly,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        style: TextStyle(fontSize: 15, color: textDark),
        decoration: _inputDecoration(hint),
        validator: validator ?? (isRequired ? (v) => (v == null || v.isEmpty) ? "Obrigatório" : null : null),
      ),
    ],
  );

  Widget _buildClickableField(String label, String hint, TextEditingController ctrl, VoidCallback onTap) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
      const SizedBox(height: 8),
      TextFormField(
        controller: ctrl, readOnly: true, onTap: onTap,
        style: TextStyle(fontSize: 15, color: textDark),
        decoration: _inputDecoration(hint).copyWith(suffixIcon: Icon(Icons.calendar_today, size: 20, color: brandColor)),
      ),
    ],
  );

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDark)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        decoration: _inputDecoration("Selecione"),
        icon: Icon(Icons.keyboard_arrow_down, color: brandColor),
        dropdownColor: Colors.white,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Obrigatório" : null,
      ),
    ],
  );

  Widget _buildMultiSelect(List<String> options, List<String> target, {int? maxSelection}) => Wrap(
    spacing: 10, runSpacing: 10,
    children: options.map((o) {
      bool sel = target.contains(o);
      return FilterChip(
        label: Text(o, style: TextStyle(fontSize: 12, color: sel ? petroleo : textDark)),
        selected: sel, backgroundColor: Colors.white, selectedColor: Colors.white,
        checkmarkColor: petroleo, side: BorderSide(color: sel ? petroleo : greyBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: (v) {
          setState(() {
            if (v) {
              if (maxSelection == null || target.length < maxSelection) {
                target.add(o);
              }
            } else {
              target.remove(o);
            }
          });
        },
      );
    }).toList(),
  );

  Widget _buildEmailSuggestions() => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Wrap(
      spacing: 8,
      children: _emailDomains.map((d) => InkWell(
        onTap: () => setState(() => _emailController.text = _emailController.text.contains("@") ? _emailController.text.substring(0, _emailController.text.indexOf("@")) + d : _emailController.text + d),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(6)),
          child: Text(d, style: TextStyle(fontSize: 12, color: brandColor, fontWeight: FontWeight.w500)),
        ),
      )).toList(),
    ),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint, filled: true, fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: greyBorder)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: brandColor, width: 2)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
  );

  Widget _buildSubmitButton() => SizedBox(
    width: double.infinity, height: 56,
    child: FilledButton(
      onPressed: _currentStep == 1 ? _validarETriagem : _irParaTermos,
      style: FilledButton.styleFrom(backgroundColor: brandColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(_currentStep == 1 ? "VALIDAR E CONTINUAR" : "FINALIZAR INSCRIÇÃO", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ),
  );
}