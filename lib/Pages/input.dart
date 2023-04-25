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
            myTextField(_hemocontroller, 'Hemoglobin'),
            myTextField(_mchcontroller, 'MCH'),
            myTextField(_mchccontroller, 'MCHC'),
            myTextField(_mcvcontroller, 'MCV'),
            SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputPredictionPage(
                              inputs: PredictionModel(
                                MCH: _mchccontroller.text,
                                MCHC: _mchccontroller.text,
                                MCV: _mcvcontroller.text,
                                hemoglobin: _hemocontroller.text,
                                gender:
                                    _gendercontroller == 1 ? "Male" : "Female",
                                hasAnemia: "0.5",
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

  Widget myTextField(TextEditingController controller, String hint,
      {bool done = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
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
