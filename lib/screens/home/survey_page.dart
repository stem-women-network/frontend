import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  // Cores do seu padrão
  final Color brandColor = const Color(0xFF3E84A2); // Azul do fundo
  final Color petroleo = const Color(0xFF0B6F8E);   // Azul dos botões/seleção

  // Variáveis para guardar as notas (0 = nenhuma selecionada)
  int _mentoraComRating = 0;
  int _mentoraPontualRating = 0;
  int _conteudoRating = 0;
  int _desenvolvimentoRating = 0;
  int _geralRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor, // Fundo azul total (como na imagem)
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          label: const Text(
            "Voltar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          style: TextButton.styleFrom(padding: const EdgeInsets.only(left: 20)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Container(
            // O "Cartão Branco" centralizado
            constraints: const BoxConstraints(maxWidth: 700), // Limita largura em telas grandes
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título e Subtítulo
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Pesquisa de Satisfação",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Ajude-nos a melhorar o programa com seu feedback",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),

                // Caixa Azul de Informação
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD), // Azul bem clarinho
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFBBDEFB)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avaliação de Meio de Programa",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Por favor, avalie cada aspecto abaixo de 1 a 5, onde 1 é \"Muito insatisfeita\" e 5 é \"Muito satisfeita\". Sua resposta é confidencial e será usada apenas para melhorar o programa.",
                        style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // --- SEÇÕES DE PERGUNTAS ---
                _buildRatingSection(
                  category: "Mentora",
                  question: "Como você avalia a comunicação com sua mentora?",
                  rating: _mentoraComRating,
                  onChanged: (val) => setState(() => _mentoraComRating = val),
                ),
                _buildRatingSection(
                  category: "Mentora",
                  question: "Sua mentora tem se mostrado disponível e pontual?",
                  rating: _mentoraPontualRating,
                  onChanged: (val) => setState(() => _mentoraPontualRating = val),
                ),
                _buildRatingSection(
                  category: "Conteúdo",
                  question: "O conteúdo das reuniões tem sido relevante para seus objetivos?",
                  rating: _conteudoRating,
                  onChanged: (val) => setState(() => _conteudoRating = val),
                ),
                _buildRatingSection(
                  category: "Desenvolvimento",
                  question: "Você sente que está desenvolvendo novas habilidades?",
                  rating: _desenvolvimentoRating,
                  onChanged: (val) => setState(() => _desenvolvimentoRating = val),
                ),
                _buildRatingSection(
                  category: "Geral",
                  question: "De modo geral, qual sua satisfação com o programa até agora?",
                  rating: _geralRating,
                  onChanged: (val) => setState(() => _geralRating = val),
                ),

                // Campo de Texto
                const Text("Comentários adicionais (opcional)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Compartilhe sugestões, melhorias, críticas, elogios...",
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: petroleo),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Botão de Enviar (Alinhado à direita)
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 150,
                    height: 45,
                    child: FilledButton(
                      onPressed: () {
                        // Ação de enviar
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text("Pesquisa enviada com sucesso!"), backgroundColor: petroleo),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: petroleo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Enviar Pesquisa", style: TextStyle(fontWeight: FontWeight.bold)),
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

  // Widget auxiliar para construir cada bloco de pergunta
  Widget _buildRatingSection({
    required String category,
    required String question,
    required int rating,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const Text("1/5", style: TextStyle(fontSize: 12, color: Colors.grey)), // Indicador estático ou dinâmico se quiser
          ],
        ),
        const SizedBox(height: 5),
        Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 15),
        
        // Linha de Estrelas Quadradas
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza as caixinhas
          children: List.generate(5, (index) {
            int score = index + 1;
            bool isSelected = score == rating; // Se for a nota selecionada, destaca
            
            return GestureDetector(
              onTap: () => onChanged(score),
              child: Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    // Borda azul grossa se selecionado, cinza fina se não
                    color: isSelected ? petroleo : Colors.grey.shade300,
                    width: isSelected ? 2.5 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isSelected ? Icons.star : Icons.star_border_rounded,
                      color: isSelected ? petroleo : Colors.grey.shade400,
                      size: 22,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$score",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? petroleo : Colors.grey.shade600,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        
        // Legendas "Muito insatisfeita" ... "Muito satisfeita"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Muito insatisfeita", style: TextStyle(fontSize: 11, color: Colors.grey)),
            Text("Muito satisfeita", style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey.shade200, thickness: 1),
        const SizedBox(height: 20),
      ],
    );
  }
}