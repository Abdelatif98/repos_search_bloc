import 'package:repos_search_bloc/model/repository.model.dart';

class ReposRS{
  int totalCount;
  bool incompleteResults;
  List<Repository> items;

  ReposRS({this.totalCount, this.incompleteResults, this.items});

  factory ReposRS.fromJson(Map<String, dynamic> json) => new ReposRS(
    totalCount: json["total_count"],
    items: new List<Repository>.from(json["items"].map((x) => Repository.fromJson(x))),
    incompleteResults: json["incomplete_results"],
  );

  Map<String, dynamic> toJson() => {
    "incomplete_results": incompleteResults,
    "items": new List<dynamic>.from(items.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}