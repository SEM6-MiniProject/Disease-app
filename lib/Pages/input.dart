import 'package:diseaseapp/Model/prediction.dart';
import 'package:diseaseapp/Pages/inputprediction.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late int _gendercontroller;
  late TextEditingController _hemocontroller;
  late TextEditingController _mchcontroller;
  late TextEditingController _mchccontroller;
  late TextEditingController _mcvcontroller;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();

  void unfocus() {
    _focusNode1.unfocus();
    _focusNode2.unfocus();
    _focusNode3.unfocus();
    _focusNode4.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _gendercontroller = 0;
    _hemocontroller = TextEditingController();
    _mchcontroller = TextEditingController();
    _mchccontroller = TextEditingController();
    _mcvcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _hemocontroller.dispose();
    _mchcontroller.dispose();
    _mchccontroller.dispose();
    _mcvcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gender : ",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.lightBlue,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _gendercontroller,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "Male",
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: 1,
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _gendercontroller = val!;
                          });
                          print(val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            myTextField(_hemocontroller, 'Hemoglobin', _focusNode1),
            myTextField(_mchcontroller, 'MCH', _focusNode2),
            myTextField(_mchccontroller, 'MCHC', _focusNode3),
            myTextField(_mcvcontroller, 'MCV', done: true, _focusNode4),
            SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                unfocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputPredictionPage(
                              inputs: PredictionModel(
                                prediction: 1,
                                data: {
                                  "Hemoglobin": _hemocontroller.text,
                                  "MCV": _mcvcontroller.text,
                                  "MCH": _mchcontroller.text,
                                  "MCHC": _mchccontroller.text,
                                  "Gender": _gendercontroller.toString(),
                                },
                              ),
                            )));
              },
              child: const Text('Submit', style: TextStyle(fontSize: 17)),
            ),
          ],
        ),
      ),
    );
  }

  Widget myTextField(
      TextEditingController controller, String hint, FocusNode focusnode,
      {bool done = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        focusNode: focusnode,
        keyboardType: TextInputType.number,
        textInputAction: done ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.green,
          )),
          filled: true,
          fillColor: Colors.white,
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}
