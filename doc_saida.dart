import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'Tiny.dart';

void main(List<String> arg) async {
  try {
    var tiny = Tiny(arg[0]);
    tiny.id = await tiny.getIdfromAPI();
    tiny.clientName = await tiny.getClientNameFromAPI();
    tiny.allProducts = await Tiny.getAllProducts(tiny.id);

    // GET ALL PRODUCTS FROM TINY'S API;

    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      build: (context) => [
        contentTableHeader(context, tiny),
        contentTableProducts(context, tiny),
        padding(top: 10, bottom: 10),
        contentText(),
        signature(),
        padding(top: 10, bottom: 10),
        contentObservation(),
      ],
    ));

    final file = File('DS-PV${arg[0]}.pdf');
    file.writeAsBytes(await pdf.save());
  } catch (e) {
    throw 'Erro ao acessar a api do tiny';
  }
}

// module functions pdf

pw.Widget contentTableHeader(pw.Context context, Tiny tiny) {
  var companyNameStyle = pw.TextStyle(
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  var headerStyle = pw.TextStyle(fontSize: 8);

  List<pw.Widget> companydata = [
    pw.Text('F P MATOS FABRICACAO DE ARTEFATOS E SERVICOS DE MADEIRA EIRELI',
        style: companyNameStyle),
    pw.Text('31.173.353/0001-17', style: headerStyle),
    pw.Text('Rua Distrito Industrial, S/N', style: headerStyle),
    pw.Text('67.035-330', style: headerStyle),
  ];

  final logo = pw.MemoryImage(
    File('assets/LOGO_AMAZON_SEM_FUNDO.png').readAsBytesSync(),
  );

  return pw.Column(children: [
    pw.Container(
        padding: pw.EdgeInsets.only(bottom: 30),
        child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
          pw.Container(
            padding: pw.EdgeInsets.only(right: 40),
            child: pw.Image(logo, width: 150, height: 100),
          ),
          pw.Container(
            child: pw.Wrap(
                direction: pw.Axis.vertical,
                alignment: pw.WrapAlignment.start,
                spacing: 2,
                runAlignment: pw.WrapAlignment.start,
                runSpacing: 50,
                crossAxisAlignment: pw.WrapCrossAlignment.end,
                verticalDirection: pw.VerticalDirection.down,
                children: companydata),
          ),
        ])),
    pw.Container(
        padding: pw.EdgeInsets.only(bottom: 20),
        child: pw.Center(
            child: pw.Text('Pedido de Venda Nº ' + tiny.resquestCode))),
    pw.Container(
      padding: pw.EdgeInsets.only(bottom: 20),
      child: pw.TableHelper.fromTextArray(
        data: [
          ['Cliente', tiny.clientName],
          ['Vendedor', 'Fillipe Eron Fortes Matos'],
        ],
        headerCount: 0,
      ),
    )
  ]);
}

pw.Widget contentTableProducts(pw.Context context, Tiny tiny) {
  List<dynamic> allProducts = tiny.allProducts;

  List<List<String>> contenTable = [
    <String>['ITEM', 'CÓDIGO', 'UN', 'QUANT TOTAL', 'QUANT ENTREGUE']
  ];

  contenTable.insertAll(
      1,
      allProducts.map((item) {
        List<String> subList = [];
        String descricao = item['item']['info_adicional'] != null
            ? item['item']['descricao'] + ' - ' + item['item']['info_adicional']
            : item['item']['descricao'];
        subList.add(descricao);
        subList.add(item['item']['codigo']);
        subList.add(item['item']['unidade']);
        subList.add(item['item']['quantidade']);
        subList.add('');

        return subList;
      }).toList());

  return pw.TableHelper.fromTextArray(
      columnWidths: <int, pw.TableColumnWidth>{
        0: pw.FixedColumnWidth(30),
        1: pw.FixedColumnWidth(8),
        2: pw.FixedColumnWidth(3),
        3: pw.FixedColumnWidth(7),
        4: pw.FixedColumnWidth(8),
      },
      data: contenTable,
      context: context,
      headerAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      });
}

pw.Widget contentText() {
  return pw.Column(children: [
    pw.Container(
      padding: pw.EdgeInsets.only(bottom: 50),
      child: pw.Text(
          'Declaro que recebi da empresa F P Matos Fabricação de Artefatos e Serviços de Madeira Eireli, os itens identificadas neste documento de saída em perfeito estado e nas quantidades informadas.',
          textAlign: pw.TextAlign.justify),
    ),
  ]);
}

pw.Widget contentObservation() {
  return pw.Column(children: [
    pw.Container(
      alignment: pw.Alignment.topLeft,
      padding: pw.EdgeInsets.only(bottom: 70),
      child: pw.Text(' Observação:', textAlign: pw.TextAlign.justify),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      width: 700,
    ),
  ]);
}

pw.Widget signature() {
  return pw.Column(children: [
    pw.Container(
      child: pw.Column(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.only(bottom: 25),
            child: pw.Row(
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.only(right: 25),
                  child: pw.Wrap(
                    direction: pw.Axis.vertical,
                    crossAxisAlignment: pw.WrapCrossAlignment.center,
                    children: [
                      pw.Text('__________________________________'),
                      pw.Text('Assinatura do Responsável da Expedição',
                          style: pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                pw.Container(
                  child: pw.Wrap(
                      direction: pw.Axis.vertical,
                      crossAxisAlignment: pw.WrapCrossAlignment.center,
                      children: [
                        pw.Text('__________________________________'),
                        pw.Text('Assinatura do Recebedor',
                            style: pw.TextStyle(fontSize: 10)),
                      ]),
                ),
              ],
            ),
          ),
          pw.Container(
            child: pw.Center(
              child: pw.Wrap(
                  direction: pw.Axis.vertical,
                  crossAxisAlignment: pw.WrapCrossAlignment.center,
                  children: [
                    pw.Text('_____/_____/_____'),
                    pw.Text('Data de Recebimento',
                        style: pw.TextStyle(fontSize: 10)),
                  ]),
            ),
          ),
        ],
      ),
    ),
  ]);
}

pw.Widget padding(
    {double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double top = 0.0}) {
  return pw.Padding(
      padding: pw.EdgeInsets.only(
          left: left, right: right, bottom: bottom, top: top));
}
