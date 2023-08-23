class SearchProductSuggestionModel {
  String? message;
  List<Suggestion>? suggestion;

  SearchProductSuggestionModel({this.message, this.suggestion});

  SearchProductSuggestionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['suggestion'] != null) {
      suggestion = <Suggestion>[];
      json['suggestion'].forEach((v) {
        suggestion!.add(Suggestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (suggestion != null) {
      data['suggestion'] = suggestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suggestion {
  String? srNo;
  String? resName;
  String? inSearch;

  Suggestion({this.srNo, this.resName, this.inSearch});

  Suggestion.fromJson(Map<String, dynamic> json) {
    srNo = json['SrNo'];
    resName = json['resName'];
    inSearch = json['inSearch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNo'] = srNo;
    data['resName'] = resName;
    data['inSearch'] = inSearch;
    return data;
  }
}