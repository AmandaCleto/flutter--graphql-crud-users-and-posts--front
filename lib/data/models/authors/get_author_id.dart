class GetAuthor {
  String firstName;
  String lastName;
  String id;

  GetAuthor.fromJson(Map<String, dynamic> data)
      : firstName = data['firstName'],
        lastName = data['lastName'],
        id = data['_id'];
}
