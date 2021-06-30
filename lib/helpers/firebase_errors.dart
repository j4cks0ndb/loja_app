String getErrorString(String code){
  switch(code){
    case 'invalid-email':
      return 'E-mail inválido';
    case 'user-disabled':
      return 'Usuário desabilitado';
    case 'user-not-found':
      return 'Usuário não existe';
    case 'wrong-password':
      return 'Senha incorreta';

    case 'email-already-in-use':
      return 'E-mail já cadastrado';
    case 'operation-not-allowed':
      return 'Operação não permitida';
    case 'weak-password':
      return 'Senha fraca defina uma nova senha';

    default:
      return 'Um erro indefinido ocorreu';
  }
}
