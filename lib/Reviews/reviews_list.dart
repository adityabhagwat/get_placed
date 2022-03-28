import 'package:flutter/material.dart';

import 'reviews_const.dart';


class ReviewCard extends StatelessWidget {
  final Review? review;
  final Function saveInfo;
  ReviewCard({this.review,required this.saveInfo});


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
                  children: [
                    const TextSpan(text: "Company Name : ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,)
                    ),
                    TextSpan(text: review!.companyName, style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    ),
                  ]
                )
            ),
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "Designation : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,)
                      ),
                      TextSpan(text: review!.designation, style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      ),
                    ]
                )
            ),
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "No of Rounds : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,)
                      ),
                      TextSpan(text: review!.noRounds.toString(), style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      ),
                    ]
                )
            ),
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "Procedure : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black)
                      ),
                      TextSpan(text: review!.procedure, style: TextStyle(color: Colors.black)),
                    ]
                )
            ),
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                  text: "Topics to Prepare : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
                      TextSpan(text: review!.questions,style: TextStyle(color: Colors.black)),
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
                      TextSpan(text: review!.salary.toString(), style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      ),
                    ]
                )
            ),
            const SizedBox(height: 5),
            TextButton.icon(
                icon: Icon(Icons.bookmark_border),
                onPressed: (){},
                label: Text('Save')
            )
          ],
        ),
      ),
  );
 }
}
