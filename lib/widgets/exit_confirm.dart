import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Apakah anda yakin untuk keluar ?",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
        ),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).pop(false);
            },
            child: Container(
              height: 45,
              width: 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Tidak",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              SystemNavigator.pop();
            },
            child: Container(
              height: 45,
              width: 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Keluar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

        ],
      ),
    );
  }
}