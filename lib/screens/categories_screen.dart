import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/providers/http_providers.dart';
import 'package:soaqman/wedgit/container_job_categories.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../preferences/shared_pref_controller.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    Provider.of<HttpProviders>(context, listen: false).getAllImageType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = Provider.of<HttpProviders>(context).getImageType;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(icon: const Icon(Icons.home),onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home_screen');
          },),
          SvgPicture.asset(
            'assets/image/2.svg',
            alignment: Alignment.bottomRight,
            width: 50,
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.7),
          itemCount: imageType.length,
          itemBuilder: (context, index) {
            return SharedPrefController().lang1 == 'ar'
                ? ContainerJobCategories(
                imageType[index].url, imageType[index].namear ?? imageType[index].name,imageType[index].name)
                : ContainerJobCategories(
                imageType[index].url, imageType[index].name,imageType[index].name);
          },
        ),
      ),
    );
  }
}
