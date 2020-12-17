//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Filtro extends StatelessWidget {
  var filtro;
  Filtro({Key key, @required this.filtro}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Buscar por ' + filtro),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
        tooltip: 'Voltar',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Column _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            // ignore: deprecated_member_use
            stream: Firestore.instance
                .collection('pegueumgato')
                .orderBy('nome')
                .where('nome', isEqualTo: filtro)
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> pegueumgato = snapshot.data.documents;
                  return ListView.builder(
                    itemCount: pegueumgato.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            pegueumgato[index].data['foto'],
                          ),
                        ),
                        title: Text(pegueumgato[index].data['nome']),
                        subtitle: Text(pegueumgato[index].data['sexo']),
                        dense: true,
                      ));
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
