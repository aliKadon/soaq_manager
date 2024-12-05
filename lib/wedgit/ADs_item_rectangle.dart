import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/http_providers.dart';

class ADsItemRectangle extends StatelessWidget {
  final String image_url;
  final String id;
  final int index;

  ADsItemRectangle(this.image_url,this.id,this.index);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HttpProviders>(context);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.network(image_url,fit: BoxFit.scaleDown),
          ),
          title: Text('AD Number ${index + 1}'),
          // subtitle: Text(job_name),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.cyan,
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
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                provider.deleteADs(id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}