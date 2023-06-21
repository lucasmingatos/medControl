import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/models/class_diabetes/remed_diabetes.dart';
import '../../../../../shared/values/custom_colors.dart';

class DiabetesPage extends StatefulWidget {
  final String uid;
  const DiabetesPage({required this.uid});

  @override
  State<DiabetesPage> createState() => _DiabetesPageState();
}

class _DiabetesPageState extends State<DiabetesPage> {
  late CollectionReference remedios;

  @override
  void initState() {
    super.initState();
    remedios = FirebaseFirestore.instance.collection('remedioDiabetes');
  }

  Widget itemLista(item) {
    RemedioDiabetes remedioDiabetes =
        RemedioDiabetes.fromJson(item.data(), item.id);
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 15, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue[50],
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.blue[100],
        leading: Image.network(
          remedioDiabetes.url,
          height: 50,
          width: 50,
        ),
        title: Text(
          remedioDiabetes.nome,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.lightBlue,
          ),
        ),
        subtitle: Text(
          '\nDosagem: ${remedioDiabetes.dosagem}'
          '\n\nTipo: ${remedioDiabetes.tipo}'
          '\n\nHorário: ${remedioDiabetes.hora}'
          '\n\nQuantidade disponível: ${remedioDiabetes.qtd}'
          '\n\nRemédio(s) conjulgado(s): ${remedioDiabetes.obs}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_rounded,
            color: Colors.red,
          ),
          onPressed: () {
            //função de deletar
            remedios.doc(remedioDiabetes.id).delete();
          },
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/editarRemedioDiabetes',
            arguments: remedioDiabetes.id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicações"),
        centerTitle: true,
        backgroundColor: const Color(0xff0A6D92),
      ),
      body: Container(
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
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: remedios.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('Erro ao conectar no Firebase'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                  itemCount: dados.size,
                  itemBuilder: (context, index) {
                    return itemLista(
                      dados.docs[index],
                    );
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: CustomColors().getGradientMainColor(),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/cadastrarRemedioDiabetes');
        },
      ),
    );
  }
}
