import 'package:flutter/material.dart';
import 'designation_const.dart';


class DesignationCard extends StatelessWidget {
  final Designation? designation;
  DesignationCard({this.designation});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10.0,10.0,10.0,0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "Designation : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,)
                      ),
                      TextSpan(text: designation!.designation, style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                        fontSize: 18,
                      ),
                      ),
                    ]
                )
            ),

            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: [
                      const TextSpan(text: "Company : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,)
                      ),
                      TextSpan(text: designation!.companyName, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                      ),
                    ]
                )
            ),
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "Salary : ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black)
                      ),
                      TextSpan(text: designation!.salary.toString(), style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      ),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
