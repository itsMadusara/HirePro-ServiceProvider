import 'package:flutter/material.dart';
class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('By continuing you agree to our '),
                Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Terms of service'),
          Icon(
            Icons.circle,
            size: 3,
          ),
          Text('Privacy policy'),
          Icon(
            Icons.circle,
            size: 3,
          ),
          Text('Content policy'),
        ]),
                )
              ]);
  }
}
