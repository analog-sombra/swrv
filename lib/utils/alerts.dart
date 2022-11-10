import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void erroralert(BuildContext context, String title, String subTitle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: subTitle,
        contentType: ContentType.failure,
      ),
    ),
  );
}

void susalert(BuildContext context, String title, String subTitle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: subTitle,
        contentType: ContentType.success,
      ),
    ),
  );
}

void comingalert(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Upcoming",
        message: "This feature is coming soon in next release",
        contentType: ContentType.help,
      ),
    ),
  );
}
