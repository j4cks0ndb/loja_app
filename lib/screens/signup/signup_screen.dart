import 'package:flutter/material.dart';
import 'package:loja_virutal_app/helpers/validators.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/models/user_model.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel usuario = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<Usermanager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Nome completo'),
                      validator: (name) {
                        if (name!.isEmpty)
                          return 'Campo obrigatório';
                        else if (name.trim().split(' ').length <= 1)
                          return 'Preencha seu Nome completo';
                      },
                      onSaved: (name) => usuario.name = name.toString(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (!emailValid(email.toString())) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onSaved: (email) => usuario.email = email.toString(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (senha) {
                        if (senha!.isEmpty || senha.length < 4) {
                          return 'Senha Inválida';
                        }
                        return null;
                      },
                      onSaved: (senha) => usuario.senha = senha.toString(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Repita a Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (confirmSenha) {
                        if (confirmSenha!.isEmpty || confirmSenha.length < 4) {
                          return 'Senha Inválida';
                        }
                        return null;
                      },
                      onSaved: (confirmSenha) =>
                          usuario.confirmSenha = confirmSenha.toString(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  if (usuario.senha != usuario.confirmSenha) {
                                    scaffoldKey.currentState!
                                        .showSnackBar(SnackBar(
                                      content: Text('Senhas não coincidem.'),
                                      backgroundColor: Colors.red,
                                    ));
                                  }else {
                                    userManager.signUp(
                                        usuario: usuario,
                                        onFail: (e) {
                                          scaffoldKey.currentState!
                                              .showSnackBar(SnackBar(
                                            content:
                                            Text('Falha ao cadastrar $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        },
                                        onSuccess: () {
                                          //print('sucesso');
                                          Navigator.of(context).pop();
                                        });
                                  }
                                }
                              },
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
