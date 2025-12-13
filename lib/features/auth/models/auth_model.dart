class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignUpRequest {
  final String email;
  final String password;
  final String phone;
  final String? name;
  final String userType;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.phone,
    required this.userType,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'user_type': userType,
      if (name != null) 'name': name,
    };
  }
}

class AuthResponse {
  final bool success;
  final String message;
  final String? token;
  final User? user;

  AuthResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? profileImage;

  User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      phone: json['phone'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profile_image': profileImage,
    };
  }
}
