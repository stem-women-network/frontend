import 'dart:io'; 
import 'package:flutter/foundation.dart'; // Importante para saber se é Web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _courseController;
  late TextEditingController _universityController;
  late TextEditingController _linkedinController;

  bool _isEditing = false;

  XFile? _selectedImage; 
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Carolina Oliveira");
    _bioController = TextEditingController(text: "Apaixonada por tecnologia e inovação. Busco aprender mais sobre Inteligência Artificial e Liderança Feminina.");
    _courseController = TextEditingController(text: "Ciência da Computação");
    _universityController = TextEditingController(text: "USP - Universidade de São Paulo");
    _linkedinController = TextEditingController(text: "linkedin.com/in/carolina");
  }

  // --- FUNÇÃO PARA PEGAR A IMAGEM ---
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile; 
        });
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Foto carregada com sucesso!"), backgroundColor: petroleo)
        );
      }
    } catch (e) {
      debugPrint("Erro: $e");
    }
  }

  ImageProvider? _getImageProvider() {
    if (_selectedImage == null) return null;
    
    if (kIsWeb) {
      return NetworkImage(_selectedImage!.path);
    } else {
      return FileImage(File(_selectedImage!.path));
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    if (!_isEditing) return;
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library, color: petroleo),
                title: const Text('Galeria'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera, color: petroleo),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
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
          // --- ALTERAÇÃO AQUI ---
          // Agora, ao voltar, ele manda a variável _selectedImage para a tela anterior
          onPressed: () => Navigator.pop(context, _selectedImage),
        ),
        title: const Text("Meu Perfil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  SnackBar(content: const Text("Perfil salvo!"), backgroundColor: petroleo)
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
                const Text("Essas informações são visíveis para sua mentora", style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 30),

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
                            backgroundColor: coral,
                            backgroundImage: _getImageProvider(),
                            child: _selectedImage == null 
                                ? const Text("CO", style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold))
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
                if (_isEditing)
                  TextButton(
                    onPressed: () => _showImageSourceActionSheet(context), 
                    child: const Text("Alterar Foto", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                  ),
                
                const SizedBox(height: 20),

                _buildCard(
                  title: "Sobre Mim",
                  icon: Icons.person_outline,
                  children: [
                    _buildTextField("Nome de Exibição", _nameController),
                    _buildTextField("Bio", _bioController, maxLines: 3),
                    _buildTextField("Link do LinkedIn", _linkedinController),
                  ],
                ),

                const SizedBox(height: 20),

                _buildCard(
                  title: "Formação",
                  icon: Icons.school_outlined,
                  children: [
                    _buildTextField("Curso", _courseController),
                    _buildTextField("Universidade", _universityController),
                  ],
                ),

                const SizedBox(height: 20),

                _buildCard(
                  title: "Interesses",
                  icon: Icons.auto_awesome_mosaic_outlined,
                  children: [
                    const Text("Tags ajudam no match de mentoria", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: [
                        _buildTag("Liderança Feminina", true),
                        _buildTag("Data Science", true),
                        _buildTag("Python", true),
                        if (_isEditing) _buildAddTagButton(),
                      ],
                    ),
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

  Widget _buildTag(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: _isEditing ? (bool value) {} : null,
      selectedColor: brandColor.withOpacity(0.1),
      checkmarkColor: brandColor,
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(color: isSelected ? brandColor : Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? brandColor.withOpacity(0.3) : Colors.transparent)),
    );
  }

  Widget _buildAddTagButton() {
    return ActionChip(
      label: const Text("Adicionar +"),
      onPressed: () {},
      backgroundColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade300)),
    );
  }
}