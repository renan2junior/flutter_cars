class ApiResponse<T> {
  bool ok;
  T result;
  String msg;

  ApiResponse.ok(this.result){
    ok = true;
  }

  ApiResponse.error(this.msg){
    ok = false;
  }

}