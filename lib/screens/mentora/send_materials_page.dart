import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SendMaterialsPage extends StatefulWidget {
  const SendMaterialsPage({super.key});

  @override
  State<SendMaterialsPage> createState() => _SendMaterialsPageState();
}

class _SendMaterialsPageState extends State<SendMaterialsPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color coral = const Color(0xFFE4645B);
  final Color inputGrey = const Color.fromARGB(255, 240, 240, 240);

  // Controllers para capturar o que é digitado
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  String selectedType = 'Link / Vídeo';
  PlatformFile? pickedFile;

  final List<Map<String, String>> _materiaisEnviados = [
    {"titulo": "Guia de Carreira em TI.pdf", "sub": "2.4 MB", "tipo": "pdf"},
    {"titulo": "Mulheres na Liderança Tech", "sub": "15 min", "tipo": "video"},
    {"titulo": "Vagas no LinkedIn", "sub": "Link externo", "tipo": "link"},
  ];

  // Função que realiza o envio real
  void _confirmarEnvio() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, digite um título.")),
      );
      return;
    }

    String tipoFinal;
    String subtitulo;

    // Define o tipo lógico e o subtítulo baseado na seleção
    if (selectedType == 'Link / Vídeo') {
      tipoFinal = 'video';
      subtitulo = _urlController.text.isNotEmpty ? _urlController.text : "Link externo";
    } else if (selectedType == 'Arquivo PDF') {
      tipoFinal = 'pdf';
      subtitulo = pickedFile != null 
          ? "${(pickedFile!.size / 1024).toStringAsFixed(1)} KB" 
          : "Documento PDF";
    } else {
      tipoFinal = 'img';
      subtitulo = "Imagem / JPEG";
    }

    setState(() {
      // Adiciona o novo material no topo da lista
      _materiaisEnviados.insert(0, {
        "titulo": _titleController.text,
        "sub": subtitulo,
        "tipo": tipoFinal,
      });

      // Limpa tudo para o próximo envio
      _titleController.clear();
      _urlController.clear();
      pickedFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Material enviado com sucesso!")),
    );
  }

  Future<void> _pickFile() async {
    FileType type = selectedType == 'Arquivo PDF' ? FileType.custom : FileType.image;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: selectedType == 'Arquivo PDF' ? ['pdf'] : ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Gestão de Materiais",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUploadForm(),
                const SizedBox(height: 40),
                const Text("Materiais Disponíveis para a Mentorada",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildPreviewSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Enviar Novo Conteúdo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          _buildTypeDropdown(),
          const SizedBox(height: 20),
          _buildField("Título do Material", "Ex: Guia de Carreira em TI",
              Icons.title, _titleController),
          const SizedBox(height: 20),
          selectedType == 'Link / Vídeo'
              ? _buildField("URL do Link", "youtube.com/watch?v=...", Icons.link,
                  _urlController)
              : _buildFilePickerArea(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _confirmarEnvio,
              style: FilledButton.styleFrom(
                  backgroundColor: petroleo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text("Confirmar e Enviar",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePickerArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            selectedType == 'Arquivo PDF'
                ? "Documento PDF"
                : "Imagem (JPEG/PNG)",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 8),
        InkWell(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border.all(
                  color: pickedFile != null ? petroleo : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.cloud_upload_outlined,
                    color: pickedFile != null ? petroleo : brandColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                      pickedFile?.name ?? "Clique para selecionar o arquivo",
                      style: TextStyle(
                          color: pickedFile == null ? Colors.black38 : petroleo,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis),
                ),
                if (pickedFile != null)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.red),
                    onPressed: () => setState(() => pickedFile = null),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _materiaisEnviados.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = _materiaisEnviados[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _getIconForType(item['tipo']!),
            title: Text(item['titulo']!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: Text(item['sub']!, style: const TextStyle(fontSize: 12)),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  _materiaisEnviados.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Material removido.")));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getIconForType(String tipo) {
    IconData icon;
    Color color;
    switch (tipo) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        color = Colors.red.shade100;
        break;
      case 'video':
        icon = Icons.play_circle_fill;
        color = Colors.blue.shade100;
        break;
      case 'img':
        icon = Icons.image;
        color = Colors.orange.shade100;
        break;
      default:
        icon = Icons.link;
        color = Colors.grey.shade200;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: Colors.black54, size: 20),
    );
  }

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tipo de Material",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: inputGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: petroleo),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              items: ['Link / Vídeo', 'Arquivo PDF', 'Imagem (JPEG/PNG)']
                  .map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => setState(() {
                selectedType = val!;
                pickedFile = null;
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField(String label, String hint, IconData icon,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: brandColor, size: 20),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}