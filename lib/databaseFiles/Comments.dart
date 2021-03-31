class Comments {
  int uid;
  String comm;

  Comments({this.uid, this.comm});

  Map<String, dynamic> toJson() {
    return {'author': this.uid, 'description': this.comm};
  }
}
