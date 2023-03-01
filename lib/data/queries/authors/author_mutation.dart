class AuthorMutation {
  static String createUser({
    required String firstName,
    required String lastName,
  }) {
    bool active = true;
    String query = """
    mutation {
      createUser(
         data: {
          firstName: "$firstName"
          lastName: "$lastName"
          active: $active
        }
      ) {
        _id
      }
    }
    """;

    return query;
  }

  static String deleteAuthor({required String authorId}) {
    String query = """
    mutation {
      deleteUser(id: "$authorId")
    }
    """;

    return query;
  }

  static String updateAuthor({
    required String firstName,
    required String lastName,
    required String authorId,
  }) {
    bool active = true;
    String query = """
    mutation {
      updateUser(
        id: "$authorId"
        data: { firstName: "$firstName", lastName: "$lastName", active: $active }
     ) {
      _id
      firstName
      lastName
    }
   }
    """;

    return query;
  }
}
