enum EMessages {
  errorHive(
    'Something went wrong at the initialization! Please try it again later.',
  ),
  errorGeneric(
    'Something went wrong! Please try it again later.',
  );

  const EMessages(this.message);
  final String message;
}
