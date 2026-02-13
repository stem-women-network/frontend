import 'package:flutter/material.dart';

class ManageMenteesPage extends StatefulWidget {
  const ManageMenteesPage({super.key});

  @override
  State<ManageMenteesPage> createState() => _ManageMenteesPageState();
}

class _ManageMenteesPageState extends State<ManageMenteesPage> {
  final TextEditingController _searchController = TextEditingController();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color verde = const Color(0xFF43A047);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color laranja = const Color(0xFFFE9F43);

  final List<Map<String, dynamic>> _allMentees = [
    {
      "nome": "Julia Martins",
      "email": "julia@aluno.br",
      "senha": "123",
      "cpf": "111.222.333-44",
      "whatsapp": "(11) 99999-1111",
      "linkedin": "linkedin.com/in/juliamartins",
      "nascimento": "10/05/2002",
      "cidade": "São Paulo",
      "estado": "SP",
      "genero": "Feminino",
      "raca": "Branca",
      "universidade": "USP",
      "curso": "Engenharia de Computação",
      "semestre": "5º Semestre",
      "objetivos": ["Estágio em Big Data", "Networking"],
      "status": "Ativa",
      "termo_assinado": true
    },
    {
      "nome": "Mariana Silva",
      "email": "mari@aluno.br",
      "senha": "456",
      "cpf": "555.666.777-88",
      "whatsapp": "(19) 98888-2222",
      "linkedin": "linkedin.com/in/marianasilva",
      "nascimento": "20/08/2001",
      "cidade": "Campinas",
      "estado": "SP",
      "genero": "Feminino",
      "raca": "Parda",
      "universidade": "UNICAMP",
      "curso": "Biomedicina",
      "semestre": "7º Semestre",
      "objetivos": ["Carreira Acadêmica", "Iniciação Científica"],
      "status": "Ativa",
      "termo_assinado": true
    },
    {
      "nome": "Patrícia Gomes",
      "email": "paty@aluno.br",
      "senha": "789",
      "cpf": "999.000.111-22",
      "whatsapp": "(11) 97777-3333",
      "linkedin": "linkedin.com/in/patriciagomes",
      "nascimento": "15/02/2003",
      "cidade": "São Caetano",
      "estado": "SP",
      "genero": "Feminino",
      "raca": "Negra",
      "universidade": "Instituto Mauá",
      "curso": "Design de Produto",
      "semestre": "3º Semestre",
      "objetivos": ["UX/UI Design", "Portfólio"],
      "status": "Pendente",
      "termo_assinado": false
    },
  ];

  List<Map<String, dynamic>> _filteredMentees = [];

  @override
  void initState() {
    super.initState();
    _filteredMentees = List.from(_allMentees);
    _searchController.addListener(_filterMentees);
  }

