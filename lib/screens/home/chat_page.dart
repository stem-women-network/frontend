import 'package:flutter/material.dart';
import 'package:frontend/services/mentoring_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- CHAT PAGE: FUNDO AZUL COM CONTEÚDO EM "CARTÃO" BRANCO ---
class ChatPage extends StatefulWidget {
  String actor;
  String otherId;
  ChatPage({super.key, required this.otherId, required this.actor});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // CoresMessageService
  final Color petroleo = const Color(0xFF0B6F8E);
  final Color brandColor = const Color(0xFF3E84A2); // Cor de fundo principal
  final Color textGrey = const Color(0xFF757575);
  final Color bubbleGrey = const Color(0xFFF2F4F5);

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late List<dynamic> _messages;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "actor": widget.actor,
        "message": _controller.text,
        "datetime":
            "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
      });
      _controller.clear();
    });
    Future.delayed(
      const Duration(milliseconds: 100),
      () => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    );
  }

  late Future _fetchData;
  final MentoringService _mentoringService = MentoringService();

  Future getMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    token ??= "";
    return _mentoringService.getMessages(token: token, otherId: widget.otherId);
  }

  @override
  void initState() {
    _fetchData = getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor, // Fundo AZUL da tela inteira
      appBar: AppBar(
        backgroundColor: brandColor, // AppBar também azul
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Ícone branco
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFEAB767),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ana Paula Costa",
                  // Texto branco para contrastar
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Mentora",
                  // Texto branco/claro para contrastar
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // O corpo agora é um Container BRANCO com margens, criando o "quadrado"
      body: Container(
        margin: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          20,
        ), // Margens externas para ver o fundo azul
        decoration: BoxDecoration(
          color: Colors.white, // Fundo branco do "cartão"
          borderRadius: BorderRadius.circular(24), // Bordas arredondadas
        ),
        clipBehavior:
            Clip.hardEdge, // Garante que o conteúdo não vaze as bordas redondas
        child: Column(
          children: [
            FutureBuilder(
              future: _fetchData,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  _messages = asyncSnapshot.data;
                  if (_messages.isEmpty) {
                    return Container();
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      // Padding interno do cartão branco
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final actor = msg['actor'];
                        final isMe = actor == widget.actor;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: isMe ? petroleo : bubbleGrey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(12),
                                    topRight: const Radius.circular(12),
                                    bottomLeft: Radius.circular(isMe ? 12 : 0),
                                    bottomRight: Radius.circular(isMe ? 0 : 12),
                                  ),
                                ),
                                child: Text(
                                  msg['message'],
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black87,
                                    fontSize: 15,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                msg['datetime'],
                                style: TextStyle(color: textGrey, fontSize: 11),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),

            // ÁREA DE INPUT (Dentro do cartão branco)
            SafeArea(
              top: false, // Não precisa de safe area no topo dentro do cartão
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ), // Espaçamento interno para não colar nas bordas do cartão
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Digite sua mensagem...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: petroleo,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
