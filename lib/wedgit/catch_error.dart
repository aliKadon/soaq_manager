import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';

class CatchError extends StatelessWidget {
  final err;

  CatchError(this.err);

  @override
  Widget build(BuildContext context) {
    return err.toString() ==
            'Failed host lookup: \'database-job-api.herokuapp.com\''
        ? AlertDialog(
            title: const Text('An Error Occurred'),
            content:
                const Text('No internet connection please reconnect and RETRY.',style: TextStyle(fontWeight: FontWeight.w500)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
              TextButton(
                onPressed: () {
                  print(err.message);
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllJobs();
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllAdvertising();
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllImageType()
                      .then(
                        (value) => Navigator.of(context).pop(),
                      );
                },
                child: const Text('RETRY'),
              ),
            ],
          )
        : AlertDialog(
            title: const Text('An Error Occurred'),
            content: Text(err.message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
              TextButton(
                onPressed: () {
                  print(err.message);
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllJobs();
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllAdvertising();
                  Provider.of<HttpProviders>(context, listen: false)
                      .getAllImageType()
                      .then(
                        (value) => Navigator.of(context).pop(),
                      );
                },
                child: const Text('RETRY'),
              ),
            ],
          );
  }
}