  void _filterMentees() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMentees = _allMentees.where((mentee) {
        return mentee["nome"]!.toLowerCase().contains(query) ||
            mentee["universidade"]!.toLowerCase().contains(query) ||
            mentee["curso"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showMenteeDetails(Map<String, dynamic> mentee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: verde,
              child: Text(
                mentee['nome'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mentee['nome'],
                    style: TextStyle(
                      color: brandColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    mentee['curso'],
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
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Status e Documentação"),
                _buildDetailRow("Status da Conta", mentee['status']),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.description, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      (mentee['termo_assinado'] == true)
                          ? "Termo Assinado"
                          : "Pendente",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    if (mentee['termo_assinado'] == true)
                      TextButton.icon(
                        icon: const Icon(Icons.visibility, size: 16, color: Colors.grey),
                        label: const Text("Ver Arquivo", style: TextStyle(color: Colors.grey)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Abrindo visualizador de PDF..."),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSectionHeader("Informações Pessoais"),
                _buildDetailRow("Email", mentee['email']),
                _buildDetailRow("WhatsApp", mentee['whatsapp']),
                _buildDetailRow("CPF", mentee['cpf']),
                _buildDetailRow("LinkedIn", mentee['linkedin']),
                _buildDetailRow("Data Nasc.", mentee['nascimento']),
                _buildDetailRow(
                  "Localização",
                  "${mentee['cidade']} - ${mentee['estado']}",
                ),
                _buildDetailRow(
                  "Gênero / Raça",
                  "${mentee['genero']} / ${mentee['raca']}",
                ),
                const SizedBox(height: 16),
                _buildSectionHeader("Dados Acadêmicos"),
                _buildDetailRow("Universidade", mentee['universidade']),
                _buildDetailRow("Curso", mentee['curso']),
                _buildDetailRow("Semestre", mentee['semestre']),
                const SizedBox(height: 16),
                _buildSectionHeader("Objetivos e Interesses"),
                _buildTags(mentee['objetivos'], verde),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> mentee) {
    final nameController = TextEditingController(text: mentee['nome']);
    final emailController = TextEditingController(text: mentee['email']);
    final whatsappController = TextEditingController(text: mentee['whatsapp']);
    final passwordController = TextEditingController(text: mentee['senha']);
    final universityController = TextEditingController(text: mentee['universidade']);
    final courseController = TextEditingController(text: mentee['curso']);
    final semesterController = TextEditingController(text: mentee['semestre']);
    String status = mentee['status'];
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
            title: const Text("Editar Mentorada"),
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
                            controller: courseController,
                            decoration: const InputDecoration(
                              labelText: "Curso",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: semesterController,
                            decoration: const InputDecoration(
                              labelText: "Semestre",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(
                        labelText: "Status",
                        border: OutlineInputBorder(),
                      ),
                      items:
                          ["Ativa", "Pendente", "Inativa"]
                              .map(
                                (s) => DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (val) => setDialogState(() => status = val!),
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
                              onPressed: () {
                                setState(() {
                                  mentee['nome'] = nameController.text;
                                  mentee['email'] = emailController.text;
                                  mentee['whatsapp'] = whatsappController.text;
                                  mentee['senha'] = passwordController.text;
                                  mentee['universidade'] = universityController.text;
                                  mentee['curso'] = courseController.text;
                                  mentee['semestre'] = semesterController.text;
                                  mentee['status'] = status;
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Perfil atualizado com sucesso!",
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

  void _confirmDelete(Map<String, dynamic> mentee) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text("Excluir Mentorada"),
            content: Text(
              "Tem certeza que deseja excluir o perfil de ${mentee['nome']}? Esta ação não pode ser desfeita.",
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
                    _allMentees.remove(mentee);
                    _filterMentees();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mentorada excluída com sucesso."),
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
            width: 120,
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

  Widget _buildTags(List<String> tags, Color color) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
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
          "Gerenciar Mentoradas",
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
                      hintText: "Pesquisar por nome, email ou universidade...",
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
                                    "Status",
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
                                    "Curso",
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
                                  _filteredMentees.map((mentee) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: verde
                                                    .withOpacity(0.2),
                                                child: Text(
                                                  mentee["nome"]![0],
                                                  style: TextStyle(
                                                    color: verde,
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
                                                    mentee["nome"]!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    mentee["email"]!,
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
                                                  mentee["status"] == "Ativa"
                                                      ? Colors.green
                                                          .withOpacity(0.1)
                                                      : mentee["status"] ==
                                                          "Pendente"
                                                      ? Colors.orange
                                                          .withOpacity(0.1)
                                                      : Colors.grey.withOpacity(
                                                        0.1,
                                                      ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              mentee["status"]!,
                                              style: TextStyle(
                                                color:
                                                    mentee["status"] == "Ativa"
                                                        ? Colors.green
                                                        : mentee["status"] ==
                                                            "Pendente"
                                                        ? Colors.orange
                                                        : Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(Text(mentee["universidade"]!)),
                                        DataCell(Text(mentee["curso"]!)),
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
                                                        _showMenteeDetails(mentee),
                                              ),
                                              IconButton(
                                                tooltip: "Editar",
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _showEditDialog(mentee),
                                              ),
                                              IconButton(
                                                tooltip: "Excluir",
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed:
                                                    () => _confirmDelete(mentee),
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