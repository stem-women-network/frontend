import 'package:flutter/material.dart';
import 'package:frontend/screens/home/mentor_registration_page.dart';
import 'package:frontend/screens/home/mentee_registration_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int selectedOption = 0; 
  final Color brandColor = const Color(0xFF3E84A2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Como você deseja participar?",
                        style: TextStyle(
                          fontWeight: FontWeight.w800, 
                          fontSize: 24,
                          color: Color(0xFF2D3436),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Escolha o seu perfil para conectarmos você às melhores mentorias.",
                        style: TextStyle(color: Colors.black45, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      
                      Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildModernCard(
                            id: 1,
                            title: "Sou mentora",
                            description: "Quero orientar estudantes e compartilhar minha experiência STEM.",
                            cardColor: const Color(0xFFFE9F43),
                            icon: Icons.auto_awesome_outlined,
                          ),
                          _buildModernCard(
                            id: 2,
                            title: "Sou mentorada",
                            description: "Busco aprender com profissionais e desenvolver minha carreira.",
                            cardColor: const Color(0xFFEF4C56),
                            icon: Icons.rocket_launch_outlined,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 50),
                      
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 240,
                        height: 54,
                        child: FilledButton(
                          onPressed: selectedOption == 0 
                            ? null 
                            : () {
                                if (selectedOption == 1) {
                                  // Navega para Cadastro de Mentora
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MentorRegistrationPage(),
                                    ),
                                  );
                                } else if (selectedOption == 2) {
                                  // Navega para Cadastro de Mentorada
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MenteeRegistrationPage(),
                                    ),
                                  );
                                }
                              },
                          style: FilledButton.styleFrom(
                            backgroundColor: brandColor,
                            disabledBackgroundColor: Colors.grey.shade100,
                            elevation: selectedOption == 0 ? 0 : 8,
                            shadowColor: brandColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Continuar",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: selectedOption == 0 ? Colors.black26 : Colors.white,
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

  Widget _buildModernCard({
    required int id,
    required String title,
    required String description,
    required Color cardColor,
    required IconData icon,
  }) {
    bool isSelected = selectedOption == id;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = id),
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 320,
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected 
                  ? cardColor.withOpacity(0.6) 
                  : Colors.black.withOpacity(0.1),
                blurRadius: isSelected ? 20 : 10,
                offset: isSelected ? const Offset(0, 10) : const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 15),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9), 
                  fontSize: 13, 
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}