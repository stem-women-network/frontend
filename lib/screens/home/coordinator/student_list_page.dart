import 'package:flutter/material.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);

  final List<Map<String, dynamic>> students = [
    {"name": "Alice Ferreira", "course": "Engenharia de Produção", "semester": "6º", "hasMentor": true},
    {"name": "Beatriz Silva", "course": "Ciência da Computação", "semester": "2º", "hasMentor": false},
    {"name": "Carolina Souza", "course": "Engenharia Elétrica", "semester": "8º", "hasMentor": true},
    {"name": "Daniela Lima", "course": "Sistemas de Informação", "semester": "4º", "hasMentor": false},
    {"name": "Eduarda Costa", "course": "Engenharia Mecânica", "semester": "5º", "hasMentor": true},
  ];

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
        title: const Text("Alunas Inscritas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar aluna ou curso...",
                prefixIcon: Icon(Icons.search, color: petroleo),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                  borderSide: BorderSide(color: Colors.grey.shade200)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                  borderSide: BorderSide(color: Colors.grey.shade200)
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                // CORREÇÃO AQUI: de .bottom(20) para .only(bottom: 20)
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02), 
                          blurRadius: 10, 
                          offset: const Offset(0, 4)
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: student["hasMentor"] 
                              ? Colors.green.withOpacity(0.1) 
                              : Colors.orange.withOpacity(0.1),
                          child: Icon(
                            student["hasMentor"] ? Icons.person : Icons.person_search,
                            color: student["hasMentor"] ? Colors.green : Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Text("${student['course']} • ${student['semester']} Sem.", 
                                style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: student["hasMentor"] ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            student["hasMentor"] ? "Com Mentora" : "Aguardando",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: student["hasMentor"] ? Colors.green.shade700 : Colors.orange.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}