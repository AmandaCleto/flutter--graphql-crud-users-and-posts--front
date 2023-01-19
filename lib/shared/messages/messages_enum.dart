enum EMessages {
  errorHive(
    'Algo deu errado ao inicializar. Por favor, tente novamente mais tarde',
  );

  const EMessages(this.message);
  final String message;
}
