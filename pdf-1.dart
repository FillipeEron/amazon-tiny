// https://dev.to/friendlyuser/resume-generation-in-dart-4i53
// https://www.geeksforgeeks.org/flutter-simple-pdf-generating-app/
// https://pub.dev/documentation/pdf/latest/widgets/widgets-library.html
// https://davbfr.github.io/dart_pdf/#/
import 'dart:io';

//import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'tinyApi.dart';

void main() async {
  var tinyApi = TinyApi('183'); // pedido 185 deu certo e o pedido 183 errado;
  tinyApi.idCodePedido = await TinyApi.getIdCode(tinyApi.idPedido);
  tinyApi.printIdCode();
  List<dynamic> itens = await tinyApi.getAllProducts();
  List<String> tableHeader = <String>[
    'Item',
    'Código',
    'Un',
    'Qnt Total',
    'Qnt Entregue'
  ];

  List<List<String>> dados = itens.map((item) {
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
  }).toList();

  dados.insert(0, tableHeader);

  final pdf = pw.Document();

  var headerStyleFirstLine = pw.TextStyle(
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  var headerStyleOtherLine = pw.TextStyle(fontSize: 8);

  List<pw.Widget> companydata = [
    pw.Text('F P MATOS FABRICACAO DE ARTEFATOS E SERVICOS DE MADEIRA EIRELI',
        style: headerStyleFirstLine),
    pw.Text('31.173.353/0001-17', style: headerStyleOtherLine),
    pw.Text('Rua Distrito Industrial, S/N', style: headerStyleOtherLine),
    pw.Text('67.035-330', style: headerStyleOtherLine),
  ];

  final image = pw.MemoryImage(
    File('assets/LOGO_AMAZON_SEM_FUNDO.png').readAsBytesSync(),
  );

  pdf.addPage(pw.MultiPage(
    //margin: pw.EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    build: (context) {
      return [
        pw.Column(
          children: [
            pw.Container(
                padding: pw.EdgeInsets.only(bottom: 30),
                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.only(right: 40),
                        child: pw.Image(image, width: 150, height: 100),
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
                child: pw.Center(child: pw.Text('Pedido de Venda Nº XX'))),
            pw.Container(
              padding: pw.EdgeInsets.only(bottom: 20),
              child: pw.TableHelper.fromTextArray(
                data: [
                  ['Cliente', 'Exemplo'],
                  ['Vendedor', 'Fillipe Eron Fortes Matos'],
                ],
                headerCount: 0,
              ),
            ),
            pw.Container(
              padding: pw.EdgeInsets.only(bottom: 20),
              child: pw.TableHelper.fromTextArray(
                columnWidths: <int, pw.TableColumnWidth>{
                  0: pw.FixedColumnWidth(30),
                  1: pw.FixedColumnWidth(8),
                  2: pw.FixedColumnWidth(9),
                  3: pw.FixedColumnWidth(5),
                  4: pw.FixedColumnWidth(8),
                },
                data: dados,
                context: context,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: pw.EdgeInsets.only(bottom: 50),
              child: pw.Text(
                  'Declaro que recebi da empresa F P Matos Fabricação de Artefatos e Serviços de Madeira Eireli, as mercadorias identificadas neste documento em perfeito estado e nas quantidades informadas.',
                  textAlign: pw.TextAlign.justify),
            ),
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
          ],
        ),
      ];
    },
  ));

  /*pdf.addPage(pw.MultiPage(
    build: (context) {
      return [
        pw.Column(
          children: [
            pw.Container(
                child: pw.Row(children: [
              pw.Column(
                children: [pw.Image(image, width: 150, height: 100)],
              ),
              pw.Column(mainAxisSize: pw.MainAxisSize.min, children: [
                pw.Wrap(
                    direction: pw.Axis.vertical,
                    alignment: pw.WrapAlignment.start,
                    spacing: 2,
                    runAlignment: pw.WrapAlignment.start,
                    runSpacing: 50,
                    crossAxisAlignment: pw.WrapCrossAlignment.end,
                    verticalDirection: pw.VerticalDirection.down,
                    children: companydata),
              ]),
            ])),
          ],
        ),
      ];
    },
  ));*/

  /*pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
      child: pw.Image(image),
    ); // Center
  }));*/

  final file = File('example-1.pdf');
  file.writeAsBytes(await pdf.save());
}
