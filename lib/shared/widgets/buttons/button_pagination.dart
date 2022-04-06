import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';

Widget buttonPagination(
    {required void Function()? onTap, required ViewState viewState}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 88,
              height: 140,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Center(
              child: viewState == ViewState.busy
                  ? LoaderSpinner().fadingCircleSpinner
                  : const Icon(
                      Icons.add,
                      size: 34,
                      color: Colors.white,
                    ),
            )
          ],
        ),
        const Text("\n"), //for spacing to match with other cards
      ],
    ),
  );
}
