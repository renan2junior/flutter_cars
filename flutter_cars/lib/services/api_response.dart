class ApiResponse<T> {
  bool ok;
  T result;
  String msg;

  ApiResponse.ok({this.result, this.msg}){
    ok = true;
  }

  ApiResponse.error(this.msg){
    ok = false;
  }

}