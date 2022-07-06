import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/api/response/product_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/component/admin/form/label_component.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormProduct extends StatefulWidget {
  const FormProduct({Key? key}) : super(key: key);

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final _formKey = GlobalKey<FormState>();
  List<XFile> imageList = [];
  List<String> variant = [];
  List<int> priceVariant = [];
  List<String> priceVariantString = [];
  List<int> indexVariant = [];
  List<String> indexVariantString = [];
  bool isLoading = false;
  bool isEditable = true;
  final ImagePicker _picker = ImagePicker();

  var variantController = TextEditingController();
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var productDurableController = TextEditingController();
  var weightController = TextEditingController();
  var temperatureStorageController = TextEditingController();
  var indexController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                      label: "Nama Produk",
                      child: TextFormField(
                        enabled: isEditable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Kolom tidak boleh kosong";
                          }
                          return null;
                        }),
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nama Produk',
                          hintStyle: const TextStyle(color: Colors.black54),
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                      label: "Berat Produk (L)",
                      child: TextFormField(
                        enabled: isEditable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Kolom tidak boleh kosong";
                          }
                          return null;
                        }),
                        controller: weightController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Ex: 1',
                          hintStyle: const TextStyle(color: Colors.black54),
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                      label: "Suhu Penyimppanan (Celcius)",
                      child: TextFormField(
                        enabled: isEditable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Kolom tidak boleh kosong";
                          }
                          return null;
                        }),
                        controller: temperatureStorageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Cth: 27',
                          hintStyle: const TextStyle(color: Colors.black54),
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                      label: "Masa Berlaku Produk (hari)",
                      child: TextFormField(
                        enabled: isEditable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Kolom tidak boleh kosong";
                          }
                          return null;
                        }),
                        controller: productDurableController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Cth: 10',
                          hintStyle: const TextStyle(color: Colors.black54),
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                    label: "Variasi",
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              enabled: isEditable,
                              validator: ((value) {
                                if (variant.isEmpty) {
                                  return "Kolom tidak boleh kosong";
                                }
                                return null;
                              }),
                              controller: variantController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Cth: Original',
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                              ),
                            )),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (variantController.text.isNotEmpty) {
                                      String value =
                                          variantController.text.toString();
                                      setState(() {
                                        variant.add(value);
                                        variantController.text = "";
                                      });
                                    }
                                  },
                                  child: const FaIcon(FontAwesomeIcons.plus)),
                            )
                          ],
                        ),
                        ...variant
                            .asMap()
                            .map((key, value) => MapEntry(
                                key,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 57, 171, 216),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            setState(() {
                                              variant.removeAt(key);
                                            });
                                          },
                                          child: const FaIcon(
                                              FontAwesomeIcons.trash)),
                                    ],
                                  ),
                                )))
                            .values
                            .toList()
                      ],
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                    label: "Harga Varian (Sesuai urutan)",
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              enabled: isEditable,
                              validator: ((value) {
                                if (priceVariant.isEmpty) {
                                  return "Kolom tidak boleh kosong";
                                }
                                return null;
                              }),
                              controller: priceController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Cth: 10000',
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                              ),
                            )),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (priceController.text.isNotEmpty) {
                                      int value = int.parse(
                                          priceController.text.toString());
                                      setState(() {
                                        priceVariant.add(value);
                                        priceController.text = "";
                                      });
                                    }
                                  },
                                  child: const FaIcon(FontAwesomeIcons.plus)),
                            )
                          ],
                        ),
                        ...priceVariant
                            .asMap()
                            .map((key, value) => MapEntry(
                                key,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 57, 171, 216),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        NumberFormat.simpleCurrency(
                                                locale: "IDR", decimalDigits: 2)
                                            .format(value),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            setState(() {
                                              priceVariant.removeAt(key);
                                            });
                                          },
                                          child: const FaIcon(
                                              FontAwesomeIcons.trash)),
                                    ],
                                  ),
                                )))
                            .values
                            .toList()
                      ],
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: LabelComponent(
                      label: "Susunan Gambar Variasi (mulai dengan 0)",
                      child: TextFormField(
                        enabled: isEditable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Kolom tidak boleh kosong";
                          }
                          return null;
                        }),
                        controller: indexController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Cth: 0,2,1',
                          hintStyle: const TextStyle(color: Colors.black54),
                        ),
                      ))),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text("Gambar variasi")),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...imageList.map((e) => Image.file(
                        File(e.path),
                        // width: 120,
                        height: 140,
                      ))
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    await onImageButtonPressed();
                  },
                  child: const FaIcon(FontAwesomeIcons.camera)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await createNewProduct();
                          setState(() {
                            isLoading = false;
                            isEditable = true;
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 228, 169, 8)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: const [
                                Text("Tambahkan Produk"),
                                FaIcon(FontAwesomeIcons.plus)
                              ],
                            ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createNewProduct() async {
    setState(() {
      isLoading = true;
      isEditable = false;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(prefToken)!;
      String refresh = prefs.getString(prefRefresh)!;
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final client = RestClient(dio);
      List<File> variantImage = [...imageList.map((e) => File(e.path))];
      indexVariant = [
        ...indexController.text.split(",").map((e) => int.parse(e))
      ];
      indexVariantString = indexController.text.split(",");
      priceVariantString = [...priceVariant.map((e) => e.toString())];
      print(priceVariant[0]);
      print(indexVariant[0]);
      ProductSingleResponse response = await client.createProduct(
          variantImage,
          nameController.text,
          int.parse(productDurableController.text),
          int.parse(weightController.text),
          int.parse(temperatureStorageController.text),
          variant,
          priceVariantString,
          indexVariantString);
      List<Product> products = [...ViewModels.getState("products")];
      products.add(response.data);
      ViewModels.ctrlState.sink.add([
        {"name": "products", "value": products}
      ]);
      Widget continueButton = TextButton(
        child: const Text("Ok"),
        onPressed: () {
          setState(() {
            clearForm();
            Navigator.of(context).pop();
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Success to create"),
        content: Text("Berhasil menambahkan ${response.data.name}"),
        actions: [
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } on DioError catch (e) {
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Try Again"),
        onPressed: () async {
          Navigator.of(context).pop();
          await createNewProduct();
          setState(() {
            isLoading = false;
            isEditable = true;
          });
        },
      );
      String message = e.message;
      if (e.response!.statusCode == 400) {
        message = "Nama produk sudah ada atau ada kolom kosong";
      }

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("AlertDialog"),
        content: Text(message),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void clearForm() {
    setState(() {
      variantController.text = "";
      priceController.text = "";
      nameController.text = "";
      productDurableController.text = "";
      weightController.text = "";
      temperatureStorageController.text = "";
      indexController.text = "";
      variant = [];
      priceVariant = [];
      indexVariant = [];
      imageList = [];
    });
  }

  Future<void> onImageButtonPressed() async {
    final List<XFile>? pickedFileList = await _picker.pickMultiImage();
    if (pickedFileList != null) {
      setState(() {
        imageList = pickedFileList;
      });
      print(pickedFileList.length);
    }
  }
}
