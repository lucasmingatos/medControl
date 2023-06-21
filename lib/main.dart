import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/pages/home/home_page.dart';
import 'package:tcc/pages/home/home_widgets/home_tab.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_cancer/edit_cancer_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_cancer/remed_cancer.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_cancer/cancer_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_card/card_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_card/edit_card_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_card/remed_card.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_diabetes/diabetes_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_diabetes/edit_diabetes_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_diabetes/remed_diabetes.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_resp/edit_resp_page.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_resp/remed_resp.dart';
import 'package:tcc/pages/home/home_widgets/med_pages/med_resp/resp_page.dart';
import 'package:tcc/pages/home/tips_pages/cancer_tips/cancer_tips.dart';
import 'package:tcc/pages/home/tips_pages/cardio_tips/cardio_tips.dart';
import 'package:tcc/pages/home/tips_pages/diab_tips/diab_tips.dart';
import 'package:tcc/pages/home/tips_pages/resp_tips/resp_tips.dart';
import 'package:tcc/pages/login/login_page.dart';
import 'firebase_options.dart';

void main() async {
  String? token;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final tokenSave = await SharedPreferences.getInstance();
  token = tokenSave.getString('token');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Med Control',
    initialRoute: token == null || token == '' ? '/login' : '/homeTab',
    routes: {
      '/login': (context) => const LoginPage(),
      '/principal': (context) => const HomePage(dynamic),
      '/homeTab': (context) => const HomeTabBar(''),
      '/cancer': (context) => const CancerPage(uid: ''),
      '/diabetes': (context) => const DiabetesPage(uid: ''),
      '/cardio': (context) => const CardioPage(uid: ''),
      '/resp': (context) => const RespPage(uid: ''),
      '/cadastrarRemedioCard': (context) => TelaCadastroCard(),
      '/cadastrarRemedioCancer': (context) => TelaCadastroCancer(),
      '/cadastrarRemedioDiabetes': (context) => TelaCadastroDiabetes(),
      '/cadastrarRemedioResp': (context) => TelaCadastroResp(),
      '/editarRemedioCancer': (context) => TelaEditarCadastroCancer(),
      '/editarRemedioCard': (context) => TelaEditarCadastroCard(),
      '/editarRemedioDiabetes': (context) => TelaEditarCadastroDiabetes(),
      '/editarRemedioResp': (context) => TelaEditarCadastroResp(),
      '/cancerTips': (context) => const CancerTips(),
      '/cardioTips': (context) => const CardioTips(),
      '/diabTips': (context) => const DiabTips(),
      '/respTips': (context) => const RespTips(),
    },
  ));
}
