//Class to hold GraphQl queries
abstract class GraphQlQueries {
  //Query to get diaries of a user
  static const getUserDiaries = '''
  query getUserDiaries(\$user_id: String!) {
  diary(where: {user_id: {_eq: \$user_id}}) {
    date
    description
    id
    title
  }
}
  ''';
}
