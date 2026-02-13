import 'package:flutter/material.dart';

class ManageMentorsPage extends StatefulWidget {
  const ManageMentorsPage({super.key});

  @override
  State<ManageMentorsPage> createState() => _ManageMentorsPageState();
}

class _ManageMentorsPageState extends State<ManageMentorsPage> {
  final TextEditingController _searchController = TextEditingController();
  final Color brandColor = const Color(0xFF3E84A2);
  final Color laranja = const Color(0xFFFE9F43);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color verde = const Color(0xFF43A047);

  final List<Map<String, dynamic>> _allMentors = [
    {
      "nome": "Ana Silva",
      "email": "ana@email.com",
      "senha": "123",
      "cpf": "123.456.789-00",
      "whatsapp": "(11) 98888-8888",
      "linkedin": "linkedin.com/in/anasilva",
      "nascimento": "12/04/1985",
      "cidade": "São Paulo",
      "estado": "SP",
      "genero": "Feminino",
      "raca": "Branca",
      "formacao": "Engenharia de Software",
      "cargo": "Engenheira Sênior",
      "empresa": "Google",
      "area": "TI e Dados",
      "foi_mentor": "Sim",
      "foi_mentorado": "Não",
      "perfil_interesse": "Transição de carreira",
      "focos": ["Hard Skills", "Liderança"],
      "idiomas": ["Português", "Inglês"],
      "skills": ["Java", "Cloud", "System Design"],
      "hobbies": ["Leitura", "Tecnologia"],
      "disponibilidade": "Noite",
      "ajuda": "Posso ajudar com arquitetura de sistemas e revisão de código.",
      "bio": "Engenheira com 10 anos de experiência em grandes tech companies.",
      "status": "Ativa",
      "mentorada": "Julia Martins",
      "termo_assinado": true
    },
    {
      "nome": "Beatriz Lima",
      "email": "bia@email.com",
      "senha": "456",
      "cpf": "222.333.444-55",
      "whatsapp": "(21) 97777-7777",
      "linkedin": "linkedin.com/in/beatrizlima",
      "nascimento": "25/08/1992",
      "cidade": "Rio de Janeiro",
      "estado": "RJ",
      "genero": "Feminino",
      "raca": "Negra",
      "formacao": "Ciência da Computação",
      "cargo": "Tech Lead",
      "empresa": "Nubank",
      "area": "TI e Dados",
      "foi_mentor": "Não",
      "foi_mentorado": "Sim",
      "perfil_interesse": "1º estágio/emprego",
      "focos": ["Soft Skills", "Networking"],
      "idiomas": ["Português", "Espanhol"],
      "skills": ["Liderança", "Fintech", "Agile"],
      "hobbies": ["Viagens", "Fotografia"],
      "disponibilidade": "Manhã",
      "ajuda": "Quero ajudar mulheres negras a entrarem no mercado de tecnologia.",
      "bio": "Tech Lead apaixonada por diversidade e inclusão.",
      "status": "Pendente",
      "mentorada": "Aguardando Match",
      "termo_assinado": true
    },
    {
      "nome": "Elena Costa",
      "email": "elena@email.com",
      "senha": "789",
      "cpf": "999.888.777-66",
      "whatsapp": "(31) 96666-6666",
      "linkedin": "linkedin.com/in/elenacosta",
      "nascimento": "05/01/1980",
      "cidade": "Belo Horizonte",
      "estado": "MG",
      "genero": "Feminino",
      "raca": "Branca",
      "formacao": "Matemática",
      "cargo": "CTO",
      "empresa": "Startup X",
      "area": "Empreendedorismo",
      "foi_mentor": "Sim",
      "foi_mentorado": "Sim",
      "perfil_interesse": "Estudantes",
      "focos": ["Hard Skills", "Empreendedorismo"],
      "idiomas": ["Português", "Inglês", "Francês"],
      "skills": ["Gestão", "Investimentos", "Data Science"],
      "hobbies": ["Yoga", "Artes"],
      "disponibilidade": "Tarde",
      "ajuda": "Mentoria para quem quer fundar sua própria startup.",
      "bio": "Fundadora de 2 startups e atual CTO.",
      "status": "Ativa",
      "mentorada": "Mariana Silva",
      "termo_assinado": true
    },
  ];

  List<Map<String, dynamic>> _filteredMentors = [];

  @override
  void initState() {
    super.initState();
    _filteredMentors = List.from(_allMentors);
    _searchController.addListener(_filterMentors);
  }

