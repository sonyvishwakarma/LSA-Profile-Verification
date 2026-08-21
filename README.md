# Digivir - LSA Profile Verification Gate

A Flutter mobile application component built for the Digivir Developer Assessment. This application enforces strict data lineage, fail-closed security logic, UI friction tracking, and cryptographic header injection before submitting verification requests.


## 📸 Features

| Feature              | Description                                                         | State             |
| Valid Verification   | All required lineage parameters present. Metadata headers injected. | 🟢 200 SUCCESS    |
| Fail-Closed Gate     | Missing `predecessor_id` halts execution before network request.    | 🔴 SECURITY HALT |
| UI Friction Tracking | Monitored field detects typing hesitation exceeding 5 seconds.      | 🟠 UI WARNING     |


##  Architecture & Component Design

The project follows a modular architecture adhering to the **Byt Component Standard**:

```text
lib/
├── models/
│   └── lsa_verification_payload.dart   # Immutable payload model with JSON serialization
├── services/
│   └── security_service.dart          # Fail-closed checks, trace UUID & SHA-256 generation
├── widgets/
│   ├── byt_header_widget.dart         # Stateless header block
│   ├── byt_friction_textfield.dart    # Monitored field with 5s hesitation timer
│   └── byt_lineage_textfield.dart     # Data lineage input field (predecessor_id)
└── screens/
    └── lsa_profile_verification_screen.dart # Main screen orchestrating logic & dynamic status UI

## Setup and Installation Instructions
Prerequisites
-> Flutter SDK (>=3.0.0)
-> Dart SDK (>=3.0.0)
-> Android Studio / VS Code with Flutter extension

## How to Test (Demo Walkthrough)
To verify all system features during testing or video demonstration:

Test Case 1: Valid Submission (Success)
- Fill out Full Name: John Doe
- Fill out LSA License Number: LSA-99201
- Fill out Predecessor ID: PRE-88102-XYZ
- Tap SUBMIT VERIFICATION.
>>> Result: Green status box showing SUCCESS [HTTP 200] with dynamically generated trace_id and logic_hash.

Test Case 2: Fail-Closed Enforcement (Missing Lineage)
- Fill out Full Name and LSA License Number.
- Leave Predecessor ID empty.
- Tap SUBMIT VERIFICATION.
>>> Result: Red status box displaying FAIL-CLOSED ERROR: Missing Data Lineage Parameter. Execution halted. (No API call is fired).

Test Case 3: UI Friction Detection (Hesitation Event)
- Focus on LSA License Number.
- Type a single character (e.g., L).
- Pause typing and wait for 5 seconds.
>>> Result: Orange status box displaying LOG [UI Friction Event]: User hesitation detected (>5s stall).

## Dependencies Used:
- crypto: For generating SHA-256 logic_hash strings.
- uuid: For generating dynamic trace_id request headers.
- http: For structured network requests and metadata injection.
