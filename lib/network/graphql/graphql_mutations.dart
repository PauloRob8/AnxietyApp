//Class to hold GraphQl mutations
abstract class GraphQlMutations {
  //Mutation to add a User to the Hasura Database
  static const addUser = '''
mutation MyMutation(\$email: String!, \$user_id: String!) {
  insert_users(objects: {email: \$email, user_id: \$user_id}) {
    returning {
      email
      user_id
    }
  }
}

''';
}
