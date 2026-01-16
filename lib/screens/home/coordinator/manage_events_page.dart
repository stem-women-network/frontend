import 'package:flutter/material.dart';
import 'event_attendance_page.dart'; // Importe a nova página

class ManageEventsPage extends StatelessWidget {
  const ManageEventsPage({super.key});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {"title": "Workshop: Carreira em Dados", "date": "15/02/2026", "location": "Auditório A", "attendees": 24},
      {"title": "Roda de Conversa: Tech", "date": "20/02/2026", "location": "Sala 302", "attendees": 12},
    ];

    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Meus Eventos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return InkWell(
              onTap: () {
                // Ao clicar no card, abre a lista de presença e o QR
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventAttendancePage(event: event)),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: brandColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.event_available, color: brandColor),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("${event["date"]} • ${event["location"]}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text("${event["attendees"]}", style: TextStyle(fontWeight: FontWeight.bold, color: petroleo)),
                        const Text("Presenças", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}