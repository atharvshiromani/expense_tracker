class Expense {
  String category;
  String expName;
  int day;
  int expense;

  Expense(this.category, this.expName, this.day, this.expense);
  Map<String, dynamic> toJson() => {
        'Category': category,
        'Expense': expName,
        'Amount': expense,
        'Date': day,
      };

  factory Expense.fromJson(Map<String, dynamic> parseJson) {
    return Expense(
      parseJson['Category'].toString(),
      parseJson['Expense'],
      parseJson['Amount'],
      parseJson['Date'],
    );
  }
}
