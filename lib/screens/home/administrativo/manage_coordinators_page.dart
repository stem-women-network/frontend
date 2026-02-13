import 'package:flutter/material.dart';

class ManageCoordinatorsPage extends StatefulWidget {
  const ManageCoordinatorsPage({super.key});

  @override
  State<ManageCoordinatorsPage> createState() => _ManageCoordinatorsPageState();
}

class _ManageCoordinatorsPageState extends State<ManageCoordinatorsPage> {
  final TextEditingController _searchController = TextEditingController();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color roxo = const Color(0xFF6C63FF);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);

  final List<Map<String, dynamic>> _allCoordinators = [
    {
      "nome": "Carlos Mendes",
      "email": "carlos@maua.br",
      "whatsapp": "(11) 99999-9999",
      "senha": "123",
      "universidade": "Instituto Mauá de Tecnologia"
    },
    {
      "nome": "Ana Paula",
      "email": "ana@usp.br",
      "whatsapp": "(11) 88888-8888",
      "senha": "456",
      "universidade": "USP - São Paulo"
    },
    {
      "nome": "Marcos Silva",
      "email": "marcos@unicamp.br",
      "whatsapp": "(19) 97777-7777",
      "senha": "789",
      "universidade": "UNICAMP"
    },
  ];

  List<Map<String, dynamic>> _filteredCoordinators = [];

  @override
  void initState() {
    super.initState();
    _filteredCoordinators = List.from(_allCoordinators);
    _searchController.addListener(_filterCoordinators);
  }

  void _filterCoordinators() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCoordinators = _allCoordinators.where((coord) {
        return coord["nome"]!.toLowerCase().contains(query) ||
            coord["universidade"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showCoordinatorDetails(Map<String, dynamic> coord) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: roxo,
              child: Text(
                coord['nome'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coord['nome'],
                    style: TextStyle(
                      color: brandColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    coord['email'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Vínculo Institucional"),
                _buildDetailRow("Universidade", coord['universidade']),
                const SizedBox(height: 16),
                _buildSectionHeader("Dados de Contato"),
                _buildDetailRow("WhatsApp", coord['whatsapp']),
                _buildDetailRow("E-mail", coord['email']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> coord) {
    final nameController = TextEditingController(text: coord['nome']);
    final emailController = TextEditingController(text: coord['email']);
    final whatsappController = TextEditingController(text: coord['whatsapp']);
    final passwordController = TextEditingController(text: coord['senha']);
    final universityController = TextEditingController(
      text: coord['universidade'],
    );
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("Editar Coordenador"),
            content: SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Nome Completo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: universityController,
                      decoration: const InputDecoration(
                        labelText: "Universidade",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: "E-mail",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: whatsappController,
                            decoration: const InputDecoration(
                              labelText: "WhatsApp",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: obscurePassword,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          title: const Text("Confirmar Alterações"),
                          content: const Text(
                            "Deseja salvar as alterações realizadas?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Não"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brandColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  coord['nome'] = nameController.text;
                                  coord['email'] = emailController.text;
                                  coord['whatsapp'] = whatsappController.text;
                                  coord['senha'] = passwordController.text;
                                  coord['universidade'] =
                                      universityController.text;
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Coordenador atualizado com sucesso!",
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Text("Sim"),
                            ),
                          ],
                        ),
                  );
                },
                child: const Text("Salvar Alterações"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> coord) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text("Excluir Coordenador"),
            content: Text(
              "Tem certeza que deseja excluir ${coord['nome']}? Esta ação não pode ser desfeita.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: coral,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _allCoordinators.remove(coord);
                    _filterCoordinators();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Coordenador excluído com sucesso."),
                      backgroundColor: Colors.grey,
                    ),
                  );
                },
                child: const Text("Excluir"),
              ),
            ],
          ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: petroleo,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Divider(color: petroleo.withOpacity(0.3)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Gerenciar Coordenadores",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Pesquisar por nome ou universidade...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 1000),
                            child: DataTable(
                              headingRowColor: MaterialStateProperty.all(
                                Colors.grey[100],
                              ),
                              columnSpacing: 30,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    "Nome",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Universidade",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "WhatsApp",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Ações",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              rows:
                                  _filteredCoordinators.map((coord) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: roxo
                                                    .withOpacity(0.2),
                                                child: Text(
                                                  coord["nome"]![0],
                                                  style: TextStyle(
                                                    color: roxo,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    coord["nome"]!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    coord["email"]!,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(Text(coord["universidade"]!)),
                                        DataCell(Text(coord["whatsapp"]!)),
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                tooltip: "Ver detalhes",
                                                icon: const Icon(
                                                  Icons.visibility,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _showCoordinatorDetails(
                                                      coord,
                                                    ),
                                              ),
                                              IconButton(
                                                tooltip: "Editar",
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _showEditDialog(coord),
                                              ),
                                              IconButton(
                                                tooltip: "Excluir",
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _confirmDelete(coord),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}