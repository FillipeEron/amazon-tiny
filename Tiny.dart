import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Tiny {
  static const String token = '3bafd53e2da95f4bd72afb6874d0e563f90b54bf';
  static const String formato = 'json';
  final String _requestCode;
  String? _id;
  String? _clientName;
  List<dynamic>? _allProducts;

  Tiny(this._requestCode);

  String get resquestCode => this._requestCode;

  String get id => this._id!;

  String get clientName => this._clientName!;

  List<dynamic> get allProducts => this._allProducts!;

  set id(String id) => this._id = id;

  set clientName(String clientName) => this._clientName = clientName;

  set allProducts(List<dynamic> allProducts) => this._allProducts = allProducts;

  Future<String> getIdfromAPI() async {
    try {
      var url = Uri.parse('https://api.tiny.com.br/api2/pedidos.pesquisa.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'numero': this._requestCode,
      });

      var response = await http.post(url);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedidos'][0]['pedido']['id'];
    } catch (e) {
      throw 'GET ID FAIL';
    }
  }

  Future<String> getClientNameFromAPI() async {
    try {
      var url = Uri.parse('https://api.tiny.com.br/api2/pedidos.pesquisa.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'numero': this._requestCode,
      });

      var response = await http.post(url);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedidos'][0]['pedido']['nome'];
    } catch (e) {
      throw 'GET CLIENT NAME FAIL';
    }
  }

  static Future<List<dynamic>> getAllProducts(String id) async {
    try {
      var newUrl = Uri.parse('https://api.tiny.com.br/api2/pedido.obter.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'id': id,
      });

      var response = await http.post(newUrl);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedido']['itens'];
    } catch (e) {
      throw 'GET ALL PRODUCTS FAIL';
    }
  }
}
