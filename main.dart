import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Central place for the palette. Change these and the whole screen follows.
class AppColors {
  static const teal = Color(0xFF0B4F5C);
  static const marigold = Color(0xFFF2B632);
  static const paper = Color(0xFFF6F7F5);
  static const ink = Color(0xFF16252A);
  static const muted = Color(0xFF6B7C80);
  static const line = Color(0xFFD9E0E1);
  static const track = Color(0xFFE6EBEB);
  static const headerSub = Color(0xFFB7D1D5);
  static const error = Color(0xFFB3261E);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Screens',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.teal,
          primary: AppColors.teal,
        ),
        scaffoldBackgroundColor: AppColors.teal,
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _isLogin = true;
  bool _hidePassword = true;
  bool _hideConfirm = true;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _setMode(bool isLogin) {
    if (_isLogin == isLogin) return;
    final email = _email.text; // keep the email when switching tabs
    _formKey.currentState?.reset(); // clears fields and old error messages
    _email.text = email;
    setState(() => _isLogin = isLogin);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);

    // TODO: replace this delay with your real API / Firebase call.
    await Future.delayed(const Duration(milliseconds: 1400));

    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          _isLogin
              ? 'Logged in as ${_email.text.trim()}'
              : 'Account created for ${_name.text.trim()}',
        ),
      ),
    );
  }

  // ---------- Validators ----------
  String? _validateName(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Enter your full name' : null;

  String? _validateEmail(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Enter your email address';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? v) {
    final value = v ?? '';
    if (value.isEmpty) return 'Enter your password';
    if (!_isLogin && value.length < 8) {
      return 'Use at least 8 characters';
    }
    return null;
  }

  String? _validateConfirm(String? v) =>
      v != _password.text ? 'Passwords do not match' : null;

  // ---------- UI ----------
  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );

    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      prefixIconColor: AppColors.muted,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: AppColors.muted),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: border(AppColors.line),
      enabledBorder: border(AppColors.line),
      focusedBorder: border(AppColors.teal, 2),
      errorBorder: border(AppColors.error),
      focusedErrorBorder: border(AppColors.error, 2),
    );
  }

  Widget _header(bool compact) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.marigold,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.hexagon_rounded, color: AppColors.teal),
              ),
              const SizedBox(width: 12),
              const Text(
                'Your App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Column(
              key: ValueKey(_isLogin),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isLogin ? 'Welcome back' : 'Create your account',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isLogin
                      ? 'Log in to pick up where you left off.'
                      : 'It takes about a minute.',
                  style: const TextStyle(
                    color: AppColors.headerSub,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header collapses while the keyboard is open to save space.
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: keyboardOpen
                  ? const SizedBox(width: double.infinity, height: 12)
                  : _header(keyboardOpen),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.paper,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomSafe),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        children: [
                          _ModeToggle(isLogin: _isLogin, onChanged: _setMode),
                          const SizedBox(height: 24),
                          _buildForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    const gap = SizedBox(height: 14);

    return Form(
      key: _formKey,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_isLogin) ...[
              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                decoration: _fieldDecoration(
                  label: 'Full name',
                  icon: Icons.person_outline,
                ),
                validator: _validateName,
              ),
              gap,
            ],
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: _fieldDecoration(
                label: 'Email address',
                icon: Icons.mail_outline,
              ),
              validator: _validateEmail,
            ),
            gap,
            TextFormField(
              controller: _password,
              obscureText: _hidePassword,
              textInputAction:
                  _isLogin ? TextInputAction.done : TextInputAction.next,
              autofillHints: [
                _isLogin ? AutofillHints.password : AutofillHints.newPassword,
              ],
              onFieldSubmitted: (_) {
                if (_isLogin) _submit();
              },
              decoration: _fieldDecoration(
                label: 'Password',
                icon: Icons.lock_outline,
                suffix: IconButton(
                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                ),
              ),
              validator: _validatePassword,
            ),
            if (!_isLogin) ...[
              gap,
              TextFormField(
                controller: _confirm,
                obscureText: _hideConfirm,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                decoration: _fieldDecoration(
                  label: 'Confirm password',
                  icon: Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(
                      _hideConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _hideConfirm = !_hideConfirm),
                  ),
                ),
                validator: _validateConfirm,
              ),
            ],
            if (_isLogin)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: navigate to your reset-password screen.
                  },
                  child: const Text('Forgot password?'),
                ),
              )
            else
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: _loading ? null : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(_isLogin ? 'Log in' : 'Create account'),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider(color: AppColors.line)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('or', style: TextStyle(color: AppColors.muted)),
                ),
                Expanded(child: Divider(color: AppColors.line)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: hook up Google sign-in.
                },
                icon: const Icon(Icons.g_mobiledata_rounded, size: 30),
                label: const Text('Continue with Google'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.ink,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.line),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (!_isLogin) ...[
              const SizedBox(height: 20),
              const Text(
                'By creating an account you agree to the Terms of Use and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 12.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Two-option switch with a sliding indicator.
class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.isLogin, required this.onChanged});

  final bool isLogin;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.track,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              _tab('Log in', true),
              _tab('Create account', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, bool forLogin) {
    final selected = isLogin == forLogin;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(forLogin),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.teal : AppColors.muted,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
