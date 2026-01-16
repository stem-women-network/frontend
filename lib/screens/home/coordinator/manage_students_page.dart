import 'package:flutter/material.dart';
import 'student_details_page.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color textGrey = const Color(0xFF757575);
  
  int _selectedFilter = 0; 

  final List<Map<String, dynamic>> _students = [
    {
      "name": "Maria Silva",
      "course": "Ciência da Computação",
      "status": "Com Match",
      "mentor": "Ana Paula Serra",
      "color": Colors.purple.shade100,
    },
    {
      "name": "Joana Dark",
      "course": "Engenharia Física",
      "status": "Pendente",
      "mentor": null,
      "color": Colors.orange.shade100,
    },
    {
      "name": "Ada Lovelace",
      "course": "Matemática",
      "status": "Com Match",
      "mentor": "Katherine Johnson",
      "color": Colors.blue.shade100,
    },
    {
      "name": "Grace Hopper",
      "course": "Sistemas de Informação",
      "status": "Pendente",
      "mentor": null,
      "color": Colors.green.shade100,
    },
    {
      "name": "Carol Shaw",
      "course": "Jogos Digitais",
      "status": "Com Match",
      "mentor": "Roberta Williams",
      "color": Colors.red.shade100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _students.where((s) {
      if (_selectedFilter == 0) return true;
      if (_selectedFilter == 1) return s["status"] == "Com Match";
      if (_selectedFilter == 2) return s["status"] == "Pendente";
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Gerenciar Alunas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar por nome ou curso...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip("Todos", 0),
                      const SizedBox(width: 10),
                      _buildFilterChip("Com Match", 1),
                      const SizedBox(width: 10),
                      _buildFilterChip("Pendente", 2),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: filteredList.isEmpty 
                ? const Center(child: Text("Nenhuma aluna encontrada.", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final student = filteredList[index];
                      return _buildStudentCard(student);
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    bool isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? brandColor : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    bool hasMatch = student["status"] == "Com Match";
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: student["color"],
            child: Text(
              student["name"].substring(0, 1),
              style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(student["course"], style: TextStyle(color: textGrey, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: hasMatch ? Colors.green.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        hasMatch ? Icons.check_circle : Icons.access_time, 
                        size: 12, 
                        color: hasMatch ? Colors.green.shade700 : Colors.orange.shade700
                      ),
                      const SizedBox(width: 4),
                      Text(
                        hasMatch ? "Mentora: ${student['mentor']}" : "Aguardando Match",
                        style: TextStyle(
                          fontSize: 11, 
                          fontWeight: FontWeight.w600,
                          color: hasMatch ? Colors.green.shade700 : Colors.orange.shade700
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetailsPage(studentData: student),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}