import 'package:flutter/material.dart';
import 'package:loja_virutal_app/helpers/validators.dart';
import 'package:loja_virutal_app/models/user_manager.dart';
import 'package:loja_virutal_app/models/user_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: Text(
                  'Criar conta',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white
                  ),),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<Usermanager>(
              builder: (_,userManager,__){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if(!emailValid(email.toString())){
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: senhaController,
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
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Esqueci minha senha'),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading ? null : () {
                          if(formKey.currentState!.validate()){
                            userManager.signIn(
                                usuario: UserModel(email: emailController.text,senha: senhaController.text),
                                onFail:(e){
                                  scaffoldKey.currentState!.showSnackBar(SnackBar(
                                    content: Text('Falha ao entrar: $e'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                onSuccess: (){
                                  //print('sucesso');
                                  Navigator.of(context).pop();
                                }
                            );
                          }
                        },
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                        : const Text(
                          'Entrar',
                          style: TextStyle(
                              fontSize: 18
                          ),
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
