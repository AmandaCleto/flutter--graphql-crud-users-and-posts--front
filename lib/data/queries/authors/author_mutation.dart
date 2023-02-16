class AuthorMutation {
  String createUser({
    required String firstName,
    required String lastName,
    required String email,
    required bool active,
  }) {
    String query = """
    mutation {
      createUser(
         data: {
          firstName: "$firstName"
          lastName: "$lastName"
          email: "$email"
          active: $active
        }
      ) {
        firstName
        lastName
        fullName
        _id
        email
        active
      }
    }
    """;

    return query;
  }
}
