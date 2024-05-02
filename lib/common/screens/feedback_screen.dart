import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/repo/feedback_repo.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/long_icon_button.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';

import '../../models/booking_model.dart';
import '../../models/overall_rating_model.dart';
import '../constants/quik_colors.dart';

class FeedbackScreen extends StatefulWidget {
  final Booking booking;
  const FeedbackScreen({super.key, required this.booking});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 4;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuikAppBar(
        pageName: "Feedback",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            const GradientSeparator(),
            QuikSpacing.vS24(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "RATING & FEEDBACK",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            QuikSpacing.vS32(),
            const Text(
              "Provide your rating and feedback of the worker after the work has been completed.",
              style: descriptionTextStyle,
            ),
            QuikSpacing.vS32(),
            RatingBar.builder(
              minRating: 1,
              initialRating: 4,
              itemBuilder: (context, _) => const Icon(Icons.star_rounded),
              onRatingUpdate: (updatedRating) {
                rating = updatedRating;
              },
            ),
            QuikSpacing.vS16(),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter your feedback (Optional)",
                hintStyle: Theme.of(context).textTheme.bodyText2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            QuikSpacing.vS16(),
            const Spacer(),
            LongIconButton(
              svgPath: QuikAssetConstants.rightArrowSvg,
              text: 'Submit',
              onPressed: () async {
                final overallRatingModel = OverallRatingModel(
                  workerId: widget.booking.workerId ?? "workerId",
                  clientId: widget.booking.clientId ?? "clientId",
                  bookingId: widget.booking.id ?? "bookingId",
                  subserviceName: widget.booking.subserviceName,
                  overallRating: OverallRating(
                      rating: rating, feedback: feedbackController.text),
                );
                final result = await FeedbackRepo()
                    .sendOverallFeedback(overallRatingModel);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to send feedback: $failure')),
                    );
                  },
                  (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Feedback sent successfully')),
                    );
                    context.pop();
                  },
                );
              },
              backgroundColor: secondary,
              foregroundColor: onSecondary,
            ),
            QuikSpacing.vS16(),
            const Text(
              "Rating is mandatory, while feedback is optional. Submit to continue",
              textAlign: TextAlign.center,
              style: descriptionTextStyle,
            ),
            QuikSpacing.vS16(),
          ],
        ),
      ),
    );
  }
}
