import 'Tiny.dart';
import 'tinyApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> main() async {
  const String token = '3bafd53e2da95f4bd72afb6874d0e563f90b54bf';
  const String formato = 'json';

  String id = '810437368';

  try {
    var newUrl = Uri.parse('https://api.tiny.com.br/api2/produto.obter.php')
        .replace(queryParameters: {
      'token': token,
      'formato': formato,
      'id': id,
    });

    var response = await http.post(newUrl);
    var data = convert.jsonDecode(response.body);
    print(data);
  } catch (e) {
    throw 'GETPRODUCTS FAIL';
  }

  try {
    var newUrl = Uri.parse('https://api.tiny.com.br/api2/produto.obter.tags')
        .replace(queryParameters: {
      'token': token,
      'formato': formato,
      'id': id,
    });

    var response = await http.post(newUrl);
    var data = convert.jsonDecode(response.body);
    print(data);
  } catch (e) {
    throw 'GETPRODUCTS FAIL';
  }

  try {
    var newUrl =
        Uri.parse('https://api.tiny.com.br/api2/produto.obter.estoque.php')
            .replace(queryParameters: {
      'token': token,
      'formato': formato,
      'id': id,
    });

    var response = await http.post(newUrl);
    var data = convert.jsonDecode(response.body);
    print(data);
  } catch (e) {
    throw 'GETPRODUCTS FAIL';
  }
}
