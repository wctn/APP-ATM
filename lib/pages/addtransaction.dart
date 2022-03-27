import 'package:expense/controllers/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense/static.dart' as Static;
import 'package:flutter/services.dart';

class AddWithdrawNoGradient extends StatefulWidget {
  const AddWithdrawNoGradient({Key? key}) : super(key: key);

  @override
  _AddWithdrawNoGradientState createState() => _AddWithdrawNoGradientState();
}

class _AddWithdrawNoGradientState extends State<AddWithdrawNoGradient> {
  DateTime selectedDate = DateTime.now();
  int? amount;
  String note = "Withdraw";
  String type = "Deposit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Color.fromARGB(255, 255, 162, 232),
      ),
      backgroundColor: Color(0xffe2e7ef),
      //
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          Text(
            "\n\n\n\n\n\nAdd Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 163, 79, 159),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.attach_money,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {
                      // show Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(
                            seconds: 2,
                          ),
                          content: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Enter only Numbers as Amount",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //

          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Deposit",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Deposit" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Color.fromARGB(255, 163, 79, 159),
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Deposit";
                      if (note.isEmpty || note == "Withdraw") {
                        note = 'Deposit';
                      }
                    });
                  }
                },
                selected: type == "Deposit" ? true : false,
              ),
              SizedBox(
                width: 8.0,
              ),
              ChoiceChip(
                label: Text(
                  "Withdraw",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Withdraw" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Color.fromARGB(255, 163, 79, 159),
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Withdraw";
                      if (note.isEmpty || note == "Deposit") {
                        note = 'Withdraw';
                      }
                    });
                  }
                },
                selected: type == "Withdraw" ? true : false,
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //

          //
          SizedBox(
            height: 20.0,
          ),
          //
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (amount != null) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, selectedDate, type, note);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color.fromARGB(255, 163, 79, 159),
                      content: Text(
                        "Please enter a valid Amount !",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 163, 79, 159),
                ),
              ),
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
