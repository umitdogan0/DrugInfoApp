import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/http_interceptor.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlInit {
  final local = LocalStorage.instance;
  final ac = ApiConnection.instance;
  HttpLink httpLinkSetter(){
  return HttpLink(ac.nodeUrl,defaultHeaders: {
  'Authorization': 'Bearer ${local.read("token")}',
  },
  httpClient: GraphQLInterceptor() 
  );
  }
   ValueNotifier<GraphQLClient> setup(){
    httpLinkSetter();
     return ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLinkSetter(),
        cache: GraphQLCache(),
      ),
    );
   }
}