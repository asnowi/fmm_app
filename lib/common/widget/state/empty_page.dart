import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:lottie/lottie.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Lottie.asset(AssetsProvider.lottiePath('empty')),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text('暂无数据',style: TextStyle(
              color: Colors.black54.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'FZDaLTJ',
            ))
          ],
        ),
      ),
    );
  }
}
