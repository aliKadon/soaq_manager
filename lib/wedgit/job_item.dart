import 'package:flutter/material.dart';

class JobItem extends StatelessWidget {
  final String job_type;
  final String job_name;
  final String job_salary;
  final String id;

  JobItem(this.job_type, this.job_name, this.job_salary, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    job_type,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontSize: 18,
                        color: Colors.purple),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    job_name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                ),
                subtitle: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(job_salary,
                      style: const TextStyle(color: Colors.purple)),
                ),
                contentPadding: const EdgeInsets.only(right: 3, left: 3),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: GestureDetector(
                    child: const Text(
                      'More',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/job_details', arguments: {
                        'id': id,
                      });
                    },
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
