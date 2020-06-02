import 'package:flutter/material.dart';

class ItemArgs {
  String barcode;
  String productName;
  String productBrand;
  int itemQuantity;
  String storageLocation;
  String purchaseStoreName;

  ItemArgs({
    this.barcode,
    this.productName,
    this.productBrand,
    this.itemQuantity,
    this.storageLocation,
    this.purchaseStoreName,
  });
}
