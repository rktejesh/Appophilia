import 'package:newsapi/newsapi.dart';

void main() async {
  var newsApi = NewsApi(
    //  dioOptions: dioOptions,
    //  interceptors: interceptors,
    debugLog: true,
    apiKey: '739327659a9c45f5b187578a3b7fcdb1',
  );

  var topHeadlines = await newsApi.topHeadlines(
//    country: country,
//    category: category,
//    sources: sources,
//    q: q,
    language: 'en',
//    pageSize: pageSize,
//    page: page,
  );

  // ArticleResponse
  print(topHeadlines);
}