// LsaVerificationPayload -- immutable data model
class LsaVerificationPayload {
  final String predecessorId; // stores the data lineage id
  final String lsaLicenseNumber; // stores users license's number
  final String fullName; // users full name

  LsaVerificationPayload({
    required this.predecessorId,
    required this.lsaLicenseNumber,
    required this.fullName,
  });

  // converting dart variables into key-value pairs for api payload and cryptographic transmission
  Map<String, dynamic> toJson() {
    return {
      'predecessor_id': predecessorId, // server expects snake case not camelCase
      'lsa_license_number': lsaLicenseNumber,
      'full_name': fullName,
    };
  }
}