class Company {
  final String name;
  final String domain;
  final String logo;

  Company({required this.name, required this.domain, required this.logo});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      domain: json['domain'],
      logo: json['logo'] ?? "https://logo.clearbit.com/flutter.io",
    );
  }
}