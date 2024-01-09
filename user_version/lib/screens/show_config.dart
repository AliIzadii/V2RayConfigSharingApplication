import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_version/models/v2ray.dart';
import 'package:user_version/utils/network.dart';

class showConfig extends StatefulWidget {
  const showConfig({super.key});

  @override
  State<showConfig> createState() => _showConfigState();
}

class _showConfigState extends State<showConfig> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    Network.checkInternet();
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (Network.isConnected) {
        Network.getData().then((data) async {
          await Future.delayed(Duration(seconds: 2));
          setState(() {});
        });
      } else {
        Network.showError(context);
      }
    });

     animationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  Animatable<Color?> background = TweenSequence<Color?>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blueAccent,
        end: Colors.greenAccent,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.greenAccent,
        end: Colors.pinkAccent,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.pinkAccent,
        end: Colors.orangeAccent,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.orangeAccent,
        end: Colors.blueAccent,
      ),
    ),
  ]);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('v2ray'),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
          actions: [
            IconButton(
              onPressed: () {
                Network.checkInternet();
                showLoaderDialog(context);
                print(Network.isConnected);
                Future.delayed(Duration(seconds: 2)).then((value) {
                  if (Network.isConnected) {
                    Network.getData().then((data) async {
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {});
                      Navigator.pop(context);
                    });
                  } else {
                    Network.showError(context);
                  }
                });
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemCount: Network.v2ray.length,
            itemBuilder: (context, index) {
              var reverselist = Network.v2ray.reversed.toList();
              if (index < 4) {
                return showConfigs(index, reverselist, context, true);
              }
              return showConfigs(index, reverselist, context, false);
            },
          ),
        ),
      ),
    );
  }

  ListTile showConfigs(int index, List<v2rays> reverselist, BuildContext context, bool showTop) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(201, 128, 71, 232),
        child: Text(
          (index + 1).toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTop == true) ...[
          AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Container(
                  width: 35,
                  height: 28,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Center(
                      child: Text(
                        'new',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                    color: background.evaluate(
                        AlwaysStoppedAnimation(
                            animationController.value)),
                  ),
                );
              }),
        ],
          IconButton(
            onPressed: () {
              Clipboard.setData(new ClipboardData(
                      text: reverselist[index].v2ray))
                  .then((_) {
                controller.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Copied to your clipboard !')));
              });
            },
            icon: Icon(Icons.copy),
          ),
        ],
      ),
      title: Text(
        reverselist[index].v2ray.substring(0, 20) + " ...",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text('v2ray Config'),
    );
  }

showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 238, 170, 250),
            color: Colors.purpleAccent,
          ),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                "Please Wait...",
                style: TextStyle(fontSize: 18),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
