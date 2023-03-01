class GetAuthorFirstAndLastName {
  String firstName;
  String lastName;

  GetAuthorFirstAndLastName.fromJson(Map<String, dynamic> data)
      : firstName = data['firstName'],
        lastName = data['lastName'];
}
