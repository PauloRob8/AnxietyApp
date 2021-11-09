import 'package:anxiety_app/network/graphql/graphql_mutations.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HasuraConnector {
  HasuraConnector();

  HasuraConnect _connection =
      HasuraConnect('https://graphql-anxiety.herokuapp.com/v1/graphql');

  Future<void> addUserToDatabase({
    required email,
    required userId,
  }) async {
    await _connection.mutation(GraphQlMutations.addUser, variables: {
      'email': email,
      'user_id': userId,
    });
  }

  Future<dynamic> query(
    String docQuery, {
    Map<String, dynamic>? variables,
  }) async {
    return _connection.query(docQuery, variables: variables);
  }
}
