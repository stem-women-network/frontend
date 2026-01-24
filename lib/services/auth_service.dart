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
    required String areasAtuacao,
    required String comoFicouSabendo,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/signup-mentor');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          "email": email,
          "senha": password,
          "nome_completo": name,
          "cpf": cpf,
          "celular": phone,
          "data_nascimento": birthDate,
          "linkedin": linkedin,
          "formacao": formacao,
          "cargo_atual": cargoAtual,
          "areas_atuacao": areasAtuacao,
          "como_ficou_sabendo": comoFicouSabendo,
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
    required String expectations,
    required String experiences,
    required String skills,
    required bool wasMentee,
    required String hobbies,
    required String comments,
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
          "curso": course,
          "ano_curso": year,
          "semestre": semester,
          "genero": gender,
          "etnia": race,
          "expectativas": expectations,
          "compartilhar_experiencias": experiences,
          "desenvolver_competencias": skills,
          "foi_mentorada": wasMentee,
          "hobbies_interesses": hobbies,
          "comentarios": comments,
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
