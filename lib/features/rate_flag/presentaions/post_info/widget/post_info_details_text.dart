import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_material_button.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_save_mark_button.dart';

class PostInfoDetailsTextWithFlags extends StatelessWidget {
  final String fullName;
  final int age;
  final String city;
  final String district;
  final String description;
  final int greenFlagCount;
  final int redFlagCount;
  final bool hasGreenFlag;
  final bool hasRedFlag;
  final bool? isSaved;
  final VoidCallback onGreenFlag;
  final VoidCallback onRedFlag;
  final VoidCallback onSaveToggle;

  const PostInfoDetailsTextWithFlags({
    super.key,
    required this.fullName,
    required this.age,
    required this.city,
    required this.district,
    required this.description,
    required this.greenFlagCount,
    required this.redFlagCount,
    required this.hasGreenFlag,
    required this.hasRedFlag,
    this.isSaved,
    required this.onGreenFlag,
    required this.onRedFlag,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: RateFlagText.head2(
                          text: fullName,
                          context: context,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      RateFlagText.head3(text: "$age", context: context),

                      SizedBox(width: 12.w),

                      FlagButton(
                        isGreen: true,
                        count: greenFlagCount,
                        hasFlagged: hasGreenFlag,
                        onPressedCallback: onGreenFlag,
                      ),
                      SizedBox(width: 6.w),
                      FlagButton(
                        isGreen: false,
                        count: redFlagCount,
                        hasFlagged: hasRedFlag,
                        onPressedCallback: onRedFlag,
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  RateFlagText.head3(
                    text: "📍 $city / $district",
                    context: context,
                  ),
                ],
              ),
            ),

            SaveBookmarkButton(
              isSaved: isSaved ?? false,
              onPressed: onSaveToggle,
            ),
          ],
        ),

        SizedBox(height: 12.h),

        Text(
          description,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
