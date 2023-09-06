class GetProductReviewApiModel {
  String? message;
  List<RateStar>? rateStar;
  List<ReviewList>? reviewList;
  ReviewList? bestReview;
  RatingAverage? ratingAverage;

  GetProductReviewApiModel(
      {this.message,
        this.rateStar,
        this.reviewList,
        this.bestReview,
        this.ratingAverage});

  GetProductReviewApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['rateStar'] != null) {
      rateStar = <RateStar>[];
      json['rateStar'].forEach((v) {
        rateStar!.add(RateStar.fromJson(v));
      });
    }
    if (json['reviewList'] != null) {
      reviewList = <ReviewList>[];
      json['reviewList'].forEach((v) {
        reviewList!.add(ReviewList.fromJson(v));
      });
    }
    bestReview = json['bestReview'] != null
        ? ReviewList.fromJson(json['bestReview'])
        : null;
    ratingAverage = json['ratingAverage'] != null
        ? RatingAverage.fromJson(json['ratingAverage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (rateStar != null) {
      data['rateStar'] = rateStar!.map((v) => v.toJson()).toList();
    }
    if (reviewList != null) {
      data['reviewList'] = reviewList!.map((v) => v.toJson()).toList();
    }
    if (bestReview != null) {
      data['bestReview'] = bestReview!.toJson();
    }
    if (ratingAverage != null) {
      data['ratingAverage'] = ratingAverage!.toJson();
    }
    return data;
  }
}

class RateStar {
  String? rating;
  String? ratingCount;
  String? maxRate;
  String? ratePer;

  RateStar({this.rating, this.ratingCount, this.maxRate, this.ratePer});

  RateStar.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    ratingCount = json['ratingCount'];
    maxRate = json['maxRate'];
    ratePer = json['ratePer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['maxRate'] = maxRate;
    data['ratePer'] = ratePer;
    return data;
  }
}

class ReviewList {
  String? productReviewId;
  String? uuid;
  String? customerId;
  String? productId;
  String? rating;
  String? review;
  List<ReviewFile>? reviewFile;
  String? createdDate;
  String? customerName;

  ReviewList(
      {this.productReviewId,
        this.uuid,
        this.customerId,
        this.productId,
        this.rating,
        this.review,
        this.reviewFile,
        this.createdDate,
        this.customerName});

  ReviewList.fromJson(Map<String, dynamic> json) {
    productReviewId = json['productReviewId'];
    uuid = json['uuid'];
    customerId = json['customerId'];
    productId = json['productId'];
    rating = json['rating'];
    review = json['review'];
    if (json['review_file'] != null) {
      reviewFile = <ReviewFile>[];
      json['review_file'].forEach((v) {
        reviewFile!.add(ReviewFile.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    customerName = json['customerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productReviewId'] = productReviewId;
    data['uuid'] = uuid;
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['rating'] = rating;
    data['review'] = review;
    if (reviewFile != null) {
      data['review_file'] = reviewFile!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['customerName'] = customerName;
    return data;
  }
}

class ReviewFile {
  int? revImgId;
  String? revPhoto;

  ReviewFile({this.revImgId, this.revPhoto});

  ReviewFile.fromJson(Map<String, dynamic> json) {
    revImgId = json['revImgId'];
    revPhoto = json['revPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['revImgId'] = revImgId;
    data['revPhoto'] = revPhoto;
    return data;
  }
}

class RatingAverage {
  String? rateAverage;
  String? totalReview;
  String? totalRating;

  RatingAverage({this.rateAverage, this.totalReview, this.totalRating});

  RatingAverage.fromJson(Map<String, dynamic> json) {
    rateAverage = json['rateAverage'];
    totalReview = json['totalReview'];
    totalRating = json['totalRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rateAverage'] = rateAverage;
    data['totalReview'] = totalReview;
    data['totalRating'] = totalRating;
    return data;
  }
}
