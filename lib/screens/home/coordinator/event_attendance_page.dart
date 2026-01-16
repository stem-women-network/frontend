import 'package:flutter/material.dart';

class EventAttendancePage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventAttendancePage({super.key, required this.event});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  @override
  Widget build(BuildContext context) {
    // Lista simulada de alunas que leram o QR Code
    final List<String> attendeesList = [
      "Maria Silva",
      "Ana Souza",
      "Beatriz Santos",
      "Julia Lima",
      "Carla Oliveira",
    ];

    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Detalhes e Presença", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          // QR Code em destaque para reexibição
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=STEM_EVENT_${event["title"]}',
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 10),
                Text(event["title"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          
          // Lista de Meninas Inscritas
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Alunas Presentes (${attendeesList.length})", 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Icon(Icons.people_outline, color: petroleo),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: attendeesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: petroleo.withOpacity(0.1),
                                child: Text("${index + 1}", style: TextStyle(fontSize: 12, color: petroleo, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 15),
                              Text(attendeesList[index], style: const TextStyle(fontWeight: FontWeight.w500)),
                              const Spacer(),
                              const Icon(Icons.check_circle, color: Colors.green, size: 18),
                            ],
                          ),
                        );
                      },
                    ),
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