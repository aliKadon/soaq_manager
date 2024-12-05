import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';

class ContainerJobCategories extends StatefulWidget {
  final String type_name;
  final String categories_image;
  final String name_for_filter;

  ContainerJobCategories(
    this.categories_image,
    this.type_name,
      this.name_for_filter,
  );

  @override
  State<ContainerJobCategories> createState() => _ContainerJobCategoriesState();
}

class _ContainerJobCategoriesState extends State<ContainerJobCategories> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                );
                if (widget.name_for_filter == 'Emarits') {
                  await Provider.of<HttpProviders>(context, listen: false)
                      .getJobByNationalityFun(widget.name_for_filter)
                      .then((value) => isLoading = false)
                      .then((value) => Navigator.of(context).pop())
                      .then(
                        (value) => Navigator.of(context).pushNamed(
                      '/filter_screen',
                      arguments: {
                        'list': widget.name_for_filter,
                      },
                    ),
                  );
                }else {
                  await Provider.of<HttpProviders>(context, listen: false)
                      .getJobByTypeFun(widget.name_for_filter)
                      .then((_) => isLoading = false)
                      .then((_) => Navigator.of(context).pop())
                      .then(
                        (value) => Navigator.of(context).pushNamed(
                      '/filter_screen',
                      arguments: {
                        'list': widget.name_for_filter,
                      },
                    ),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.network(
                    widget.categories_image,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          FittedBox(child: Text(widget.type_name)),
        ],
      ),
    );
  }
}
