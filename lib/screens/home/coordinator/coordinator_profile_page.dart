import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CoordinatorProfilePage extends StatefulWidget {
  const CoordinatorProfilePage({super.key});

  @override
  State<CoordinatorProfilePage> createState() => _CoordinatorProfilePageState();
}

class _CoordinatorProfilePageState extends State<CoordinatorProfilePage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _deptController;
  late TextEditingController _universityController;
  late TextEditingController _idController;

  bool _isEditing = false;
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Prof. Carlos Mendes");
    _bioController = TextEditingController(text: "Coordenador de Engenharias no IMT. Focado em projetos de inclusão de mulheres nas áreas de STEM e inovação acadêmica.");
    _deptController = TextEditingController(text: "Coordenação de Engenharia Elétrica");
    _universityController = TextEditingController(text: "Instituto Mauá de Tecnologia - IMT");
    _idController = TextEditingController(text: "IMT-202409");
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() => _selectedImage = pickedFile);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Foto atualizada!"), backgroundColor: petroleo)
        );
      }
    } catch (e) {
      debugPrint("Erro: $e");
    }
  }

  ImageProvider? _getImageProvider() {
    if (_selectedImage == null) return null;
    return kIsWeb ? NetworkImage(_selectedImage!.path) : FileImage(File(_selectedImage!.path)) as ImageProvider;
  }

  void _showImageSourceActionSheet(BuildContext context) {
    if (!_isEditing) return;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: petroleo),
              title: const Text('Galeria'),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera, color: petroleo),
              title: const Text('Câmera'),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, _selectedImage),
        ),
        title: const Text("Perfil do Coordenador", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
              child: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white, size: 20),
            ),
            onPressed: () {
              if (_isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text("Informações salvas!"), backgroundColor: petroleo)
                );
              }
              setState(() => _isEditing = !_isEditing);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const Text("Informações institucionais de gestão", style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 30),

                // --- AVATAR COM UPLOAD ---
                Center(
                  child: GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))]
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: petroleo,
                            backgroundImage: _getImageProvider(),
                            child: _selectedImage == null 
                                ? const Text("CM", style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold))
                                : null,
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: petroleo, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),

                _buildCard(
                  title: "Dados Pessoais",
                  icon: Icons.badge_outlined,
                  children: [
                    _buildTextField("Nome Completo", _nameController),
                    _buildTextField("Bio Profissional", _bioController, maxLines: 3),
                    _buildTextField("ID Funcional / Matrícula", _idController),
                  ],
                ),

                const SizedBox(height: 20),

                _buildCard(
                  title: "Vínculo Institucional",
                  icon: Icons.account_balance_outlined,
                  children: [
                    _buildTextField("Departamento / Cargo", _deptController),
                    _buildTextField("Universidade", _universityController),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: petroleo, size: 24), const SizedBox(width: 10), Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
          const Divider(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            enabled: _isEditing,
            maxLines: maxLines,
            style: TextStyle(color: Colors.black87, fontWeight: _isEditing ? FontWeight.normal : FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: _isEditing ? Colors.white : Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: petroleo)),
            ),
          ),
        ],
      ),
    );
  }
}