  void _filterMentors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMentors = _allMentors.where((mentor) {
        return mentor["nome"]!.toLowerCase().contains(query) ||
            mentor["email"]!.toLowerCase().contains(query) ||
            mentor["empresa"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showMentorDetails(Map<String, dynamic> mentor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: brandColor,
              child: Text(
                mentor['nome'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mentor['nome'],
                    style: TextStyle(
                      color: brandColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    mentor['cargo'],
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
                _buildSectionHeader("Status do Match"),
                _buildDetailRow("Mentorada Atual", mentor['mentorada']),
                _buildDetailRow("Status Conta", mentor['status']),
                const SizedBox(height: 16),
                _buildSectionHeader("Documentação"),
                Row(
                  children: [
                    const Icon(Icons.description, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      (mentor['termo_assinado'] == true)
                          ? "Termo Assinado"
                          : "Pendente",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    if (mentor['termo_assinado'] == true)
                      TextButton.icon(
                        icon: const Icon(Icons.visibility, size: 16, color: Colors.grey,),
                        label: const Text("Ver Arquivo", style: TextStyle(color: Colors.grey),),
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
                _buildDetailRow("Email", mentor['email']),
                _buildDetailRow("WhatsApp", mentor['whatsapp']),
                _buildDetailRow("CPF", mentor['cpf']),
                _buildDetailRow("LinkedIn", mentor['linkedin']),
                _buildDetailRow("Data Nasc.", mentor['nascimento']),
                _buildDetailRow(
                  "Localização",
                  "${mentor['cidade']} - ${mentor['estado']}",
                ),
                _buildDetailRow(
                  "Gênero / Raça",
                  "${mentor['genero']} / ${mentor['raca']}",
                ),
                const SizedBox(height: 16),
                _buildSectionHeader("Formação e Profissão"),
                _buildDetailRow("Formação", mentor['formacao']),
                _buildDetailRow("Empresa", mentor['empresa']),
                _buildDetailRow("Área Atuação", mentor['area']),
                const SizedBox(height: 16),
                _buildSectionHeader("Experiência de Mentoria"),
                _buildDetailRow("Já foi Mentor?", mentor['foi_mentor']),
                _buildDetailRow("Já foi Mentorado?", mentor['foi_mentorado']),
                _buildDetailRow(
                  "Público de Interesse",
                  mentor['perfil_interesse'],
                ),
                _buildDetailRow(
                  "Objetivos",
                  (mentor['focos'] as List).join(", "),
                ),
                _buildDetailRow(
                  "Idiomas",
                  (mentor['idiomas'] as List).join(", "),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader("Skills e Interesses"),
                _buildTags(mentor['skills'], brandColor),
                const SizedBox(height: 8),
                const Text(
                  "Hobbies:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                _buildTags(mentor['hobbies'], Colors.orange),
                const SizedBox(height: 16),
                _buildSectionHeader("Disponibilidade e Bio"),
                _buildDetailRow("Disponibilidade", mentor['disponibilidade']),
                const SizedBox(height: 8),
                const Text(
                  "Como pode ajudar:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  mentor['ajuda'],
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Bio:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  mentor['bio'],
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> mentor) {
    final nameController = TextEditingController(text: mentor['nome']);
    final emailController = TextEditingController(text: mentor['email']);
    final whatsappController = TextEditingController(text: mentor['whatsapp']);
    final passwordController = TextEditingController(text: mentor['senha']);
    final companyController = TextEditingController(text: mentor['empresa']);
    final roleController = TextEditingController(text: mentor['cargo']);
    final linkedinController = TextEditingController(text: mentor['linkedin']);
    final cityController = TextEditingController(text: mentor['cidade']);
    final stateController = TextEditingController(text: mentor['estado']);
    String status = mentor['status'];
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
            title: const Text("Editar Perfil"),
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
                            obscurePassword ? Icons.visibility_off : Icons.visibility,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: companyController,
                            decoration: const InputDecoration(
                              labelText: "Empresa",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: roleController,
                            decoration: const InputDecoration(
                              labelText: "Cargo",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: linkedinController,
                      decoration: const InputDecoration(
                        labelText: "LinkedIn",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              labelText: "Cidade",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: stateController,
                            decoration: const InputDecoration(
                              labelText: "Estado",
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
                                  mentor['nome'] = nameController.text;
                                  mentor['email'] = emailController.text;
                                  mentor['whatsapp'] = whatsappController.text;
                                  mentor['senha'] = passwordController.text;
                                  mentor['empresa'] = companyController.text;
                                  mentor['cargo'] = roleController.text;
                                  mentor['linkedin'] = linkedinController.text;
                                  mentor['cidade'] = cityController.text;
                                  mentor['estado'] = stateController.text;
                                  mentor['status'] = status;
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

  void _confirmDelete(Map<String, dynamic> mentor) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Excluir Mentora"),
            content: Text(
              "Tem certeza que deseja excluir o perfil de ${mentor['nome']}? Esta ação não pode ser desfeita.",
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
                    _allMentors.remove(mentor);
                    _filterMentors();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mentora excluída com sucesso."),
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
          "Gerenciar Mentoras",
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
                      hintText: "Pesquisar por nome, email ou empresa...",
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Mentorada",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Status",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Empresa",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Ações",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows:
                                _filteredMentors.map((mentor) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor: laranja
                                                  .withOpacity(0.2),
                                              child: Text(
                                                mentor["nome"]![0],
                                                style: TextStyle(
                                                  color: laranja,
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
                                                  mentor["nome"]!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  mentor["email"]!,
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
                                        Text(
                                          mentor["mentorada"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                                mentor["status"] == "Ativa"
                                                    ? Colors.green.withOpacity(
                                                      0.1,
                                                    )
                                                    : mentor["status"] ==
                                                        "Pendente"
                                                    ? Colors.orange.withOpacity(
                                                      0.1,
                                                    )
                                                    : Colors.grey.withOpacity(
                                                      0.1,
                                                    ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            mentor["status"]!,
                                            style: TextStyle(
                                              color:
                                                  mentor["status"] == "Ativa"
                                                      ? Colors.green
                                                      : mentor["status"] ==
                                                          "Pendente"
                                                      ? Colors.orange
                                                      : Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(mentor["empresa"]!)),
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
                                                      _showMentorDetails(mentor),
                                            ),
                                            IconButton(
                                              tooltip: "Editar",
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              onPressed:
                                                  () => _showEditDialog(mentor),
                                            ),
                                            IconButton(
                                              tooltip: "Excluir",
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              onPressed:
                                                  () => _confirmDelete(mentor),
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