import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderSpinner {
  SpinKitFadingCircle fadingCircleSpinner =  SpinKitFadingCircle(
    // size: 14,
    color: ColorConstants.appBackground,
  );

  SpinKitFadingCircle miniFadingCircleSpinner =  SpinKitFadingCircle(
    size: 22,
    color: ColorConstants.white,
  );

  SpinKitThreeBounce horizontalLoading =  SpinKitThreeBounce(
    size: 14,
    color: ColorConstants.appBackgroundDarker,
  );
}
