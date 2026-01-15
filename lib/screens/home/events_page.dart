import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // Cores
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E); // Seu tom solicitado
  final Color verdeSucesso = const Color(0xFF2E7D32);

  // Estado dos eventos
  bool _isCerimoniaConfirmed = false;
  bool _isWorkshopConfirmed = true;

  // Função Agenda Google
  Future<void> _addToCalendar(String title, String location) async {
    final Uri calendarUrl = Uri.parse(
      'https://www.google.com/calendar/render?action=TEMPLATE&text=${Uri.encodeComponent(title)}&location=${Uri.encodeComponent(location)}'
    );
    if (!await launchUrl(calendarUrl, mode: LaunchMode.externalApplication)) {
      debugPrint('Erro ao abrir agenda');
    }
  }

  void _showTicketDialog({
    required String title,
    required String date,
    required String time,
    required String location,
    required VoidCallback onCancel, 
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.80, 
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza tudo
          children: [
            // Pega-mão para arrastar
            Container(
              width: 40, height: 4, 
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))
            ),
            const SizedBox(height: 30),

            // Cabeçalho
            Text("SEU INGRESSO DIGITAL", style: TextStyle(fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold, color: Colors.grey[400])),
            const SizedBox(height: 15),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: petroleo)),
            const SizedBox(height: 8),
            Text("$date • $time", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            
            const SizedBox(height: 30),

            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15, offset: const Offset(0, 5))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_2, color: petroleo, size: 200),
                    
                    const SizedBox(height: 10),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                      child: const Text("TOKEN: #8492-ABX", style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                    ),

                    const SizedBox(height: 20),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Apresente este QR Code na entrada para contabilizar sua presença real no evento.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- BOTÕES DE AÇÃO ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _addToCalendar(title, location),
                    icon: const Icon(Icons.calendar_month, size: 18),
                    label: const Text("Agenda"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      foregroundColor: petroleo,
                      side: BorderSide(color: petroleo),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); 
                      onCancel(); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Presença cancelada com sucesso."),
                          backgroundColor: Colors.redAccent,
                        )
                      );
                    },
                    icon: const Icon(Icons.close, size: 18, color: Colors.red),
                    label: const Text("Cancelar"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Eventos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Próximos Encontros",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- CARD 1 ---
            _buildCleanEventCard(
              title: "Cerimônia de Abertura",
              date: "28 Jan • 14:00",
              location: "Auditório Alfa",
              color: petroleo,
              isConfirmed: _isCerimoniaConfirmed,
              onMainAction: () {
                if (_isCerimoniaConfirmed) {
                  _showTicketDialog(
                    title: "Cerimônia de Abertura",
                    date: "28 Jan",
                    time: "14:00",
                    location: "Auditório Alfa",
                    onCancel: () {
                      setState(() => _isCerimoniaConfirmed = false);
                    },
                  );
                } else {
                  setState(() => _isCerimoniaConfirmed = true);
                }
              },
            ),

            const SizedBox(height: 20),

            _buildCleanEventCard(
              title: "Workshop: Mentoria",
              date: "15 Mar • 14:00",
              location: "Lab 04",
              color: const Color(0xFFFE9F43),
              isConfirmed: _isWorkshopConfirmed,
              onMainAction: () {
                if (_isWorkshopConfirmed) {
                  _showTicketDialog(
                    title: "Workshop: Mentoria",
                    date: "15 Mar",
                    time: "14:00",
                    location: "Lab 04",
                    onCancel: () {
                      setState(() => _isWorkshopConfirmed = false);
                    },
                  );
                } else {
                  setState(() => _isWorkshopConfirmed = true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCleanEventCard({
    required String title,
    required String date,
    required String location,
    required Color color,
    required bool isConfirmed,
    required VoidCallback onMainAction,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(date.split('•')[0].split(' ')[0], 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                      Text(date.split('•')[0].split(' ')[1], 
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(location, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(date.split('•')[1], style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          GestureDetector(
            onTap: onMainAction,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: isConfirmed ? verdeSucesso : color,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isConfirmed ? Icons.confirmation_number_outlined : Icons.add_circle_outline,
                    color: Colors.white, 
                    size: 20
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isConfirmed ? "VER MEU INGRESSO" : "GARANTIR MINHA VAGA",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}