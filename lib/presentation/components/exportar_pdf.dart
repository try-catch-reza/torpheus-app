import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:torpheus/data/models/indicador_ordem_servico_model.dart';

import '../../data/models/baldes_model.dart';
import '../../data/models/indicador_ordem_servico_periodo_model.dart';

Future<void> exportarPDF(
  IndicadorOrdemServicoPeriodoModel indicador,
  IndicadorOrdemServicoModel indicadorOS,
) async {
  final doc = pw.Document();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          pw.Text(
            'Relatório de OS',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Desempenho operacional da oficina',
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.SizedBox(height: 16),

          // Cards de totais
          pw.Row(children: [
            _pdfStatCard('OS Abertas', indicadorOS.ordensAbertas.toString()),
            _pdfStatCard(
                'Em andamento', indicadorOS.ordensAndamento.toString()),
            _pdfStatCard('Concluídas', indicadorOS.ordensConcluidas.toString()),
            _pdfStatCard('Canceladas', indicadorOS.ordensCanceladas.toString()),
          ]),

          pw.SizedBox(height: 24),

          // Tabela de buckets
          pw.Text(
            'OS por período',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          _pdfTabelaBuckets(indicador.baldes ?? []),
        ],
      ),
    ),
  );

  // Abre o diálogo de impressão/download nativo
  await Printing.layoutPdf(
    onLayout: (_) async => doc.save(),
  );
}

pw.Widget _pdfStatCard(String label, String valor) {
  return pw.Expanded(
    child: pw.Container(
      margin: const pw.EdgeInsets.only(right: 8),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label.toUpperCase(),
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            valor,
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

pw.Widget _pdfTabelaBuckets(List<BaldesModel> baldes) {
  final comDados = baldes.where((b) => (b.total ?? 0) > 0).toList();

  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.grey200),
    columnWidths: {
      0: const pw.FlexColumnWidth(2),
      1: const pw.FlexColumnWidth(1),
      2: const pw.FlexColumnWidth(1),
      3: const pw.FlexColumnWidth(1),
      4: const pw.FlexColumnWidth(1),
    },
    children: [
      // Header
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey100),
        children: ['Data', 'Total', 'Concluídas', 'Em andamento', 'Canceladas']
            .map(
              (h) => pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  h,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
      // Linhas
      ...comDados.map((b) {
        final data = b.data != null
            ? '${b.data!.day.toString().padLeft(2, '0')}/${b.data!.month.toString().padLeft(2, '0')}/${b.data!.year}'
            : '-';
        return pw.TableRow(
          children: [
            data,
            '${b.total ?? 0}',
            '${b.totalAbertos ?? 0}',
            '${b.emProgresso ?? 0}',
            '${b.cancelados ?? 0}',
          ]
              .map((v) => pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(v, style: const pw.TextStyle(fontSize: 10)),
                  ))
              .toList(),
        );
      }),
    ],
  );
}
