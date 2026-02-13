import 'package:flutter/material.dart';
import 'package:frontend/services/admin_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeApprovalPage extends StatefulWidget {
  const MenteeApprovalPage({super.key});

  @override
  State<MenteeApprovalPage> createState() => _MenteeApprovalPageState();
}

class _MenteeApprovalPageState extends State<MenteeApprovalPage> {
  final AdminService _adminService = AdminService();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color roxo = const Color(0xFF6C63FF);
  final Color verde = const Color(0xFF43A047);
  final Color coral = const Color(0xFFE4645B);
  final Color greyBg = const Color(0xFFF0F2F5);

  late Future _fetchData;

  Future _getApprovals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? "";
    return _adminService.getApprovalsMentee(token: token);
  }

  @override
  void initState() {
    _fetchData = _getApprovals();
    super.initState();
  }

  void _processarMentee(String menteeId, bool aprovada) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? "";

    await _adminService.updateApprovalMentee(
      menteeId: menteeId,
      token: token,
      approved: aprovada,
    );
    
    setState(() {
      _fetchData = _getApprovals();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(aprovada ? "Operação realizada com sucesso!" : "Decisão revertida."),
        backgroundColor: aprovada ? verde : petroleo,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: brandColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Validação de Mentoradas", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Pendentes", icon: Icon(Icons.pending_actions)),
              Tab(text: "Histórico", icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TabBarView(
                children: [
                  _buildListSection(isHistory: false),
                  _buildListSection(isHistory: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListSection({required bool isHistory}) {
    return FutureBuilder(
      future: _fetchData,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (asyncSnapshot.hasError) {
          return const Center(
            child: Text("Erro ao carregar dados", style: TextStyle(color: Colors.white)),
          );
        }

        final List listaBruta = (asyncSnapshot.data as List? ?? []);
        
        var lista = listaBruta.where((m) {
          final String status = (m['status']?.toString().toLowerCase() ?? 'pending');
          if (isHistory) return status != 'pending';
          return status == 'pending';
        }).toList();

        if (lista.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 60, color: Colors.white.withOpacity(0.5)),
                const SizedBox(height: 16),
                Text(
                  isHistory ? "Nenhum histórico encontrado." : "Nenhuma pendência!",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: lista.length,
          itemBuilder: (context, index) => _buildCard(lista[index], isHistory),
        );
      },
    );
  }

  Widget _buildCard(Map<String, dynamic> mentee, bool isHistory) {
    final String nome = mentee['nome']?.toString() ?? "Sem Nome";
    final String curso = mentee['curso']?.toString() ?? "Estudante";
    final String status = mentee['status']?.toString() ?? "pending";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), 
            blurRadius: 10, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: roxo.withOpacity(0.1),
          child: Text(
            nome.isNotEmpty ? nome[0] : "?", 
            style: TextStyle(color: roxo, fontWeight: FontWeight.bold)
          ),
        ),
        title: Text(nome, style: TextStyle(color: petroleo, fontWeight: FontWeight.bold)),
        subtitle: Text(curso),
        trailing: isHistory 
          ? _buildStatusBadge(status) 
          : const Icon(Icons.expand_more),
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: _buildActionButtons(mentee, isHistory),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    bool isApproved = status.toLowerCase() == 'approved' || status.toLowerCase() == 'ativa';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isApproved ? verde : coral).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isApproved ? "Aprovado" : "Rejeitado",
        style: TextStyle(
          color: isApproved ? verde : coral, 
          fontWeight: FontWeight.bold, 
          fontSize: 12
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> mentee, bool isHistory) {
    final String id = mentee['id']?.toString() ?? "";

    if (isHistory) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: id.isEmpty ? null : () => _processarMentee(id, false),
          icon: const Icon(Icons.undo, size: 18),
          label: const Text("Reverter Decisão"),
          style: OutlinedButton.styleFrom(
            foregroundColor: petroleo, 
            side: BorderSide(color: petroleo),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: id.isEmpty ? null : () => _processarMentee(id, false),
            child: Text("Rejeitar", style: TextStyle(color: coral, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: id.isEmpty ? null : () => _processarMentee(id, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: verde, 
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: const Text(
              "Aprovar", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ),
        ),
      ],
    );
  }
}