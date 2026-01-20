import 'package:flutter/material.dart';

class RegisterMeeting extends StatefulWidget {
  const RegisterMeeting({super.key});
  @override
  RegisterMeetingState createState() => RegisterMeetingState();
}

class RegisterMeetingState extends State<RegisterMeeting> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController(text: "60");
  final TextEditingController _nextDateController = TextEditingController();
  final TextEditingController _nextTimeController = TextEditingController();

  String? _mentorada;
  String? _temaEncontro;
  String? _topicos;
  int? _avaliacao;
  String? _observacoes;
  bool _agendarProxima = false;

  final List<String> _listaMentoradas = ['Carolina Oliveira', 'Ana Beatriz', 'Julia Lima'];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _durationController.dispose();
    _nextDateController.dispose();
    _nextTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: brandColor)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}");
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: brandColor)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => controller.text = picked.format(context));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_avaliacao == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Por favor, avalie o progresso.")));
        return;
      }
      _formKey.currentState!.save();

      Map<String, dynamic> resultData = {
        'meetingFinished': true, 
        'nextMeeting': _agendarProxima 
            ? {
                'date': _nextDateController.text,
                'time': _nextTimeController.text,
              }
            : null 
      };

      Navigator.pop(context, resultData);
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
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))
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
                              Text("Registrar Encontro", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: brandColor)),
                              const SizedBox(height: 8),
                              const Text("Documente os detalhes da sessão de mentoria realizada", style: TextStyle(color: Colors.black45)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        _buildSectionTitle("Detalhes do Encontro"),
                        
                        _buildRow([
                          _buildClickableField("Data", "DD/MM/AAAA", Icons.calendar_today, _dateController, () => _selectDate(context, _dateController)),
                          _buildClickableField("Horário", "--:--", Icons.access_time, _timeController, () => _selectTime(context, _timeController)),
                        ]),

                        _buildRow([
                          _buildField("Duração (min)", "60", controller: _durationController, isNumber: true),
                          _buildDropdownField("Mentorada", "Selecione"),
                        ]),

                        const SizedBox(height: 15),
                        _buildField("Tema do Encontro", "Ex: Revisão de Currículo", onSaved: (v) => _temaEncontro = v),
                        
                        const SizedBox(height: 15),
                        _buildField("Tópicos Abordados", "Descreva brevemente o que foi discutido...", maxLines: 3, onSaved: (v) => _topicos = v),

                        const SizedBox(height: 35),
                        _buildSectionTitle("Avaliação de Progresso"),
                        const Text("Como você avalia a evolução da mentorada hoje?", style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 15),
                        _buildRatingSelector(),

                        const SizedBox(height: 35),
                        _buildSectionTitle("Próximos Passos"),
                        _buildField("Observações e Tarefas", "Defina as tarefas para o próximo encontro...", maxLines: 3, onSaved: (v) => _observacoes = v),
                        
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Checkbox(
                              value: _agendarProxima,
                              activeColor: brandColor,
                              onChanged: (val) {
                                setState(() {
                                  _agendarProxima = val!;
                                  if (!_agendarProxima) {
                                    _nextDateController.clear();
                                    _nextTimeController.clear();
                                  }
                                });
                              },
                            ),
                            const Text("Agendar próxima reunião agora?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),

                        if (_agendarProxima) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey[200]!)
                            ),
                            child: _buildRow([
                              _buildClickableField("Nova Data", "DD/MM/AAAA", Icons.event, _nextDateController, () => _selectDate(context, _nextDateController)),
                              _buildClickableField("Novo Horário", "--:--", Icons.schedule, _nextTimeController, () => _selectTime(context, _nextTimeController)),
                            ]),
                          ),
                        ],

                        const SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 50,
                            child: FilledButton(
                              onPressed: _submitForm,
                              style: FilledButton.styleFrom(
                                backgroundColor: brandColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Salvar Registro", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandColor)),
        const Divider(height: 25, thickness: 1),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: e))).toList(),
      ),
    );
  }

  Widget _buildField(String label, String hint, {int maxLines = 1, bool isNumber = false, TextEditingController? controller, void Function(String?)? onSaved}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          onSaved: onSaved,
          decoration: _inputDecoration(hint),
          validator: (value) => (value == null || value.isEmpty) ? "Obrigatório" : null,
        ),
      ],
    );
  }

  Widget _buildClickableField(String label, String hint, IconData icon, TextEditingController controller, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: _inputDecoration(hint).copyWith(suffixIcon: Icon(icon, size: 20, color: brandColor)),
          validator: (val) => (val == null || val.isEmpty) ? "Obrigatório" : null,
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          icon: Icon(Icons.keyboard_arrow_down, color: brandColor),
          decoration: _inputDecoration(hint),
          validator: (val) => val == null ? "Selecione" : null,
          items: _listaMentoradas.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: (val) => setState(() => _mentorada = val),
        ),
      ],
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        int value = index + 1;
        bool isSelected = _avaliacao == value;
        return InkWell(
          onTap: () => setState(() => _avaliacao = value),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: isSelected ? brandColor : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? brandColor : Colors.grey[300]!, width: 2),
            ),
            child: Center(
              child: Text("$value", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.grey[400])),
            ),
          ),
        );
      }),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: brandColor, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
    );
  }
}