import 'dart:convert';
import 'dart:typed_data';
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
          return [
            {"message": "Algo deu errado"},
          ];
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return [
            {"error": true, "message": errorMessage},
          ];
        } catch (_) {
          return [
            {
              "error": true,
              "message": "Erro no servidor. Status: ${response.statusCode}.",
            },
          ];
        }
      }
    } on SocketException {
      return [
        {
          "error": true,
          "message":
              "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
        },
      ];
    } catch (e) {
      // Outros erros genéricos
      return [
        {
          "error": true,
          "message": "Erro inesperado durante a comunicação. ($e)",
        },
      ];
    }
  }

  Future<void> sendFile({
    required String token,
    required String title,
    required Uint8List file,
    required String fileType,
    required String menteeId,
  }) async {
    final url = Uri.parse('$_baseUrl/mentoring/send-file');
    final request = http.MultipartRequest("POST", url);
    request.headers["authorization"] = "Bearer $token";
    request.fields["file"] = base64Encode(file);
    request.fields["title"] = title;
    request.fields["file_type"] = fileType;
    request.fields["mentee_id"] = menteeId;
    try {
      var response = await request.send();
      if (response.statusCode == 200)
        print('O arquivo foi enviado com sucesso');
    } catch (e) {
      print("Houve um erro ao enviar");
    }
  }

  Future<List<dynamic>> getFiles({
    required String token,
    required String menteeId,
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/mentoring/get-files?mentee_id=$menteeId',
      );
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
          return responseBody;
        } catch (e) {
          print(e);
          return [
            {"message": "Algo deu errado"},
          ];
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return [
            {"error": true, "message": errorMessage},
          ];
        } catch (_) {
          return [
            {
              "error": true,
              "message": "Erro no servidor. Status: ${response.statusCode}.",
            },
          ];
        }
      }
    } on SocketException {
      return [
        {
          "error": true,
          "message":
              "Erro de conexão: Não foi possível alcançar o servidor em $_baseUrl.",
        },
      ];
    } catch (e) {
      // Outros erros genéricos
      return [
        {
          "error": true,
          "message": "Erro inesperado durante a comunicação. ($e)",
        },
      ];
    }
  }
  
  Future<Map<String,dynamic>?> downloadFile({
    required String token,
    required String fileId,
  }) async {
    final url = Uri.parse('$_baseUrl/mentoring/download-file/?file_id=$fileId');
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
          return {
            "file" : base64Decode(responseBody["file"]),
            "type" : responseBody["type"]
          };
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return null;
        } catch (_) {
          return null;
        }
      }
    } on SocketException {
      return null;
    } catch (e) {
      // Outros erros genéricos
      return null;
    }
  }

  Future deleteFile({required String token, required String fileId}) async {
    final url = Uri.parse('$_baseUrl/mentoring/delete-file/$fileId');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final responseBody = jsonDecode(response.body);
          return responseBody;
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['detail'] ??
              'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
          return null;
        } catch (_) {
          return null;
        }
      }
    } on SocketException {
      return null;
    } catch (e) {
      // Outros erros genéricos
      return null;
    }
  }
}
