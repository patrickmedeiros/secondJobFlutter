import 'package:flutter/material.dart';

class FormExib extends StatelessWidget {
  // var value;
  // FormExib({Key key, @required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegue um gato'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
        tooltip: 'Voltar',
        child: const Icon(Icons.delete),
      ),
    );
  }

  Column _body() {}
}
