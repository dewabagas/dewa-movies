import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/movies/models/model_movie_base.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewBuilder extends StatefulWidget {
  final ReviewsResult review;
  const ReviewBuilder({
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  _ReviewBuilderState createState() => _ReviewBuilderState();
}

class _ReviewBuilderState extends State<ReviewBuilder> {
  final _utilityController = Get.find<ControllerUtility>();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorConstants.appBackgroundDarker.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.review.author ?? 'Author',
                style: TextStyle(
                  color: ColorConstants.appBackgroundDarker.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.launch,
                  color: ColorConstants.appBackground,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _isHidden != false
              ? Text(
                  widget.review.content ?? "contents",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorConstants.appBackgroundDarker.withOpacity(0.6),
                    fontSize: 14,
                  ),
                )
              : Text(
                  widget.review.content ?? "contents",
                  style: TextStyle(
                    color: ColorConstants.appBackgroundDarker.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  color: Colors.transparent,
                  child: Text(
                    _isHidden != false ? 'More' : 'Less',
                    style: TextStyle(
                      color: ColorConstants.appBackground,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
