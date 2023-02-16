class GetAuthorId {
  String firstName;
  String lastName;

  GetAuthorId.fromJson(Map<String, dynamic> data)
      : firstName = data['firstName'],
        lastName = data['lastName'];
}
