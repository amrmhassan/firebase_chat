import 'package:flutter/cupertino.dart';

import '../helpers/responsive.dart';

//? to make a horizontal space depending on the screen width
class VHSpace extends StatelessWidget {
  final int percentage;
  const VHSpace({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.getHeightPercentage(context, percentage),
    );
  }
}
