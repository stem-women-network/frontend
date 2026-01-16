import 'package:flutter/material.dart';

class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentDetailsPage({super.key, required this.studentData});

  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color textGrey = const Color(0xFF757575);

  void _showMentorDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Detalhes da Mentora", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 35,
                backgroundColor: petroleo,
                child: const Icon(Icons.person, color: Colors.white, size: 35),
              ),
              const SizedBox(height: 15),
              Text(
                studentData["mentor"],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                "Senior Tech Lead @ Google",
                style: TextStyle(color: petroleo, fontSize: 13, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              const Divider(),
              const SizedBox(height: 20),
              _buildMentorContactItem(Icons.email_outlined, "Email", "ana.serra@tech.com"),
              const SizedBox(height: 15),
              _buildMentorContactItem(Icons.phone_outlined, "Telefone", "(11) 98888-7777"),
              const SizedBox(height: 15),
              _buildMentorContactItem(Icons.work_outline, "LinkedIn", "/in/anaserra"),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Fechar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasMatch = studentData["status"] == "Com Match";

    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Detalhes da Aluna", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: studentData["color"],
                      child: Text(
                        studentData["name"].substring(0, 1),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      studentData["name"],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      studentData["course"],
                      style: TextStyle(fontSize: 14, color: textGrey),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: hasMatch ? Colors.green.shade50 : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: hasMatch ? Colors.green.shade100 : Colors.orange.shade100),
                      ),
                      child: Text(
                        hasMatch ? "Match Ativo" : "Aguardando Match",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: hasMatch ? Colors.green.shade700 : Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              const Text("Informações de Contato", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),
              _buildInfoRow(Icons.email_outlined, "Email", "aluna@faculdade.edu.br"),
              _buildInfoRow(Icons.phone_outlined, "Telefone", "(11) 99999-9999"),
              _buildInfoRow(Icons.school_outlined, "Semestre", "4º Semestre"),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),

              const Text("Dados da Mentoria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),

              if (hasMatch)
                InkWell(
                  onTap: () => _showMentorDetailsDialog(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: petroleo, size: 24),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Mentora Vinculada", style: TextStyle(fontSize: 12, color: Colors.black54)),
                              const SizedBox(height: 2),
                              Text(
                                "${studentData["mentor"]} (Ver detalhes)",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: petroleo),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.visibility_outlined, color: petroleo.withOpacity(0.5), size: 20),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade400, size: 30),
                      const SizedBox(height: 10),
                      Text(
                        "Esta aluna ainda não possui mentora.",
                        style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.orange.shade300),
                            backgroundColor: Colors.white,
                          ),
                          child: Text("Buscar Mentora Manualmente", style: TextStyle(color: Colors.orange.shade800)),
                        ),
                      )
                    ],
                  ),
                ),

              const SizedBox(height: 40),

              if (hasMatch)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.link_off, size: 20),
                    label: const Text("Desfazer Match (Administrativo)"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade400,
                      side: BorderSide(color: Colors.red.shade200),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: petroleo),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}