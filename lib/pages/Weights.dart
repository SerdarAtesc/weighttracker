import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weighttracker/Models/WeightModel.dart';
import 'package:weighttracker/services/AuthController.dart';
import 'package:weighttracker/services/WeightService.dart';
import 'package:timeago/timeago.dart' as timeago;

class Weights extends StatefulWidget {
  Weights({Key? key, @required this.userid}) : super(key: key);
  String? userid;

  @override
  State<Weights> createState() => _WeightsState();
}

class _WeightsState extends State<Weights> {
  void initState() {
    // TODO: implement initState
  }

  var valueText;

  final _formKey = GlobalKey<FormState>();

  String? weight;

  bool? loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                _openPopup();
              },
              icon: const Icon(Icons.add)),
          actions: [
            IconButton(
                onPressed: () {
                  AuthController.instance.logOut();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        // body: ListView.builder(
        //   itemCount: _Weights.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     WeightsModel Weight = _Weights[index];
        //     if (_Weights.isEmpty) {
        //       return const Center(
        //         child: Text("data"),
        //       );
        //     }
        //     return WeighCart(Weight);
        //   },
        // ),
        body: Column(
          children: [
            _showWeights(),
          ],
        ));
  }

  _showWeights() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: WeightService().getWeightsbyUser(widget.userid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    WeightsModel weight =
                        WeightsModel.createDocument(snapshot.data!.docs[index]);
                    return weighCart(weight);
                  });
            }));
  }

  weighCart(WeightsModel weights) {
    // ignore: prefer_const_literals_to_create_immutables
    return InkWell(
      onTap: () {
        _openPopupUpdate(weights.weight, weights.id);
      },
      child: ListTile(
        title: Text("Weight:" + weights.weight),
        subtitle:
            Text(timeago.format(weights.createTime.toDate(), locale: "tr")),
        trailing: IconButton(
            onPressed: () async {
              await WeightService().weightDelete(weight: weights).then(
                  (value) =>
                      Future.delayed(const Duration(milliseconds: 500), () {}));
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, a, b) => Weights(
                    userid: widget.userid,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete)),
      ),
    );
  }

  _openPopupUpdate(String weight, String id) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Weight"),
                        initialValue: weight,
                        onSaved: (input) => weight = input!,
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                      ),
                    ],
                  )),
              title: const Text('Add Weight'),
              actions: <Widget>[
                InkWell(
                  child: const Text('ADD   '),
                  onTap: () {
                    setState(() {
                      weight = valueText;
                      _updatePost(weight, id);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => Weights(
                            userid: widget.userid,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ],
            );
          });
        });
  }

  _openPopup() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Weight"),
                        onSaved: (input) => weight = input,
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                      ),
                    ],
                  )),
              title: const Text('Add Weight'),
              actions: <Widget>[
                InkWell(
                  child: const Text('ADD   '),
                  onTap: () {
                    setState(() {
                      weight = valueText;
                      _createPost();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => Weights(
                            userid: widget.userid,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ],
            );
          });
        });
  }

  void _createPost() async {
    await WeightService().createPost(
      weight: weight,
      userId: widget.userid,
    );
    setState(() {
      loading = false;
    });
  }

  void _updatePost(String weight, String id) async {
    WeightService().weightUpdate(
      weight: weight,
      id: id,
    );
    setState(() {
      loading = false;
    });
  }
}
