import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class MatchService {
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  Future<dynamic> getMatches({required String token}) async {
    final url = Uri.parse('$_baseUrl/match/pedidos/');
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
      return null;
    }
  }

  Future<dynamic> generateMatches({required String token}) async {
    final url = Uri.parse('$_baseUrl/match/');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String?>{}),
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
      return null;
    }
  }

  Future<dynamic> updateMatch({
    required String token,
    required String estadoMatch,
    required String idPedido,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/match/pedidos/$idPedido?estado_match=$estadoMatch',
    );
    try {
      final response = await http.put(
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
      return null;
    }
  }
}
