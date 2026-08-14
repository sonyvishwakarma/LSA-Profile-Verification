import 'package:flutter/material.dart';
// loading custom byt components
import '../widgets/byt_header_widget.dart';
import '../widgets/byt_friction_textfield.dart';
import '../widgets/byt_lineage_textfield.dart';
import '../services/security_service.dart';

class LsaProfileVerificationScreen extends StatefulWidget {
  const LsaProfileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<LsaProfileVerificationScreen> createState() =>
      _LsaProfileVerificationScreenState();
}

class _LsaProfileVerificationScreenState extends State<LsaProfileVerificationScreen> {
  // variables for users current input text
  String? _fullName;
  String? _lsaLicenseNumber;
  String? _predecessorId;

  // variable to store message(displayed at bottom of screen)
  String _statusLog = "System initialized. Ready for submission.";

  // check if app is currently in a fail-closed system
  bool _isErrorState = false;

  // ui friction event for >5 is detected or not
  bool _frictionWarning = false;

  // when user stalls for >5 on license input field
  void _onFrictionLogged() {
    setState(() {
      _frictionWarning = true;
      _statusLog =
      "LOG [UI Friction Event]: User hesitation detected (>5s stall on LSA License input).";
    });
  }


  Future<void> _handleSubmission() async {
    // reset state and ui
    setState(() {
      _frictionWarning = false; // clears orange friction warning
      _isErrorState = false; // clears red error
      _statusLog = "Validating compliance and security constraints..."; // updates ui text
    });

    try {
      // calls application ui async
      final response = await SecurityService.submitVerification(
        predecessorId: _predecessorId,
        lsaLicenseNumber: _lsaLicenseNumber,
        fullName: _fullName,
      );

      // success message - if all checks pass and api returns
      // output uuid and logic_hash on screen
      setState(() {
        _isErrorState = false;
        _statusLog =
        "SUCCESS [HTTP ${response.statusCode}]: Verified!\nHeaders Injected:\ntrace_id: ${response.headers['trace_id']}\nlogic_hash: ${response.headers['logic_hash']}";
      });
    }
    // catch expected security halts
    on SecurityException catch (e) {
      setState(() {
        _isErrorState = true;
        _statusLog = e.message;
      });
    }
    // catches any other problems - system errors
    catch (e) {
      setState(() {
        _isErrorState = true;
        _statusLog = "FAIL-CLOSED ERROR: Unexpected execution exception: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LSA Profile Verification'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BytHeaderWidget(
              title: 'Digivir Verification Gate',
              subtitle:
              'Stateless component enforcing lineage, fail-closed safety, and trace injection.',
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              onChanged: (val) => _fullName = val,
            ),

            const SizedBox(height: 16),
            BytFrictionTextField(
              label: 'LSA License Number (Monitored Field)',
              onChanged: (val) => _lsaLicenseNumber = val,
              onFrictionDetected: _onFrictionLogged,
            ),

            const SizedBox(height: 16),
            BytLineageTextField(
              label: 'Predecessor ID (Data Lineage)',
              onChanged: (val) => _predecessorId = val,
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),

              onPressed: _handleSubmission,
              child: const Text('SUBMIT VERIFICATION',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _isErrorState
                    ? Colors.red.shade50
                    : (_frictionWarning
                    ? Colors.orange.shade50
                    : Colors.green.shade50),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: _isErrorState
                      ? Colors.red.shade400
                      : (_frictionWarning
                      ? Colors.orange.shade400
                      : Colors.green.shade400),
                ),
              ),
              child: Text(
                _statusLog,
                style: TextStyle(
                  color: _isErrorState
                      ? Colors.red.shade900
                      : (_frictionWarning
                      ? Colors.orange.shade900
                      : Colors.green.shade900),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}