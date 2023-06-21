import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/values/custom_colors.dart';

class TelaCadastroCard extends StatefulWidget {
  @override
  State<TelaCadastroCard> createState() => _TelaCadastroCardState();
}

class _TelaCadastroCardState extends State<TelaCadastroCard> {
  var txtNome = TextEditingController();
  var txtHora = TextEditingController();
  var txtObs = TextEditingController();
  var txtQtd = TextEditingController();
  var txtDosagem = TextEditingController();
  var checkTipo = TextEditingController();
  var url =
      'https://cdn.icon-icons.com/icons2/734/PNG/512/pills-3_icon-icons.com_63042.png';
  var selecioneTipo = 'Comprimido';

  //imagem
  XFile? imagem;
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;
  //referencias dos arquivos do storage

  Future<String?> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Crie uma referência única para a imagem no Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          //salvando a imagem na pasta images
          .child('images/${DateTime.now().toString()}');

      // Faça o upload da imagem para o Firebase Storage
      final uploadTask = ref.putFile(File(pickedFile.path));
      final snapshot = await uploadTask.whenComplete(() => null);

      // Recupere a URL da imagem no Firebase Storage
      final urlImagem = await snapshot.ref.getDownloadURL();
      return urlImagem;
    }
  }

  void getDocumentById(String id) async {
    await FirebaseFirestore.instance
        .collection('remedioCard')
        .doc(id)
        .get()
        .then((value) {
      txtNome.text = value.data()!['nome'];
      txtHora.text = value.data()!['hora'];
      txtObs.text = value.data()!['obs'];
      txtQtd.text = value.data()!['qtd'];
      txtDosagem.text = value.data()!['dosagem'];
      selecioneTipo = value.data()!['tipo'];
      url = value.data()!['url'];
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
          txtDosagem.text == '' &&
          url == '' &&
          selecioneTipo == '') {
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
            DropdownButton(
              dropdownColor: CustomColors().getAppBarMainColor(),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              iconSize: 30,
              iconEnabledColor: CustomColors().getAppBarMainColor(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              underline: Container(
                height: 1,
                color: Colors.blue[200],
              ),
              isExpanded: true,
              value: selecioneTipo,
              onChanged: (newValue) {
                setState(() {
                  selecioneTipo = newValue!;
                });
              },
              items: tipos.map((state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
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
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.attach_file,
                color: Colors.white,
              ),
              title: const Text(
                'Adicionar imagem',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                url = (await _uploadImage())!;
                setState(() {
                  url = url!;
                });
              },
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
                        db.collection('remedioCard').add({
                          "nome": txtNome.text,
                          "dosagem": txtDosagem.text,
                          "tipo": selecioneTipo,
                          "hora": txtHora.text,
                          "qtd": txtQtd.text,
                          "obs": txtObs.text,
                          "url": url,
                        });
                      } else {
                        db.collection('remedioCard').doc(id.toString()).update({
                          "nome": txtNome.text,
                          "dosagem": txtDosagem.text,
                          "tipo": selecioneTipo,
                          "hora": txtHora.text,
                          "qtd": txtQtd.text,
                          "obs": txtObs.text,
                          "url": url,
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
