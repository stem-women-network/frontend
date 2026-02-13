import 'package:flutter/material.dart';
import 'manage_mentors_page.dart';
import 'manage_mentees_page.dart';
import 'manage_coordinators_page.dart';
import 'manage_admins_page.dart';

class UserManagementHubPage extends StatelessWidget {
  const UserManagementHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color brandColor = const Color(0xFF3E84A2);
    
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
          "Central de Usuários", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 2 : 1,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: MediaQuery.of(context).size.width > 700 ? 2.5 : 2.8,
                children: [
                  _buildNavCard(
                    context,
                    "Mentoras",
                    "Gerenciar perfis e status.",
                    Icons.school,
                    const Color(0xFFFE9F43),
                    const ManageMentorsPage(),
                  ),
                  _buildNavCard(
                    context,
                    "Mentoradas",
                    "Gerenciar alunas e progresso.",
                    Icons.person_outline,
                    const Color(0xFF43A047),
                    const ManageMenteesPage(),
                  ),
                  _buildNavCard(
                    context,
                    "Coordenadores",
                    "Gestão de representantes.",
                    Icons.business,
                    const Color(0xFF6C63FF),
                    const ManageCoordinatorsPage(),
                  ),
                  _buildNavCard(
                    context,
                    "Administradores",
                    "Controle de acesso.",
                    Icons.admin_panel_settings,
                    const Color(0xFFE4645B),
                    const ManageAdminsPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavCard(BuildContext context, String title, String subtitle, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 16),
          ],
        ),
      ),
    );
  }
}