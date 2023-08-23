class GetFilterModal {
  String? message;
  List<FilterList>? filterList;

  GetFilterModal({this.message, this.filterList});

  GetFilterModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['filterList'] != null) {
      filterList = <FilterList>[];
      json['filterList'].forEach((v) {
        filterList!.add( FilterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (filterList != null) {
      data['filterList'] = filterList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterList {
  String? filterId;
  String? filterCatName;

  FilterList({this.filterId, this.filterCatName});

  FilterList.fromJson(Map<String, dynamic> json) {
    filterId = json['filterCatId'];
    filterCatName = json['filterCatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['filterCatId'] = filterId;
    data['filterCatName'] = filterCatName;
    return data;
  }
}


class GetFilterListModal {
  String? message;
  List<FilterDetailList>? filterDetailList;

  GetFilterListModal({this.message, this.filterDetailList});

  GetFilterListModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['filterDetailList'] != null) {
      filterDetailList = <FilterDetailList>[];
      json['filterDetailList'].forEach((v) {
        if(!v.toString().contains("null"))
          {
            filterDetailList!.add(FilterDetailList.fromJson(v));

          }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (filterDetailList != null) {
      data['filterDetailList'] =
          filterDetailList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterDetailList {
  String? filterValue;

  FilterDetailList({this.filterValue});

  FilterDetailList.fromJson(Map<String, dynamic> json) {
    if(json['filterValue']!=null && json['filterValue'].toString().isNotEmpty)
    {
      filterValue = json['filterValue'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['filterValue'] = filterValue;
    return data;
  }
}