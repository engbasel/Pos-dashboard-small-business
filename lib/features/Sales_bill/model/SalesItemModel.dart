class SalesItem {
  SalesItem(
      this.name, this.quantity, this.unitPrice, this.discount, this.itemID)
      : total = quantity * unitPrice - discount;

  final String name;
  final int quantity;
  final double unitPrice;
  final double discount;
  late final double total;
  final int itemID;
}
