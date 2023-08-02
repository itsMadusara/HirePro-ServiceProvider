import 'package:flutter/material.dart';
class LineDivider extends StatelessWidget {
  const LineDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: const Row(
        children: [
          Expanded(
            flex: 5,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'or',
                style: TextStyle(
                    color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
