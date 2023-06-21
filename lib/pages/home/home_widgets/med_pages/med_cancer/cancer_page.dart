import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/models/class_cancer/remed_cancer.dart';
import '../../../../../shared/values/custom_colors.dart';

class CancerPage extends StatefulWidget {
  final String uid;
  const CancerPage({required this.uid});

  @override
  State<CancerPage> createState() => _CancerPageState();
}

class _CancerPageState extends State<CancerPage> {
  late CollectionReference remedios;

  @override
  void initState() {
    super.initState();
    remedios = FirebaseFirestore.instance.collection('remedioCancer');
  }

  Widget itemLista(item) {
    RemedioCancer remedioCancer = RemedioCancer.fromJson(item.data(), item.id);
    
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
          remedioCancer.url,
          height: 50,
          width: 50,
        ),
        title: Text(
          remedioCancer.nome,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.lightBlue,
          ),
        ),
        subtitle: Text(
          '\nDosagem: ${remedioCancer.dosagem}'
          '\n\nTipo: ${remedioCancer.tipo}'
          '\n\nHorário: ${remedioCancer.hora}'
          '\n\nQuantidade disponível: ${remedioCancer.qtd}'
          '\n\nRemédio(s) conjulgado(s): ${remedioCancer.obs}',
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
            remedios.doc(remedioCancer.id).delete();
          },
        ),
        onTap: () {
          Navigator.pushNamed(
            arguments: remedioCancer.id,
            context,
            '/editarRemedioCancer',
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
          Navigator.pushNamed(context, '/cadastrarRemedioCancer');
        },
      ),
    );
  }
}
