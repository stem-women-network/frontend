import 'package:flutter/material.dart';
import 'package:frontend/widgets/default_container.dart';

//TODO: Arrumar layout e adicionar validações
class RegisterMeeting extends StatefulWidget {
  const RegisterMeeting({super.key});
  @override
  RegisterMeetingState createState() => RegisterMeetingState();
}

class RegisterMeetingState extends State<RegisterMeeting> {
  final _formKey = GlobalKey<FormState>();
  final Color brandColor = const Color(0xFF3E84A2);

  DateTime? _dataEncontro;
  String? _horario;
  int? _duracao;
  String? _mentorada;
  String? _temaEncontro;
  String? _topicos;
  int? _avaliacao;
  String? _observacoes;
  DateTime? _dataSugerida;
  String? _horarioSugerido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF387B99),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
                      Text(
                        "Voltar",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultContainer(
                      children: [
                        Text(
                          "Registrar Encontro",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Documente os detalhes da sessão de mentoria"),
                        Form(
                          key: _formKey,
                          child: Column(
                            spacing: 5,
                            children: [
                              Text("Informações do encontro"),
                              Wrap(
                                children: [
                                  Column(
                                    children: [
                                      _buildLabel("Data do encontro"),
                                      TextFormField(
                                        onSaved: (value) {
                                          var dateList = value!
                                              .split("/")
                                              .map((e) => int.parse(e))
                                              .toList();
                                          _dataEncontro = DateTime.utc(
                                            dateList[2],
                                            dateList[1],
                                            dateList[0],
                                          );
                                        },
                                        decoration: _inputDecoration(
                                          "dd/mm/yyyy",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      _buildLabel("Horário"),
                                      TextFormField(
                                        onSaved: (value) => _horario = value,
                                        decoration: _inputDecoration("--:--"),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      _buildLabel("Duração (em minutos)"),
                                      TextFormField(
                                        onSaved: (value) =>
                                            _duracao = int.parse(value!),
                                        decoration: _inputDecoration("60"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildLabel("Mentorada"),
                                  DropdownMenuFormField(
                                    onSaved: (value) => _mentorada = value,
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(
                                        label: "Mentorada",
                                        value: "Mentorada",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildLabel("Tema do encontro"),
                                  TextFormField(
                                    onSaved: (value) => _temaEncontro = value,
                                    decoration: _inputDecoration(
                                      "Ex: Revisão de currículo, Planejamento de carreira",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildLabel("Tópicos"),
                                  TextFormField(
                                    onSaved : (value) => _topicos = value,
                                    maxLines: 3,
                                    decoration: _inputDecoration(
                                      "Descreva os principais tópicos abordados durante a sessão",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildLabel(
                                    "Avaliação de progresso de mentorada",
                                  ),
                                  RadioGroup<int>(
                                    groupValue: _avaliacao,
                                    onChanged: (value) => setState(() {
                                      _avaliacao = value;
                                    }),
                                    child: Row(
                                      spacing: 8,
                                      children: List.generate(5, (i) => i + 1)
                                          .map(
                                            (value) =>
                                                CustomRadio(value: value),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildLabel(
                                    "Observações e próximos passos (só mentor)",
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    onSaved: (value) => _observacoes = value,
                                    decoration: _inputDecoration(
                                      "Adicione observações relevantes e defina os próximos passos...",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Agendar Próximo Encontro"),
                                  Wrap(
                                    children: [
                                      Column(
                                        children: [
                                          _buildLabel("Data sugerida"),
                                          TextFormField(
                                            onSaved: (value) {
                                              var dateList = value!
                                                  .split("/")
                                                  .map((e) => int.parse(e))
                                                  .toList();
                                              _dataSugerida = DateTime.utc(
                                                dateList[2],
                                                dateList[1],
                                                dateList[0],
                                              );
                                            },
                                            decoration: _inputDecoration(
                                              "dd/mm/yyyy",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          _buildLabel("Horário"),
                                          TextFormField(
                                            onSaved: (value) => _horarioSugerido = value,
                                            decoration: _inputDecoration(
                                              "--:--",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FloatingActionButton(onPressed: () => ()),
                                      FloatingActionButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate() && _avaliacao != null) {
                                            _formKey.currentState!.save();
                                            print(_dataEncontro);
                                            print(_horario);
                                            print(_duracao);
                                            print(_mentorada);
                                            print(_temaEncontro);
                                            print(_topicos);
                                            print(_avaliacao);
                                            print(_observacoes);
                                            print(_dataSugerida);
                                            print(_horarioSugerido);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: brandColor, width: 1.5),
      ),
    );
  }
}

class CustomRadio extends StatefulWidget {
  const CustomRadio({super.key, required this.value});

  final int value;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return RawRadio(
      groupRegistry: RadioGroup.maybeOf<int>(context),
      value: widget.value,
      builder: (context, states) {
        final bool isSelected = states.states.contains(WidgetState.selected);
        final Color color = isSelected ? Colors.blue : Colors.grey;
        return GestureDetector(
          onTap: () =>
              RadioGroup.maybeOf<int>(context)?.onChanged(widget.value),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
              border: Border.all(color: color, width: 2),
            ),
            child: Center(child: Text("${widget.value}")),
          ),
        );
      },
      mouseCursor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        return SystemMouseCursors.click;
      }),
      toggleable: false,
      focusNode: FocusNode(),
      autofocus: false,
      enabled: true,
    );
  }
}
