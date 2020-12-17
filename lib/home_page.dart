import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getACat/exibicao.dart';
import 'package:getACat/filtro.dart';
import 'package:getACat/form_expo.dart';

class HomePage extends StatelessWidget {
  var _edSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegue um gato'),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormExpo()),
          );
        },
        tooltip: 'Cadastro de gato',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Column _body(context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _edSearch,
                keyboardType: TextInputType.name,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Buscar',
                ),
              ),
            ),
            IconButton(
              color: Colors.blue,
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Filtro(filtro: _edSearch.text)),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('pegueumgato')
                .orderBy('nome')
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
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            pegueumgato[index].data['foto'],
                          ),
                        ),
                        title: Text(pegueumgato[index].data['nome']),
                        subtitle: Text(pegueumgato[index].data['sexo']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormExib()),
                          );
                        },
                      );
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
