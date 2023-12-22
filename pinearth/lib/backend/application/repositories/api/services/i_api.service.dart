abstract class IApiService {
  Future<ApiResponse> get(String endpoint, {bool requireToken});
  Future<ApiResponse> post(String endpoint, dynamic data, {bool requireToken, bool useFormData, Map<String, dynamic> extraHeader});
  Future<ApiResponse> put(String endpoint, dynamic data, {bool requireToken, bool useFormData, Map<String, dynamic> extraHeader});
  Future<ApiResponse> patch(String endpoint, dynamic data, {bool requireToken, bool useFormData, Map<String, dynamic> extraHeader});
  Future<ApiResponse> delete(String endpoint, {bool requireToken});
}


class ApiResponse {
  ApiResponse({
    bool? status,
    String? message,
    // String? value,
    dynamic data,
    String? token,}){
    _status = status;
    _message = message;
    // _value = value;
    _data = data;
    _token = token;
  }

  ApiResponse.fromJson(dynamic json) {
    print(json);
    _status = json['status'];
    _message = json['message'];
    // _value = json['value'];
    _data = json['data'];
    _token = json['token'];
  }
  bool? _status; 
  String? _message;
  // String? _value;
  dynamic _data;
  String? _token;
  ApiResponse copyWith({  bool? status,
    String? message,
    // String? value,
    dynamic data,
    String? token,
  }) => ApiResponse(  status: status ?? _status,
    message: message ?? _message,
    // value: value ?? _value,
    data: data ?? _data,
    token: token ?? _token,
  );
  bool? get status => _status;
  String? get message => _message;
  // String? get value => _value;
  dynamic get data => _data;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data;
    }
    map['token'] = _token;
    return map;
  }
}