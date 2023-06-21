import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/values/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  final TextEditingController _confirmInputController = TextEditingController();

  bool showPassword = false;

  void limpar() {
    txtNome.clear();
    txtEmail.clear();
    txtSenha.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 40,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientSecColor(),
              CustomColors().getGradientMainColor(),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Cadastro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 10) {
                          return "Digite o nome completo";
                        }
                        return null;
                      },
                      controller: txtNome,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Nome Completo',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline,
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
                      validator: (value) {
                        if (value!.length < 5) {
                          return "Esse e-mail parece curto demais";
                        } else if (!value.contains("@")) {
                          return "Corrija o e-mail (@)";
                        }
                        return null;
                      },
                      controller: txtEmail,
                      autofocus: true,
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
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 15,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return "A senha deve ter pelo menos 6 caracteres";
                        }
                        return null;
                      },
                      controller: txtSenha,
                      obscureText: (showPassword == true) ? false : true,
                      style: const TextStyle(color: Colors.white),
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
                    //if ternário - com um container vazio embaixo como "resposta"
                    (showPassword == false)
                        ? TextFormField(
                            validator: (value) {
                              if (value != txtSenha.text) {
                                return "As senhas devem ser iguais";
                              }
                              return null;
                            },
                            controller: _confirmInputController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Confirme a Senha',
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
                          )
                        : Container(),
                    Row(
                      children: [
                        Checkbox(
                          value: showPassword,
                          onChanged: (bool? newValue) {
                            setState(() {
                              showPassword = newValue!;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          "Mostrar senha",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    // ignore: prefer_const_constructors, sort_child_properties_last
                    child: Text(
                      "Cadastrar",
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          CustomColors().getActivePrimaryButtonColor(),
                      fixedSize: const Size.fromWidth(310),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () =>
                        criarConta(txtNome.text, txtEmail.text, txtSenha.text),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          CustomColors().getActiveSecondaryButtonColor(),
                      fixedSize: const Size.fromWidth(310),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Voltar",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> criarConta(nome, email, senha) async {
    FirebaseAuth fa = FirebaseAuth.instance;
    fa
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      //armazenar os dados da conta
      var db = FirebaseFirestore.instance;
      db.collection('users').doc(resultado.user!.uid).set({
        'nome': nome,
        'email': email,
      }).then((valor) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário criado com sucesso.'),
            duration: Duration(seconds: 5),
          ),
        );
        limpar();
      });
    }).catchError(
      (erro) {
        var errorCode = erro.code;
        print(errorCode);

        if (errorCode == 'unknown') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('ATENÇÃO: insira todos os dados antes de prosseguir.'),
              duration: Duration(seconds: 5),
            ),
          );
        }

        //email sem @
        if (errorCode == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ATENÇÃO: o e-mail inserido é inválido.'),
              duration: Duration(seconds: 5),
            ),
          );
        } //email ja usado
        else if (errorCode == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ATENÇÃO: o e-mail inserido ja está em uso.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
        //senha curta
        else if (errorCode == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('ATENÇÃO: a senha deve conter no mínimo 6 caracteres.'),
              duration: Duration(seconds: 5),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('ERRO ${erro.message}'),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
    );
  }
}
