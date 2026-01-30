import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class MentoringService {
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );
  Future<List<dynamic>> getMessages({
    required String token,
    required String otherId,
  }) async {
    final url = Uri.parse('$_baseUrl/mentoring/get-messages');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{'other_id': otherId}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          return responseBody;
        } catch (e) {
          print(e);
          return [{"message": "Algo deu errado"}];
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return [{"error": true, "message": errorMessage}];
        } catch (_) {
          return [{
            "error": true,
            "message": "Erro no servidor. Status: ${response.statusCode}.",
          }];
        }
      }
    } on SocketException {
      return [{
        "error": true,
        "message":
            "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
      }];
    } catch (e) {
      // Outros erros genéricos
      return [{
        "error": true,
        "message": "Erro inesperado durante a comunicação. ($e)",
      }];
    }
  }
}
