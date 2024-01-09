import 'package:flutter/material.dart';
import 'package:admin_version/utils/network.dart';

class newV2ray extends StatefulWidget {
  const newV2ray({super.key});

  @override
  State<newV2ray> createState() => _newV2rayState();
}

class _newV2rayState extends State<newV2ray> {
  TextEditingController v2rayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('v2ray'),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: v2rayController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'Config',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 130,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Network.checkInternet();
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      if (Network.isConnected) {
                        Network.postData(
                          v2ray: v2rayController.text,
                        );
                        Navigator.pop(context);
                      } else {
                        Network.showError(context);
                      }
                    });
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}