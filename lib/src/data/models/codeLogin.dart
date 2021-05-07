
class CodeLogin {
    CodeLogin({
        this.token,
        this.rol,
        this.id,
    });

    String token;
    String rol;
    String id;

    factory CodeLogin.fromJson(Map<String, dynamic> json) => CodeLogin(
        token: json["token"],
        rol: json["rol"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "rol": rol,
        "id": id,
    };
}