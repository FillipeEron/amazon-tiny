import 'dart:ffi';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart';

import 'TinyProduct.dart';

Future<void> main() async {
  String id = '811346194';
  var data = await TinyProduct.getProduct(id);
  print(data);
  /*
  String file = './produtos_2023-12-23-19-24-10.xlsx';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  var key = excel.tables.keys.first;
  if (excel.tables[key]?.rows != null) {
    List<Product> products = excel.tables[key]!.rows.map((row) {
      Product product = Product(
        id: row.elementAt(CollumnsMap.id.position)!.value.toString(),
        codigo: row.elementAt(CollumnsMap.codigo.position)!.value.toString(),
        descricao:
            row.elementAt(CollumnsMap.descricao.position)!.value.toString(),
        unidade: row.elementAt(CollumnsMap.unidade.position)!.value.toString(),
        situacao:
            row.elementAt(CollumnsMap.situacao.position)!.value.toString(),
        tipoProduto:
            row.elementAt(CollumnsMap.tipoProduto.position)!.value.toString(),
      );
      return product;
    }).toList();

    List<Product> stock = products
        .where(
            (product) => product.tipoProduto == TypeProduct.materiaPrima.type)
        .toList();
    print(stock[0].tipoProduto);
    print(stock[1].tipoProduto);
    print(stock[2].tipoProduto);
  } else {
    print('fail search cell');
  }
  */
}

class Product {
  final String id;
  final String codigo;
  final String descricao;
  final String unidade;
  final String situacao;
  final String tipoProduto;

  Product(
      {required this.id,
      required this.codigo,
      required this.descricao,
      required this.unidade,
      required this.situacao,
      required this.tipoProduto});
}

enum CollumnsMap {
  id,
  codigo,
  descricao,
  unidade,
  situacao,
  tipoProduto;

  int get position {
    switch (this) {
      case CollumnsMap.id:
        return 0;
      case CollumnsMap.codigo:
        return 1;
      case CollumnsMap.descricao:
        return 2;
      case CollumnsMap.unidade:
        return 3;
      case CollumnsMap.situacao:
        return 9;
      case CollumnsMap.tipoProduto:
        return 29;
    }
  }
}

enum TypeProduct {
  simples,
  materiaPrima;

  String get type {
    switch (this) {
      case TypeProduct.simples:
        return 'S';
      case TypeProduct.materiaPrima:
        return 'M';
    }
  }
}
