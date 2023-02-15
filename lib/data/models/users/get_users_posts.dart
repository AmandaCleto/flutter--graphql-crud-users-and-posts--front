class GetUsersPosts {
  String authorFullName;
  String title;
  String content;
  String postId;

  GetUsersPosts.fromJson(Map<String, dynamic> data)
      : authorFullName = data['author']['fullName'],
        title = data['title'],
        content = data['content'],
        postId = data['_id'];
}
