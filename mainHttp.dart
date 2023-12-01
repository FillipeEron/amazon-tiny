import 'Tiny.dart';
import 'tinyApi.dart';

Future<void> main() async {
  var tiny = Tiny('183');
  tiny.id = await tiny.getIdfromAPI();
  tiny.clientName = await tiny.getClientNameFromAPI();
  tiny.allProducts = await Tiny.getAllProducts(tiny.id);
  print(tiny.id);
  print(tiny.clientName);
  print(tiny.allProducts);
  //var teste = tiny.resquestCode;
  //print(await tiny.clientName);
  //print(await Tiny.getAllProducts(await tiny.id));

  //await tiny.uploadInformation;
  //print(await tiny.id);
  //print(tiny.clietName);

  /*var tinyApi = TinyApi('183');
  tinyApi.idCodePedido = await TinyApi.getIdCode(tinyApi.idPedido);
  tinyApi.printIdCode();
  List<dynamic> itens = await tinyApi.getAllProducts();

  var itensEstruturados = itens.map((item) {
    List<String> subList = [];
    if (item['item']['info_adicional'] != null) {
      String descricao =
          item['item']['descricao'] + ' - ' + item['item']['info_adicional'];
      subList.add(descricao);
    }
    subList.add(item['item']['descricao']);
    //subList.add(item['item']['info_adicional']);
    subList.add(item['item']['codigo']);
    subList.add(item['item']['unidade']);
    subList.add(item['item']['quantidade']);

    return subList;
  }).toList();
  print(itensEstruturados.runtimeType);*/
}
