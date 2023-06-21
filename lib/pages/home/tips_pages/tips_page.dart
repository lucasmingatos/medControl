// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../shared/values/custom_colors.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lembretes Saudáveis"),
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
        child: ListView(
          children: [
            //inicio
            ListTile(
              selected: false,
              tileColor: Colors.blue[100],
              leading: Icon(
                Icons.smoking_rooms_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Abandono do cigarro',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '\nO cigarro deve ser abandonado pois tabagismo é reconhecido como uma doença crônica causada pela dependência à nicotina presente em produtos a base de tabaco.\n'
                '\nAlém de ser considerado a maior causa evitável isolada de adoecimento e mortes em todo o mundo.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.all(4),
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
            ),
            //fim
            //inicio
            ListTile(
              selected: false,
              tileColor: Colors.blue[100],
              leading: Icon(
                Icons.fastfood,
                color: Colors.white,
              ),
              title: const Text(
                'Alimentação saudável',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '\nUma alimentação balanceada traz diversos benefícios ao corpo humano.\n'
                '\nUma dieta saudável conduz a perda de peso, reduz o risco e auxilia no controle de doenças e também causa melhorias no humor.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.all(4),
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
            ),
            //fim
            //inicio
            ListTile(
              selected: false,
              tileColor: Colors.blue[100],
              leading: Icon(
                Icons.local_drink,
                color: Colors.white,
              ),
              title: const Text(
                'Consumo de álcool',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '\nO não consumo ou a ingestão moderada do alcool é um hábito consciente.\n'
                '\nPor ser um fator de risco para mortalidade e incapacidade prematura. Além disso o álcool aumenta a chance do desenvolvimento de doenças.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.all(4),
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
            ),
            //fim
            //inicio
            ListTile(
              selected: false,
              tileColor: Colors.blue[100],
              leading: Icon(
                Icons.local_drink,
                color: Colors.white,
              ),
              title: const Text(
                'Hidratação',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '\nO corpo humano tem a água como principal parte da sua composição .\n'
                '\nA hidratação ajuda a evitar problemas relacionados ao sistema circulatório e articulações.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.all(4),
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
            ),
            //fim
            //inicio
            ListTile(
              selected: false,
              tileColor: Colors.blue[100],
              leading: Icon(
                Icons.sports_gymnastics,
                color: Colors.white,
              ),
              title: const Text(
                'Exercícios físicos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '\nA atividade física previe o desenvolvimento de doenças crônicas, melhora dores e incapacidades funcionais, além de colaborar na qualidade do sono.\n'
                '\nMudanças no organismo podem ser encontradas por meio do ganho de massa muscular e o controle de peso.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
            ),
            //fim
          ],
        ),
      ),
    );
  }
}
