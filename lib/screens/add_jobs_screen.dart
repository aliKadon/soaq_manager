import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/models/new_jobs.dart';
import 'package:soaqman/providers/http_providers.dart';

import 'home_screen/controller/home_screen_getx_controller.dart';
import 'latest_job_screen.dart';

class AddJobsScreen extends StatefulWidget {
  int? index;
  int? id;
  bool isEditing;

  AddJobsScreen({ this.index, this.id, required this.isEditing});

  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  // controller
  final HomeScreenGetxController _homeScreenGetxController =
      Get.find<HomeScreenGetxController>();

  // var now = new DateTime.now();
  // var formatter = new DateFormat('yyyy-MM-dd');
  // String formattedDate = '';

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _typeArTextEditingController =
      TextEditingController();
  final TextEditingController _typeTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _salaryTextEditingController =
      TextEditingController();
  final TextEditingController _countryImageTextEditingController =
      TextEditingController();
  final TextEditingController _nationalityTextEditingController =
      TextEditingController();



  @override
  void initState() {
    _typeTextEditingController.text = 'Job Type';
    _typeArTextEditingController.text = 'Job Type Arabic';
    _countryTextEditingController.text= 'country name';
    // _homeScreenGetxController.getCountryList(context: context);
    // Provider.of<HttpProviders>(context, listen: false)
    //     .getAllCountriesImageAndName();
    // _homeScreenGetxController.getJobsType(context: context);
    if (widget.isEditing == true ) {
      _homeScreenGetxController.getJobsById(context: context, id: widget.id!);
    }


    super.initState();
    if (widget.isEditing == true) {
      print('===============================1 job id');
      _textEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_description;
      _nameTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_name;
      _typeArTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_type_ar ?? '';
      _typeTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_type;
      _cityTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_city;
      _countryTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_country;
      _emailTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_email;
      _phoneTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_phonenumber;
      _salaryTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_salary;
      _countryImageTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.country_image;
      _nationalityTextEditingController.text =
          _homeScreenGetxController.jobsById[0]!.job_nationality;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _nameTextEditingController.dispose();
    _typeArTextEditingController.dispose();
    _typeTextEditingController.dispose();
    _cityTextEditingController.dispose();
    _countryTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _salaryTextEditingController.dispose();
    _countryImageTextEditingController.dispose();
    _nationalityTextEditingController.dispose();
    super.dispose();
  }

  // late String formattedDate = formatter.format(now);

  final _form = GlobalKey<FormState>();

  IconData iconData = Icons.check_box_outlined;
  String name = 'Job Type';

  String nameAr = 'Job Type Arabic';
  String country_name = 'country name';
  String country_url = 'Country Image';

  // final focus = FocusNode();

  late var new_job = NewJobs(
    job_city: widget.index != null ? _cityTextEditingController.text : "d",
    job_country: widget.index != null ? _countryTextEditingController.text : "",
    job_description: widget.index != null ? _textEditingController.text : "",
    job_duration_inday: "",
    job_email: widget.index != null ? _emailTextEditingController.text : "",
    job_experience: "",
    job_language: "",
    job_name: widget.index != null ? _nameTextEditingController.text : "",
    job_nationality:
        widget.index != null ? _nationalityTextEditingController.text : "",
    job_phonenumber:
        widget.index != null ? _phoneTextEditingController.text : "",
    job_salary: widget.index != null ? _salaryTextEditingController.text : "",
    job_type: widget.index != null ? _typeTextEditingController.text : "",
    country_image:
        widget.index != null ? _countryImageTextEditingController.text : "",
    update: "",
    update_url: "",
    job_name_ar: widget.index != null ? _typeArTextEditingController.text : "",
  );

  void saveItem() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    final newJobs = Provider.of<HttpProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Jobs'),
        actions: [
          SvgPicture.asset(
            'assets/image/2.svg',
            alignment: Alignment.bottomRight,
            width: 50,
            color: Colors.white,
          )
        ],
      ),
      body: GetBuilder<HomeScreenGetxController>(
        builder: (controller) => SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                GFAccordion(
                  // onToggleCollapsed:,
                  contentChild: Container(
                    height: 200,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            title: Text(_homeScreenGetxController.jobsType[index].name),
                            value: _homeScreenGetxController.jobsType[index].name,
                            groupValue: name,
                            secondary: IconButton(
                                onPressed: () {
                                  setState(() {
                                    name = _homeScreenGetxController.jobsType[index].name;
                                    _typeTextEditingController.text = _homeScreenGetxController.jobsType[index].name;
                                  });
                                },
                                icon: const Icon(Icons.ads_click_rounded)),
                            onChanged: (value) {},
                          );
                        },
                        itemCount: _homeScreenGetxController.jobsType.length),
                  ),
                  title: _typeTextEditingController.text,
                ),
                GFAccordion(
                  // onToggleCollapsed:,
                  contentChild: Container(
                    height: 200,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            title: Text(controller.jobsType[index].namear!),
                            value: controller.jobsType[index].namear!,
                            groupValue: nameAr,
                            secondary: IconButton(
                                onPressed: () {
                                  setState(() {
                                    nameAr = controller.jobsType[index].namear!;
                                    _typeArTextEditingController.text = controller.jobsType[index].namear!;
                                  });
                                },
                                icon: const Icon(Icons.ads_click_rounded)),
                            onChanged: (value) {},
                          );
                        },
                        itemCount: controller.jobsType.length),
                  ),
                  title: _typeArTextEditingController.text,
                ),
                GFAccordion(
                  // onToggleCollapsed:,
                  contentChild: Container(
                    height: 200,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            title:
                                Text(controller.countryList[index].country_name),
                            value: controller.countryList[index].country_name,
                            groupValue: country_name,
                            secondary: IconButton(
                                onPressed: () {
                                  setState(() {
                                    country_name = controller.countryList[index].country_name;
                                    _countryTextEditingController.text = controller.countryList[index].country_name;
                                    country_url =
                                        controller.countryList[index].country_url;
                                    _countryImageTextEditingController.text =
                                        controller.countryList[index].country_url;
                                  });
                                },
                                icon: const Icon(Icons.ads_click_rounded)),
                            onChanged: (value) {},
                          );
                        },
                        itemCount: controller.countryList.length),
                  ),
                  title: country_name,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "") {
                        return "please this field required";
                      }
                      return null;
                    },
                    controller: _nameTextEditingController,
                    decoration: InputDecoration(
                      label: Text('Job Name'),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_name = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "" || value == "Job Type Arabic") {
                        return "please this field required";
                      }
                      return null;
                    },
                    controller: _typeArTextEditingController,
                    decoration: InputDecoration(
                      label: Text(nameAr),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_name_ar = widget.index != null ? _typeArTextEditingController.text :nameAr!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "" || value == "Job Type") {
                        return "please this field required";
                      }
                      return null;
                    },
                    controller: _typeTextEditingController,
                    decoration: InputDecoration(
                        label: Text(name),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    // focusNode: focus,
                    onSaved: (newValue) {
                      new_job.job_type = widget.index != null ? _typeTextEditingController.text : name!;

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "") {
                        return "please this field required";
                      }
                      return null;
                    },
                    controller: _cityTextEditingController,
                    decoration: InputDecoration(
                        label: Text('Job City'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_city = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "" || value == "country name") {
                        return "please this field required";
                      }
                      return null;
                    },
                    controller: _countryTextEditingController,
                    decoration: InputDecoration(
                        label: Text(country_name),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_country = widget.index != null ? _countryTextEditingController.text : country_name!;

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        label: const Text('Job Description'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),

                    keyboardType: TextInputType.multiline,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_description = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(
                        label: Text('Job Email'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_email = newValue!;

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _phoneTextEditingController,
                    decoration: InputDecoration(
                        label: Text('Job Phonenumber'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_phonenumber = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _nationalityTextEditingController,
                    decoration: InputDecoration(
                        label: Text('Job Nationality'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_nationality = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _salaryTextEditingController,
                    decoration: InputDecoration(
                        label: Text('Job Salary'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.job_salary = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _countryImageTextEditingController,
                    decoration: InputDecoration(
                        label: Text('country image'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.country_image = widget.index != null ? _countryImageTextEditingController.text : country_url!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('update'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job.update = newValue!;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('app url'),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    // onFieldSubmitted: (value) =>
                    //     FocusScope.of(context).requestFocus(focus),
                    onSaved: (newValue) {
                      new_job = NewJobs(
                          job_city: new_job.job_city,
                          job_country: new_job.job_country,
                          job_description: new_job.job_description,
                          job_duration_inday: new_job.job_duration_inday,
                          job_email: new_job.job_email,
                          job_experience: new_job.job_experience,
                          job_language: new_job.job_language,
                          job_name: new_job.job_name,
                          job_nationality: new_job.job_nationality,
                          job_phonenumber: new_job.job_phonenumber,
                          job_salary: new_job.job_salary,
                          job_type: new_job.job_type,
                          country_image: new_job.country_image,
                          update: new_job.update,
                          update_url: newValue!,
                          job_name_ar: new_job.job_name_ar);
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!_form.currentState!.validate()) return;
                      _form.currentState!.save();
                      saveItem();
                      print("test new job add job screen: ${new_job.job_name} ");
                      print("test index add job screen: ${widget.index} ");
                      if (widget.index == null) {
                        _homeScreenGetxController.addNewJob(context: context, newJobs: new_job);
                        // newJobs.postNewJob(new_job).then((value) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => LatestJobScreen()));
                        // });
                      } else if (widget.index != null) {
                        _homeScreenGetxController.updateJobs(
                            context: context,
                            id: _homeScreenGetxController
                                .listOfJobs[widget.index!].id,
                            newJobs: new_job);
                      }
                    },
                    child: Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
