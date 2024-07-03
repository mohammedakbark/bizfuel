class RequestModel {
  String sendeId;
  String receiverId;
  String? requestId;
  String requestStatus;

  RequestModel(
      {required this.receiverId,
      this.requestId,
      required this.requestStatus,
      required this.sendeId});

  Map<String, dynamic> tojson(id) => {
        "receiverId": receiverId,
        "requestId": id,
        "requestStatus": requestStatus,
        "sendeId": sendeId
      };

  factory RequestModel.fromjosn(Map<String, dynamic> json) {
    return RequestModel(
        receiverId: json["receiverId"] ?? "NA",
        requestId: json["requestId"] ?? "NA",
        requestStatus: json["requestStatus"] ?? "NA",
        sendeId: json["sendeId"] ?? "NA");
  }
}
