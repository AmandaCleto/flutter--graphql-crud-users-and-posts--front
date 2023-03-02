class AuthorQuery {
  static String get getAuthorsPosts {
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

  static String get getAuthors {
    String query = """
    query {
      users{
        _id, firstName, lastName, fullName
      },
    }
    """;

    return query;
  }

  static String getAuthorId(String id) {
    String query = """
    query {
      user(id: "$id") {
        firstName, lastName
      },
    }
    """;

    return query;
  }
}
