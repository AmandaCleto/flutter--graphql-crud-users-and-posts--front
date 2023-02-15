class PostMutation {
  static String deletePost({required String postId}) {
    String mutation = """
    mutation {
      deletePost(id: "$postId")
    }
    """;

    return mutation;
  }
}
