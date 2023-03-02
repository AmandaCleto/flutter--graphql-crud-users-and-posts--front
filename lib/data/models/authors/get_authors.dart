class GetAuthors {
  String id;
  String fullName;

  GetAuthors.fromJson(Map<String, dynamic> data)
      : id = data['_id'],
        fullName = data['fullName'];
}
