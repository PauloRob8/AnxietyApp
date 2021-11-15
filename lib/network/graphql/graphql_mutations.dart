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

  //Mutation to add a diary to a user
  static const addDiary = '''
  mutation addDiary(\$title: String!, \$description: String!, \$user_id: String!) {
  insert_diary(objects: { description: \$description, title: \$title, user_id: \$user_id}) {
    returning {
      date
      description
      id
      title
    }
  }
}

''';

  static const deleteDiary = ''''
mutation MyMutation(\$id: uuid!) {
  delete_diary(where: {id: {_eq: \$id}}) {
    returning {
      user_id
    }
  }
}

''';
}
