class UserQuery {
  String get getUsersPosts {
    String query = """
    query {
      posts {
        title
        content
        _id
        author {
          fullName,
        }
      }
    }
    """;

    return query;
  }
}
