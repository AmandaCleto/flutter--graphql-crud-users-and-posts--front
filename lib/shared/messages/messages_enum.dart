enum EMessages {
  errorHive(
    'Something went wrong at the initialization! Please try again later.',
  ),
  errorGeneric(
    'Something went wrong! Please try again later.',
  );

  const EMessages(this.message);
  final String message;
}
