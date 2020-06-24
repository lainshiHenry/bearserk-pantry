class ShoppingListItem {
  bool isExpanded;
  String itemName;
  int quantity;
  String storeName;

  ShoppingListItem(
      {this.itemName, this.quantity, this.storeName, this.isExpanded = false});
}
