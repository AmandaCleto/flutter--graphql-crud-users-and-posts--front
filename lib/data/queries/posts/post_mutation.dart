class PostMutation {
  static String deletePost({required String postId}) {
    String mutation = """
    mutation {
      deletePost(id: "$postId")
    }
    """;

    return mutation;
  }

  static String deleteAllPostsFromAuthorId({required String authorId}) {
    String mutation = """
    mutation {
      deleteAllPostFromUserId(id: "$authorId")
    }
    """;

    return mutation;
  }

  static String createPost({
    required String authorId,
    required String content,
    required String title,
  }) {
    String mutation = """
    mutation {
      createPost(
        data: {
          content:"$content",
    	    title: "$title",
          author: "$authorId"
        }
      ){
       _id
      }
    }
    """;

    return mutation;
  }
}
