class University {
  List<dynamic>? university;

  University({this.university});
  factory University.fromDocuments(map) {
    return University(
      university: map['university'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'university': university,
    };
  }
}

class Department {
  List<dynamic>? department;

  Department({this.department});

  factory Department.fromDocuments(map) {
    return Department(
      department: map['department'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'department': department,
    };
  }
}

class ListItemCategory {
  List<dynamic>? itemcategory;

  ListItemCategory({this.itemcategory});

  factory ListItemCategory.fromDocuments(map) {
    return ListItemCategory(
      itemcategory: map['itemcategory'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'itemcategory': itemcategory,
    };
  }
}
