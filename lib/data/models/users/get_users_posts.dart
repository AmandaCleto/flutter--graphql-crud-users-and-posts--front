class GetUsersPosts {
  String authorFullName;
  String title;
  String content;

  GetUsersPosts.fromJson(Map<String, dynamic> data)
      : authorFullName = data['author']['fullName'],
        title = data['title'],
        content = data['content'];
}
