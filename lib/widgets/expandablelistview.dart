import 'package:flutter/material.dart';

class ExpandableListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
      itemCount: data.length,
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Heading 1',
    <Entry>[
      Entry(
        'Sub Heading 1',
        <Entry>[
          Entry('Row 1'),
          Entry('Row 2'),
          Entry('Row 3'),
        ],
      ),
      Entry('Sub Heading 2'),
      Entry('Sub Heading 3'),
    ],
  ),
  Entry(
    'Heading 2',
    <Entry>[
      Entry('Sub Heading 1'),
      Entry('Sub Heading 2'),
    ],
  ),
  Entry(
    'Heading 3',
    <Entry>[
      Entry('Sub Heading 1'),
      Entry('Sub Heading 2'),
      Entry(
        'Sub Heading 3',
        <Entry>[
          Entry('Row 1'),
          Entry('Row 2'),
          Entry('Row 3'),
          Entry('Row 4'),
        ],
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
