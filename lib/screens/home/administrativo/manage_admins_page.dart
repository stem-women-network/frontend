import 'package:flutter/material.dart';

class ManageAdminsPage extends StatefulWidget {
  const ManageAdminsPage({super.key});

  @override
  State<ManageAdminsPage> createState() => _ManageAdminsPageState();
}

class _ManageAdminsPageState extends State<ManageAdminsPage> {
  final TextEditingController _searchController = TextEditingController();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color coral = const Color(0xFFE4645B);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color verde = const Color(0xFF43A047);

  final List<Map<String, dynamic>> _allAdmins = [
    {
      "nome": "Super Admin",
      "email": "admin@stem.com",
      "whatsapp": "(11) 99999-9999",
      "senha": "admin",
      "nascimento": "15/05/1985",
      "status": "Ativo",
      "ultimo_acesso": "Hoje, 10:00"
    },
    {
      "nome": "Roberto Admin",
      "email": "roberto@stem.com",
      "whatsapp": "(11) 98888-8888",
      "senha": "123",
      "nascimento": "20/10/1990",
      "status": "Ativo",
      "ultimo_acesso": "Ontem, 15:30"
    },
    {
      "nome": "Julia Suporte",
      "email": "julia@stem.com",
      "whatsapp": "(11) 97777-7777",
      "senha": "456",
      "nascimento": "05/02/1995",
      "status": "Inativo",
      "ultimo_acesso": "2 dias atrás"
    },
  ];

  List<Map<String, dynamic>> _filteredAdmins = [];

  @override
  void initState() {
    super.initState();
    _filteredAdmins = List.from(_allAdmins);
    _searchController.addListener(_filterAdmins);
  }

  void _filterAdmins() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAdmins = _allAdmins.where((admin) {
        return admin["nome"]!.toLowerCase().contains(query) ||
            admin["email"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showAddAdminDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final whatsappController = TextEditingController();
    final passwordController = TextEditingController();
    final birthDateController = TextEditingController();
    String status = "Ativo";
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
            title: const Text("Novo Administrador"),
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: birthDateController,
                            decoration: const InputDecoration(
                              labelText: "Nascimento (DD/MM/AAAA)",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today, size: 18),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: status,
                            decoration: const InputDecoration(
                              labelText: "Status",
                              border: OutlineInputBorder(),
                            ),
                            items: ["Ativo", "Inativo"]
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ),
                                )
                                .toList(),
                            onChanged:
                                (val) => setDialogState(() => status = val!),
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
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    setState(() {
                      _allAdmins.add({
                        "nome": nameController.text,
                        "email": emailController.text,
                        "whatsapp": whatsappController.text,
                        "senha": passwordController.text,
                        "nascimento": birthDateController.text,
                        "status": status,
                        "ultimo_acesso": "Nunca",
                      });
                      _filterAdmins();
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Administrador criado com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text("Criar"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAdminDetails(Map<String, dynamic> admin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: coral,
              child: Text(
                admin['nome'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    admin['nome'],
                    style: TextStyle(
                      color: brandColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    admin['email'],
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
                _buildSectionHeader("Informações Pessoais"),
                _buildDetailRow("Data de Nascimento", admin['nascimento']),
                _buildDetailRow("Status", admin['status']),
                _buildDetailRow("Último Acesso", admin['ultimo_acesso']),
                const SizedBox(height: 16),
                _buildSectionHeader("Dados de Contato"),
                _buildDetailRow("WhatsApp", admin['whatsapp']),
                _buildDetailRow("E-mail", admin['email']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> admin) {
    final nameController = TextEditingController(text: admin['nome']);
    final emailController = TextEditingController(text: admin['email']);
    final whatsappController = TextEditingController(text: admin['whatsapp']);
    final passwordController = TextEditingController(text: admin['senha']);
    final birthDateController = TextEditingController(
      text: admin['nascimento'],
    );
    String status = admin['status'];
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
            title: const Text("Editar Administrador"),
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: birthDateController,
                            decoration: const InputDecoration(
                              labelText: "Nascimento",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today, size: 18),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: status,
                            decoration: const InputDecoration(
                              labelText: "Status",
                              border: OutlineInputBorder(),
                            ),
                            items: ["Ativo", "Inativo"]
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ),
                                )
                                .toList(),
                            onChanged:
                                (val) => setDialogState(() => status = val!),
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
                                  admin['nome'] = nameController.text;
                                  admin['email'] = emailController.text;
                                  admin['whatsapp'] = whatsappController.text;
                                  admin['senha'] = passwordController.text;
                                  admin['nascimento'] =
                                      birthDateController.text;
                                  admin['status'] = status;
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Administrador atualizado com sucesso!",
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

  void _confirmDelete(Map<String, dynamic> admin) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text("Excluir Administrador"),
            content: Text(
              "Tem certeza que deseja excluir ${admin['nome']}? Esta ação não pode ser desfeita.",
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
                    _allAdmins.remove(admin);
                    _filterAdmins();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Administrador excluído com sucesso."),
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
          "Gerenciar Administradores",
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Pesquisar por nome ou e-mail...",
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: _showAddAdminDialog,
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text("Adicionar Admin"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verde,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
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
                                    "Status",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Nascimento",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Último Acesso",
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
                                  _filteredAdmins.map((admin) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: coral
                                                    .withOpacity(0.2),
                                                child: Text(
                                                  admin["nome"]![0],
                                                  style: TextStyle(
                                                    color: coral,
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
                                                    admin["nome"]!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    admin["email"]!,
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
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  admin["status"] == "Ativo"
                                                      ? Colors.green
                                                          .withOpacity(0.1)
                                                      : Colors.grey.withOpacity(
                                                        0.1,
                                                      ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              admin["status"]!,
                                              style: TextStyle(
                                                color:
                                                    admin["status"] == "Ativo"
                                                        ? Colors.green
                                                        : Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(Text(admin["nascimento"]!)),
                                        DataCell(Text(admin["ultimo_acesso"]!)),
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
                                                    () =>
                                                        _showAdminDetails(admin),
                                              ),
                                              IconButton(
                                                tooltip: "Editar",
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _showEditDialog(admin),
                                              ),
                                              IconButton(
                                                tooltip: "Excluir",
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _confirmDelete(admin),
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