import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AdminService {
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  Future getApprovals({required String token}) async {
    final url = Uri.parse('$_baseUrl/admin/get-approvals');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          print(responseBody);
          return responseBody;
        } catch (e) {
          print(e);
          return {"message": "Algo deu errado"};
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

  Future updateApproval({
      required String token,
      required String mentorId,
      required bool approved
  }) async {
    final url = Uri.parse('$_baseUrl/admin/update-approval');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, Object>{
            "mentor_id" : mentorId,
            "approved" : approved
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          print(responseBody);
          return responseBody;
        } catch (e) {
          print(e);
          return {"message": "Algo deu errado"};
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
  
  Future getApprovalsMentee({required String token}) async {
    final url = Uri.parse('$_baseUrl/admin/get-approvals-mentee');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          print(responseBody);
          return responseBody;
        } catch (e) {
          print(e);
          return {"message": "Algo deu errado"};
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
  Future updateApprovalMentee({
      required String token,
      required String menteeId,
      required bool approved
  }) async {
    final url = Uri.parse('$_baseUrl/admin/update-approval-mentee');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, Object>{
            "mentee_id" : menteeId,
            "approved" : approved
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          print(responseBody);
          return responseBody;
        } catch (e) {
          print(e);
          return {"message": "Algo deu errado"};
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
}
