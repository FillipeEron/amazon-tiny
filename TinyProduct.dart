import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TinyProduct {
  static const String token = '3bafd53e2da95f4bd72afb6874d0e563f90b54bf';
  static const String formato = 'json';

  static Future<List<dynamic>> getProduct(String id) async {
    try {
      var newUrl = Uri.parse('https://api.tiny.com.br/api2/pedido.obter.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'id': id,
      });

      var response = await http.post(newUrl);
      var data = convert.jsonDecode(response.body);
      return data;
    } catch (e) {
      throw 'GETPRODUCTS FAIL';
    }
  }
}
