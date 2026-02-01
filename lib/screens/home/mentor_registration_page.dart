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
  bool _senhaVisivel = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _whatsAppController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _dataNascController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _outroFormacaoController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _ajudaController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? _genero;
  String? _formacaoAcademica;
  String? _compromissoQuinzenal;
  String? _estado;
  String? _raca;
  String? _areaAtuacao;
  String? _foiMentor;
  String? _foiMentorado;
  String? _compromisso14Sessoes;
  String? _perfilInteresse;

  List<String> _focosEnsinoSelecionados = [];
  List<String> _idiomasSelecionados = [];
  List<String> _hobbiesSelecionados = [];
  List<String> _competenciasExpertise = [];

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

  final List<String> _opcoesExpertise = [
    "Transição de Carreira", "Primeiro Emprego ou Estágio", "Preparação para Entrevistas",
    "Autoconfiança e Insegurança", "Plano de Carreira Prático", "Conhecimento STEM",
    "Habilidades Práticas (Dia a Dia)", "Comunicação Clara e Eficaz", "Networking e Visão de Mercado",
    "Liderança e Gestão", "Inteligência Emocional", "Análise de Dados e Inovação",
    "Empreendedorismo", "Mentoria de Carreira", "Uso de Tecnologias Educacionais"
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _whatsAppController.dispose();
    _linkedinController.dispose();
    _dataNascController.dispose();
    _cidadeController.dispose();
    _outroFormacaoController.dispose();
    _empresaController.dispose();
    _cargoController.dispose();
    _ajudaController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
      initialDate: DateTime(1990),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: brandColor, onSurface: textDark),
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
    setState(() => _currentStep = 2);
  }

  void _irParaTermos() {
    if (!_formKey.currentState!.validate()) return;
    
    if (_competenciasExpertise.length < 2 || _hobbiesSelecionados.length < 2 || _idiomasSelecionados.length < 2 || _focosEnsinoSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione os focos de mentoria e ao menos 2 competências e hobbies."))
      );
      return;
    }

    if (_compromisso14Sessoes != "Sim") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Você precisa confirmar o compromisso com as 14 sessões."))
      );
      return;
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Positioned(
            top: 40, left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => _currentStep == 2 ? setState(() => _currentStep = 1) : Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 60, left: 0, right: 0,
            child: Column(
              children: [
                const Text("STEM Women Network", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                Text(_currentStep == 1 ? "Inscrição de Mentoria" : "Matching e Perfil", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 30)],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(_currentStep == 1 ? "Informações Iniciais" : "Matching e Experiência"),
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
        ],
      ),
    );
  }

  Widget _buildForm1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField("E-mail *", "seu@email.com", controller: _emailController, isRequired: true),
        _buildEmailSuggestions(),
        const SizedBox(height: 20),
        _buildField("Nome Completo *", "Digite seu nome", controller: _nomeController, isRequired: true),
        const SizedBox(height: 20),
        _buildRow([
          _buildField("WhatsApp *", "DDD + Número", controller: _whatsAppController, isRequired: true, isNumber: true),
          _buildField("LinkedIn", "URL do perfil", controller: _linkedinController, isRequired: false),
        ]),
        const SizedBox(height: 20),
        _buildRow([
          _buildClickableField("Nascimento *", "DD/MM/AAAA", _dataNascController, () => _selectDate(context)),
          _buildAutocompleteCity(),
        ]),
        const SizedBox(height: 20),
        _buildRow([
          _buildDropdown("Gênero *", ["Masculino", "Feminino", "Não Binário", "Outro"], (v) => setState(() => _genero = v)),
          _buildDropdown("Formação Acadêmica *", ["TI ou Computação", "Engenharia", "Ciências", "Matemáticas", "Outros"], (v) => setState(() => _formacaoAcademica = v)),
        ]),
        if (_formacaoAcademica == "Outros") Padding(padding: const EdgeInsets.only(top: 15), child: _buildField("Especifique sua formação", "Qual área?", controller: _outroFormacaoController)),
        const SizedBox(height: 20),
        _buildChoiceBox("Comprometimento quinzenal?", ["Sim", "Não", "Talvez"], _compromissoQuinzenal, (v) => setState(() => _compromissoQuinzenal = v)),
      ],
    );
  }

  Widget _buildForm2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Segurança"),
        _buildField("Confirme seu E-mail *", "seu@email.com", isRequired: true, validator: (v) => v != _emailController.text ? "E-mails não conferem" : null),
        const SizedBox(height: 20),
        _buildField("Crie uma Senha *", "Mínimo 6 caracteres", controller: _senhaController, isRequired: true, obscure: true),
        const SizedBox(height: 35),
        _buildSectionTitle("Experiência Profissional"),
        _buildRow([
          _buildAutocompleteState(),
          _buildDropdown("Raça/Etnia *", ["Amarela", "Negra", "Asiática", "Latina", "Branca", "Outra"], (v) => _raca = v),
        ]),
        const SizedBox(height: 20),
        _buildRow([
          _buildField("Empresa *", "Nome", controller: _empresaController, isRequired: true),
          _buildField("Cargo *", "Ex: Tech Lead", controller: _cargoController, isRequired: true),
        ]),
        const SizedBox(height: 20),
        _buildDropdown("Área de Atuação *", ["TI e Dados", "Engenharia", "Ciências", "Arquitetura", "Outros"], (v) => setState(() => _areaAtuacao = v)),
        const SizedBox(height: 20),
        _buildChoiceBox("Já foi mentor antes?", ["Sim", "Não"], _foiMentor, (v) => setState(() => _foiMentor = v)),
        const SizedBox(height: 10),
        _buildChoiceBox("Já foi mentorado antes?", ["Sim", "Não"], _foiMentorado, (v) => setState(() => _foiMentorado = v)),
        const SizedBox(height: 35),
        _buildSectionTitle("Matching Inteligente"),
        _buildChoiceBox("Qual perfil deseja ajudar? *", ["Transição de carreira", "1º estágio/emprego", "Já na área", "Estudantes"], _perfilInteresse, (v) => setState(() => _perfilInteresse = v)),
        const SizedBox(height: 25),
        const Text("Foco da mentoria (Múltiplo) *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(["Hard Skills", "Soft Skills", "Networking"], _focosEnsinoSelecionados),
        const SizedBox(height: 25),
        const Text("Idiomas (Mínimo 2) *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(["Português", "Espanhol", "Inglês"], _idiomasSelecionados),
        const SizedBox(height: 25),
        const Text("Expertise (Mín 2, Máx 4) *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(_opcoesExpertise, _competenciasExpertise, maxSelection: 4),
        const SizedBox(height: 25),
        const Text("Hobbies (Mínimo 2) *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        _buildMultiSelect(_opcoesHobbies, _hobbiesSelecionados),
        const SizedBox(height: 35),
        _buildSectionTitle("Finalização"),
        _buildField("Como você pode ajudar? *", "Descreva aqui", controller: _ajudaController, maxLines: 3, isRequired: true),
        const SizedBox(height: 20),
        _buildField("Bio (Opcional)", "Conte um pouco sobre sua trajetória...", controller: _bioController, maxLines: 4),
        const SizedBox(height: 20),
        _buildChoiceBox("Pode se comprometer com 14 sessões? *", ["Sim", "Não"], _compromisso14Sessoes, (v) => setState(() => _compromisso14Sessoes = v)),
      ],
    );
  }

  Widget _buildField(String label, String hint, {TextEditingController? controller, bool isRequired = false, bool isNumber = false, bool obscure = false, int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller, maxLines: maxLines, obscureText: obscure ? !_senhaVisivel : false,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: _inputDecoration(hint).copyWith(
              suffixIcon: obscure ? IconButton(icon: Icon(_senhaVisivel ? Icons.visibility : Icons.visibility_off, color: brandColor), onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel)) : null,
            ),
            validator: validator ?? (isRequired ? (v) => (v == null || v.isEmpty) ? "Obrigatório" : null : null),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceBox(String label, List<String> options, String? current, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: options.map((opt) {
            bool isSelected = current == opt;
            return ChoiceChip(
              label: Text(opt), selected: isSelected, onSelected: (v) => onSelect(opt),
              selectedColor: petroleo.withOpacity(0.2), backgroundColor: Colors.white,
              labelStyle: TextStyle(color: isSelected ? petroleo : textDark, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              shape: RoundedRectangleBorder(side: BorderSide(color: isSelected ? petroleo : greyBorder), borderRadius: BorderRadius.circular(12)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMultiSelect(List<String> options, List<String> target, {int? maxSelection}) {
    return Wrap(
      spacing: 10, runSpacing: 10,
      children: options.map((o) {
        bool sel = target.contains(o);
        return FilterChip(
          label: Text(o), selected: sel,
          onSelected: (v) => setState(() { if (v) { if (maxSelection == null || target.length < maxSelection!) target.add(o); } else { target.remove(o); } }),
          selectedColor: petroleo.withOpacity(0.2), backgroundColor: Colors.white,
          checkmarkColor: petroleo, shape: RoundedRectangleBorder(side: BorderSide(color: sel ? petroleo : greyBorder), borderRadius: BorderRadius.circular(12)),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: brandColor)),
      Divider(height: 25, color: brandColor.withOpacity(0.3)),
    ],
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint, filled: true, fillColor: Colors.grey[50],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: greyBorder)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: brandColor, width: 2)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
  );

  Widget _buildRow(List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(children: children.map((e) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: e))).toList()),
  );

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        decoration: _inputDecoration("Selecione"),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged, validator: (v) => v == null ? "Obrigatório" : null,
      ),
    ],
  );

  Widget _buildAutocompleteCity() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Cidade *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      const SizedBox(height: 8),
      Autocomplete<String>(
        optionsBuilder: (val) => _cidadesPrincipais.where((s) => _removeAcentos(s.toLowerCase()).contains(_removeAcentos(val.text.toLowerCase()))),
        onSelected: (s) => setState(() => _cidadeController.text = s),
        fieldViewBuilder: (ctx, ctrl, node, onComplete) => TextFormField(controller: ctx.findAncestorStateOfType<_MentorRegistrationPageState>()!._cidadeController, focusNode: node, decoration: _inputDecoration("Cidade"), validator: (v) => (v == null || v.isEmpty) ? "Obrigatório" : null),
      ),
    ],
  );

  Widget _buildAutocompleteState() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Estado *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      const SizedBox(height: 8),
      Autocomplete<String>(
        optionsBuilder: (val) => _estadosBrasil.where((s) => _removeAcentos(s.toLowerCase()).contains(_removeAcentos(val.text.toLowerCase()))),
        onSelected: (s) => setState(() => _estado = s),
        fieldViewBuilder: (ctx, ctrl, node, onComplete) => TextFormField(controller: ctrl, focusNode: node, decoration: _inputDecoration("Estado"), validator: (v) => (v == null || v.isEmpty) ? "Obrigatório" : null),
      ),
    ],
  );

  Widget _buildClickableField(String label, String hint, TextEditingController ctrl, VoidCallback onTap) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Nascimento *", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      const SizedBox(height: 8),
      TextFormField(controller: ctrl, readOnly: true, onTap: onTap, decoration: _inputDecoration(hint).copyWith(suffixIcon: const Icon(Icons.calendar_today, size: 18))),
    ],
  );

  Widget _buildEmailSuggestions() => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Wrap(spacing: 8, children: _emailDomains.map((d) => InkWell(
      onTap: () => setState(() => _emailController.text = _emailController.text.contains("@") ? _emailController.text.substring(0, _emailController.text.indexOf("@")) + d : _emailController.text + d),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: brandColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)), child: Text(d, style: TextStyle(fontSize: 12, color: brandColor, fontWeight: FontWeight.bold))),
    )).toList()),
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