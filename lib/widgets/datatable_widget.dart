import 'package:flutter/material.dart';

class TablaGrandi3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        horizontalMargin: 10.0,
        columnSpacing: 30.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Vencimiento',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Fecha pago',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Nro cuotas',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'A pagar',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Pagado',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Saldo',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('15-9-20')),
              DataCell(Text('20-9-20')),
              DataCell(Text('1')),
              DataCell(Text('\$ 7000000')),
              DataCell(Text('\$ 7000000')),
              DataCell(Text('\$ 14000')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('10-10-20')),
              DataCell(Text('3-10-20')),
              DataCell(Text('3')),
              DataCell(Text('\$ 7000000')),
              DataCell(Text('\$ 7000000')),
              DataCell(Text('\$ 14000000')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('10-11')),
              DataCell(Text(' ')),
              DataCell(Text('3')),
              DataCell(Text('\$ 7000000')),
              DataCell(Text(' ')),
              DataCell(Text('\$ - ')),
            ],
          ),
        ],
      ),
    );
  }
}
