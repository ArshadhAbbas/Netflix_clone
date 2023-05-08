import 'dart:convert';
import './result.dart';


TrendingModel trendingModelFromJson(String str) =>
    TrendingModel.fromJson(json.decode(str));


class TrendingModel {
  TrendingModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );


}

