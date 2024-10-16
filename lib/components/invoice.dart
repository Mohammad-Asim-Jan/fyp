class Invoice {
  final String title;
  final List<InvoiceItem> items;

  Invoice(this.title, this.items);
}

class InvoiceItem {
  final String month;
  final int units;
  final double bill;

  InvoiceItem(this.month, this.units, this.bill);
}
