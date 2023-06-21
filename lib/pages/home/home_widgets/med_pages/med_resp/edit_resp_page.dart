import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../shared/values/custom_colors.dart';

class TelaEditarCadastroResp extends StatefulWidget {
  @override
  State<TelaEditarCadastroResp> createState() => _TelaEditarCadastroRespState();
}

class _TelaEditarCadastroRespState extends State<TelaEditarCadastroResp> {
  var txtNome = TextEditingController();
  var txtHora = TextEditingController();
  var txtObs = TextEditingController();
  var txtQtd = TextEditingController();
  var txtDosagem = TextEditingController();
  var checkTipo = TextEditingController();

  void getDocumentById(String id) async {
    await FirebaseFirestore.instance
        .collection('remedioResp')
        .doc(id)
        .get()
        .then((value) {
      txtNome.text = value.data()!['nome'];
      txtHora.text = value.data()!['hora'];
      txtObs.text = value.data()!['obs'];
      txtQtd.text = value.data()!['qtd'];
      txtDosagem.text = value.data()!['dosagem'];
    });
  }

  final List<String> tipos = [
    'Comprimido',
    'Gotas',
    'Inalatório',
    'Injetável',
  ];

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text == '' &&
          txtHora.text == '' &&
          txtObs.text == '' &&
          txtQtd.text == '' &&
          txtDosagem.text == '') {
        getDocumentById(id.toString());
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar medicamento"),
        centerTitle: true,
        backgroundColor: const Color(0xff0A6D92),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientMainColor(),
              CustomColors().getGradientSecColor(),
            ],
          ),
        ),
        child: ListView(
          children: [
            TextField(
              controller: txtNome,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Selecione o tipo da medicação',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtDosagem,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Dosagem',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtQtd,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Quantidade disponível',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtHora,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Horário',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtObs,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Remédio(s) complementar(es)',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          CustomColors().getActivePrimaryButtonColor(),
                      fixedSize: const Size.fromWidth(310),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      var db = FirebaseFirestore.instance;

                      if (id == null) {
                        db.collection('remedioResp').add({
                          "nome": txtNome.text,
                          "dosagem": txtDosagem.text,
                          "hora": txtHora.text,
                          "qtd": txtQtd.text,
                          "obs": txtObs.text,
                        });
                      } else {
                        db.collection('remedioResp').doc(id.toString()).update({
                          "nome": txtNome.text,
                          "dosagem": txtDosagem.text,
                          "hora": txtHora.text,
                          "qtd": txtQtd.text,
                          "obs": txtObs.text,
                        });
                      }
                      Navigator.pop(context, '/principal');
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          CustomColors().getActivePrimaryButtonColor(),
                      fixedSize: const Size.fromWidth(310),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context, '/principal');
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
