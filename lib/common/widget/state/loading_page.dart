import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Lottie.asset(AssetsProvider.lottiePath('loading')),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text('加载数据...',style: TextStyle(
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

