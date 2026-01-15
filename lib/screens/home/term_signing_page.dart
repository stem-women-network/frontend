import 'package:flutter/material.dart';
import 'dart:html' as html; 
import 'package:file_picker/file_picker.dart';
import 'mentee_dashboard_page.dart';

class TermSigningPage extends StatefulWidget {
  const TermSigningPage({super.key});

  @override
  State<TermSigningPage> createState() => _TermSigningPageState();
}

class _TermSigningPageState extends State<TermSigningPage> {
  final Color brandColor = const Color(0xFF3E84A2);
  bool arquivoImportado = false;
  String? nomeArquivo;

  // --- LÓGICA DE DOWNLOAD ---
  void _downloadTermo() {
    const String url = "https://drive.google.com/file/d/1Yfcz4sOYD8SI_K4DUKbGJwsA38gfD4K1/view";
    html.window.open(url, "_blank");
  }

  // --- LÓGICA DE IMPORTAÇÃO (UPLOAD) ---
  Future<void> _importarArquivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        arquivoImportado = true;
        nomeArquivo = result.files.single.name;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Arquivo $nomeArquivo carregado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              label: const Text("Voltar", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Termo de Compromisso",
                              style: TextStyle(
                                fontSize: 26, 
                                fontWeight: FontWeight.w900, 
                                color: brandColor
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Assine o contrato para finalizar seu cadastro",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      _buildSectionTitle("Passo 1: Download"),
                      _buildStepTile(
                        icon: Icons.file_download,
                        title: "Baixar Contrato Oficial",
                        subtitle: "Faça o download do PDF e assine digitalmente.",
                        buttonLabel: "Baixar PDF",
                        onPressed: _downloadTermo,
                      ),

                      const SizedBox(height: 30),
                      _buildSectionTitle("Passo 2: Envio"),
                      _buildStepTile(
                        icon: Icons.cloud_upload,
                        title: "Importar Termo Assinado",
                        subtitle: "O arquivo deve estar no formato PDF.",
                        buttonLabel: arquivoImportado ? "Trocar Arquivo" : "Selecionar Arquivo",
                        color: arquivoImportado ? Colors.green : brandColor,
                        onPressed: _importarArquivo, // AGORA USA A FUNÇÃO REAL
                      ),

                      if (arquivoImportado) ...[
                        const SizedBox(height: 15),
                        _buildFileStatus(),
                      ],

                      const SizedBox(height: 50),

                      Center(
                        child: SizedBox(
                          width: 280,
                          height: 50,
                          child: FilledButton(
                            onPressed: arquivoImportado
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MenteeDashboardPage()),
                                    );
                                  }
                                : null,
                            style: FilledButton.styleFrom(
                              backgroundColor: brandColor,
                              disabledBackgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Finalizar Cadastro",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: brandColor)),
        const Divider(height: 25),
      ],
    );
  }

  Widget _buildFileStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              nomeArquivo ?? "Arquivo selecionado",
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: (color ?? brandColor).withOpacity(0.1),
            child: Icon(icon, color: color ?? brandColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: Colors.black45, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: color ?? brandColor,
              elevation: 0,
              side: BorderSide(color: (color ?? brandColor).withOpacity(0.3)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(buttonLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}