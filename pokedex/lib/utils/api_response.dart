class ApiResponse<T> {
  Status status;
  late T data;
  late String msg;

  ApiResponse.loading(this.msg) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.msg) : status = Status.error;

  ApiResponse.nextLoading(this.msg) : status = Status.nextLoading;

  @override
  String toString() {
    return "Status: $status\n Msg: $msg\n Data: $data";
  }
}

enum Status { loading, completed, error, nextLoading }
