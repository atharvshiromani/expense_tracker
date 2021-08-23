class ExpCategory {
  String category;
  int expense;

  ExpCategory(this.category, this.expense);
  Map<String, dynamic> toJson() => {
        'Category': category,
        'Amount': expense,
      };

  ExpCategory.fromMap(Map<String, dynamic> parseJson)
      : category = parseJson['Category'].toString(),
        expense = parseJson['Amount'];
}
