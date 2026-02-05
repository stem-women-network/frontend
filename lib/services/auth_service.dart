import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthService {
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{"email": email, "senha": password}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          final user = responseBody['user'];
          final token = responseBody['token'];
          final name = user["nome_completo"];
          final userType = user["tipo_usuario"];

          return {"token": token, "name": name, "userType": userType};
        } catch (e) {
          print(e);
          return {
            "message": "Algo deu errado",
          };
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return {"error": true, "message": errorMessage};
        } catch (_) {
          return {
            "error": true,
            "message": "Erro no servidor. Status: ${response.statusCode}.",
          };
        }
      }
    } on SocketException {
      return {
        "error": true,
        "message":
            "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
      };
    } catch (e) {
      // Outros erros genéricos
      return {
        "error": true,
        "message": "Erro inesperado durante a comunicação. ($e)",
      };
    }
  }

  Future<Map<String, dynamic>> registerMentor({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String phone,
    required String birthDate,
    String? linkedin,
    required String formacao,
    required String cargoAtual,
    required String areaAtuacao,
    required String city,
    required String state,
    required String race,
    required String gender,
    required bool wasMentor,
    required bool wasMentee,
    required String menteeProfile,
    required List<String> mentoringGoal,
    required List<String> languages,
    required List<String> skills,
    required List<String> hobbies,
    required String availability,
    required String help,
    required String bio
  }) async {
    final url = Uri.parse('$_baseUrl/auth/signup-mentor');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object?>{
          "email": email,
          "senha": password,
          "nome_completo": name,
          "cpf": cpf,
          "celular": phone,
          "data_nascimento": birthDate,
          "genero" : gender,
          "linkedin": linkedin,
          "formacao": formacao,
          "cargo_atual": cargoAtual,
          "area_atuacao": areaAtuacao,
          "cidade": city,
          "estado": state,
          "etnia" : race,
          "foi_mentora" : wasMentor,
          "foi_mentorada" : wasMentee,
          "perfil_interesse" : menteeProfile,
          "foco_mentoria" : mentoringGoal,
          "idiomas" : languages,
          "competencias" : skills,
          "hobbies" : hobbies,
          "disponibilidade" : availability,
          "ajuda" : help,
          "bio" : bio
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          final message = responseBody['message'] ?? "Registro bem-sucedido!";

          return {"success": true, "message": message};
        } catch (_) {
          return {
            "success": true,
            "message": "Registro concluído com sucesso.",
          };
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['message'] ??
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return {"error": true, "message": errorMessage};
        } catch (_) {
          return {
            "error": true,
            "message": "Erro no servidor. Status: ${response.statusCode}.",
          };
        }
      }
    } on SocketException {
      return {
        "error": true,
        "message":
            "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
      };
    } catch (e) {
      // Outros erros genéricos
      return {
        "error": true,
        "message": "Erro inesperado durante a comunicação. ($e)",
      };
    }
  }

  Future<Map<String, dynamic>> registerMentee({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String phone,
    required String birthDate,
    String? linkedin,
    required String course,
    required int year,
    required int semester,
    required String gender,
    required String race,
    required String university,
    required String stemArea,
    required String currentSituation,
    required String mentoringGoal,
    required List<String> skills,
    required List<String> hobbies,
    required List<String> languages,
    required String availability
  }) async {
    final url = Uri.parse('$_baseUrl/auth/signup-mentee');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object?>{
          "email": email,
          "senha": password,
          "nome_completo": name,
          "cpf": cpf,
          "celular": phone,
          "data_nascimento": birthDate,
          "linkedin": linkedin,
          "genero": gender,
          "etnia": race,
          "universidade_instituicao" : university,
          "area_stem" : stemArea,
          "curso": course,
          "ano_curso": year,
          "semestre": semester,
          "situacao_atual" : currentSituation,
          "foco_mentoria" : mentoringGoal,
          "idiomas" : languages,
          "desenvolver_competencias": skills,
          "hobbies_interesses": hobbies,
          "disponibilidade" : availability
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          final message = responseBody['message'] ?? "Registro bem-sucedido!";

          return {"success": true, "message": message};
        } catch (_) {
          return {
            "success": true,
            "message": "Registro concluído com sucesso.",
          };
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['message'] ??
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return {"error": true, "message": errorMessage};
        } catch (_) {
          return {
            "error": true,
            "message": "Erro no servidor. Status: ${response.statusCode}.",
          };
        }
      }
    } on SocketException {
      return {
        "error": true,
        "message":
            "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
      };
    } catch (e) {
      // Outros erros genéricos
      return {
        "error": true,
        "message": "Erro inesperado durante a comunicação. ($e)",
      };
    }
  }
}
