import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/values/custom_colors.dart';
import '../sign_up/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtEmailController = TextEditingController();
  var txtSenhaController = TextEditingController();
  bool obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                ),
                child: Image.asset(
                  "assets/logo.png",
                  height: 150,
                ),
              ),
              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmailController,
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Você precisa digitar um e-mail válido.';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: txtSenhaController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Digite uma senha válida. (mínimo de 6 caracteres)';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),

              //recuperar senha
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Row(
                children: [
                  Checkbox(
                    value: obscurePassword,
                    onChanged: (bool? newValue) {
                      setState(() {
                        obscurePassword = newValue!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text(
                    "Mostrar senha",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              ElevatedButton(
                //BOTAO
                onPressed: () =>
                    logar(txtEmailController.text, txtSenhaController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors().getActivePrimaryButtonColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const Text(
                "Ainda não tem uma conta?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        CustomColors().getActiveSecondaryButtonColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    "Cadastre-se",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*void saveValor() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    final tokenSave = await SharedPreferences.getInstance();
    await tokenSave.setString('token', uid);
  }*/

  void logar(email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      //isLoading = false;
      //salvar ultimo login
      //saveValor();
      Navigator.pushReplacementNamed(context, '/homeTab',
          arguments: resultado.user!.uid);
    }).catchError(
      (erro) {
        var errorCode = erro.code;
        var mensagem = '';
        if (errorCode == 'user-not-found') {
          mensagem = 'Usuário ou senha incorretos';
        } else if (errorCode == 'wrong-password') {
          mensagem = 'Usuário ou senha incorretos';
        } else if (errorCode == 'invalid-email') {
          mensagem = 'Email inválido';
        } else {
          mensagem = 'error.message';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagem),
            duration: const Duration(seconds: 5),
          ),
        );
      },
    );
  }
}
