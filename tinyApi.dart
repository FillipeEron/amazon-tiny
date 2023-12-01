import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TinyApi {
  static const String token = '3bafd53e2da95f4bd72afb6874d0e563f90b54bf';
  static const String formato = 'json';
  final String _idPedido;
  String? _idCodePedido;

  TinyApi(this._idPedido);

  set idCodePedido(idCode) => this._idCodePedido = idCode;

  String get idPedido => this._idPedido;

  void printIdCode() {
    print(this._idCodePedido);
  }

  void printId() {
    print(this._idPedido);
  }

  static Future<String> getClientName(idPedido) async {
    try {
      var url = Uri.parse('https://api.tiny.com.br/api2/pedidos.pesquisa.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'numero': idPedido,
      });

      var response = await http.post(url);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedidos'][0]['pedido']['nome'];
    } catch (e) {
      throw 'falha no retorno da api';
    }
  }

  static Future<String> getIdCode(idPedido) async {
    try {
      var url = Uri.parse('https://api.tiny.com.br/api2/pedidos.pesquisa.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'numero': idPedido,
      });

      var response = await http.post(url);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedidos'][0]['pedido']['id'];
    } catch (e) {
      throw 'falha no retorno da api';
    }
  }

  Future<List<dynamic>> getAllProducts() async {
    try {
      var newUrl = Uri.parse('https://api.tiny.com.br/api2/pedido.obter.php')
          .replace(queryParameters: {
        'token': token,
        'formato': formato,
        'id': this._idCodePedido,
      });

      var response = await http.post(newUrl);
      var data = convert.jsonDecode(response.body);
      return data['retorno']['pedido']['itens'];
    } catch (e) {
      throw 'Get all products fail';
    }
  }
}
