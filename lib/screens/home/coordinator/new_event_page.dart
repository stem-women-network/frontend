import 'package:flutter/material.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _eventDate;
  TimeOfDay? _eventTime;
  bool _isGenerating = false;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: petroleo)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _eventDate = picked);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: petroleo)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _eventTime = picked);
  }

  void _showQRCodeDialog() {
    setState(() => _isGenerating = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isGenerating = false);
      if (!mounted) return;
      
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Evento Criado!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Escaneie para registrar presença", 
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 20),
                  
                  // Moldura branca com sombra leve (sem fundo colorido)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Image.network(
                      'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=STEM_EVENT_${_titleController.text}',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  Text(_titleController.text.toUpperCase(), 
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.1)),
                  
                  const SizedBox(height: 25),

                  // Botão de Baixar QR Code
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("QR Code salvo na galeria!")),
                        );
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text("Baixar QR Code"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: petroleo,
                        side: BorderSide(color: petroleo.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Botão Concluir
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: petroleo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Concluir"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
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
        title: const Text("Novo Evento", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Informações Básicas"),
              const SizedBox(height: 20),
              _buildFieldLabel("Título do Evento"),
              _buildTextField(_titleController, "Ex: Workshop de Liderança Feminina", Icons.event),
              const SizedBox(height: 20),
              _buildFieldLabel("Localização"),
              _buildTextField(_locationController, "Ex: Auditório Principal", Icons.location_on_outlined),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel("Data"),
                        _buildPickerTile(_eventDate == null ? "DD/MM/AAAA" : "${_eventDate!.day}/${_eventDate!.month}/${_eventDate!.year}", Icons.calendar_month, _selectDate),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel("Horário"),
                        _buildPickerTile(_eventTime == null ? "00:00" : _eventTime!.format(context), Icons.access_time, _selectTime),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),
              _buildSectionTitle("Configurações de Presença"),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner, color: petroleo),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text("O QR Code para registro de presença será gerado após a criação.", style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: _isGenerating ? null : _showQRCodeDialog,
                  style: FilledButton.styleFrom(
                    backgroundColor: petroleo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isGenerating 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Criar Evento e Gerar QR Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  Widget _buildFieldLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon) => TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: petroleo, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: petroleo)),
    ),
  );

  Widget _buildPickerTile(String text, IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: petroleo),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}