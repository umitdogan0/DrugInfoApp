import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/Application/Services/user_drug_service.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/models/activeIngredientModel.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:drug_info_app/models/openfdaModel.dart';
import 'package:drug_info_app/models/packagingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  DrugModel? _success;
  List<DrugModel>? _successList = [];
  final IDrugService _drugService;
  final IUserDrugService _userDrugService;
  HomeCubit(IDrugService drugService, IUserDrugService userDrugService, userId,
      context)
      : _drugService = drugService,
        _userDrugService = userDrugService,
        super(HomeCubitState()) {
    if (state.isSearch == false) {
      getSearchedDrugs(context, userId);
    }
  }

  Future<void> _showMyDialog(
      {required context, required DrugModel drugModel}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text(drugModel.drug_name!)],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _ai({context, List<ActiveIngredientModel>? aim}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              aim == null
                  ? const Text("no information")
                  : Column(
                      children: [
                        Text("Active Ingredients",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: aim.length * 50.0 + 50,
                            width: 500,
                            child: ListView.builder(
                              itemCount: aim.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${aim[index].name!}: ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(aim[index].strength!),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Close"))
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  void _pshow({context, List<PackagingModel>? packModel}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              packModel == null
                  ? const Text("no information")
                  : Column(
                      children: [
                        Text("Packaging",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: packModel.length * 50.0 + 50,
                            width: 500,
                            child: ListView.builder(
                              itemCount: packModel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${packModel[index].description!} ",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Close"))
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

    void _oshow({context, OpenfdaModel? openFda}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              openFda == null
                  ? const Text("no information")
                  : Column(
                      children: [
                        Text("Packaging",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SingleChildScrollView(
                          child: SizedBox(
                            child:Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [ 
                                      Row(
                                        children: [
                                          Text(
                                            "Manufacturer Name : ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Expanded(child: Text(openFda.manufacturer_name?.join(", ") ?? "No Information", overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),
                                       Row(
                                        children: [
                                          Text(
                                            "Orginal Packager : ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Expanded(child: Text(openFda.is_original_packager?[0].toString() ?? "No Information", overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "Pharm Class Moa : ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Expanded(child: Text(openFda.pharm_class_moa?.join(", ") ?? "No Information", overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "Pharm Class Cs : ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Expanded(child: Text(openFda.pharm_class_cs?.join(", ") ?? "No Information", overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "Pharm Class Epc : ",
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Expanded(child: Text(openFda.pharm_class_epc?.join(", ") ?? "No Information", overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                )
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Close"))
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  void bottomSheet({context, required DrugModel drugModel}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  drugModel.drug_name!,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 25),
                )),
                Row(
                  children: [
                    Text(
                      "Drug Name: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.drug_name ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Drug Ndc: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.product_ndc ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Generic Name: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.generic_name ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Labeler Name: ",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                    Expanded(
                        child: Text(
                      drugModel.labeler_name ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Brand Name: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Expanded(
                        child: Text(
                      drugModel.brand_name ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Active Ingredients: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                       child:drugModel.active_ingredients != null ? GestureDetector(
                            onTap: () {
                              _ai(
                                  context: context,
                                  aim: drugModel.active_ingredients);
                            },
                            child: Text(
                              "click",
                              style: GoogleFonts.inter(fontSize: 15),
                            )) : Text("no information")),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Packaging: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    drugModel.packaging != null ?
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              _pshow(
                                  context: context,
                                  packModel: drugModel.packaging);
                            },
                            child: Text(
                              "click",
                              style: GoogleFonts.inter(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ))) : Text("No Information")
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "listing_expiration_date: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.listing_expiration_date ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "openfda: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child:drugModel.openfda != null ? GestureDetector(
                          onTap: () {
                            _oshow(context: context, openFda: drugModel!.openfda!);
                          },
                          child: Text(
                                              "click",
                                              style: GoogleFonts.inter(fontSize: 15),
                                            ),
                        ) : Text("no information")),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "marketing_category: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.marketing_category ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "dosage_form: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.dosage_form ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "spl_id: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.spl_id ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "product_type: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.product_type ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "route: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.route?.join(", ") ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "marketing_start_date: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.marketing_start_date ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "product_id: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.product_id ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "application_number: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.application_number ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "brand_name_base: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.brand_name_base ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "pharm_class: ",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      drugModel.pharm_class?.join(", ") ?? "no information",
                      style: GoogleFonts.inter(fontSize: 15),
                    )),
                  ],
                ),
                SizedBox(height: 7),
                Center(
                  child: ElevatedButton(
                    child: const Text('Close and Save'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getDrugByName(context, String name) async {
    final response = await _drugService.getDrugByName(name: name);
    response.when((success) {
      _success = success;
      // _showMyDialog(context: context, drugModel: _success!);
      bottomSheet(drugModel: _success!, context: context);
      emit(state.copyWith(
          isSuccess: true, isSearch: true, searchData: _success));
    }, (error) {
      emit(state.copyWith(isSuccess: false, isSearch: false, searchData: null));
      CustomSnackBar().show(context, error);
    });
  }

  Future<void> getSearchedDrugs(context, String userId) async {
    final response = await _userDrugService.getAllDrugByUserId(userId);
    response.when((success) => _successList = success,
        (error) => CustomSnackBar().show(context, error));
    emit(state.copyWith(
        isSuccess: true, isSearch: false, searchedData: _successList));
  }

  Future<void> changeTextField() async {
    emit(state.copyWith(isShowTextField: !state.isShowTextField));
  }

  Future<void> changeSearch({required value}) async {
    emit(state.copyWith(isSearch: value));
  }
}
