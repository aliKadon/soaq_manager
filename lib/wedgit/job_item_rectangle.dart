import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';

class JobItemRectangle extends StatelessWidget {
  final String job_type;
  final String job_name;
  final String job_salary;
  final int id;
  final String cityName;
  final String countryName;

  JobItemRectangle(this.job_type, this.job_name, this.job_salary, this.id,
      this.cityName, this.countryName);

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<HttpProviders>(context);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.work_rounded),
          ),
          title: Text(job_type),
          subtitle: Text(job_name),
          trailing: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amber,
            ),
            // child: Row(
            //   children: [
            //     const Icon(
            //       Icons.more_horiz,
            //       color: Colors.white,
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         provider.deleteJob(id);
            //       },
            //       icon: const Icon(
            //         Icons.delete,
            //         color: Colors.red,
            //       ),
            //     )
            //   ],
            // ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('$cityName, $countryName'),
            ),
            // IconButton(
            //   color: Colors.black,
            //   onPressed: () {
            //     provider.deleteJob(id);
            //   },
            //   icon: const Icon(
            //     Icons.delete,
            //     color: Colors.red,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
