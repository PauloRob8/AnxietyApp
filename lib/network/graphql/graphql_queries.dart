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

  static const getUserHistories = '''
query getUserHistories(\$user_id: String!){
  histories(where: {user_id: {_eq: \$user_id}}) {
    anxiousTaps
    calmTaps
    date
    id
    user_id
  }
}
''';

  static String getUserXp({
    required String userId,
  }) =>
      '''
query getUserXp{
  users_by_pk(user_id: "$userId") {
    user_id
    xp
  }
}
''';
}
