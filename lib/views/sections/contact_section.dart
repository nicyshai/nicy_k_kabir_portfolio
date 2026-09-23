import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/profile_model.dart';
import '../../services/launcher_service.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;

  const ContactSection({super.key, required this.profile, required this.socialLinks});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    // No backend is wired up in this static portfolio, so submitting
    // composes a pre-filled email to the developer instead of silently
    // discarding the message.
    final subject = 'Portfolio inquiry from ${_nameController.text}';
    final body = 'From: ${_nameController.text} (${_emailController.text})\n'
        'Phone: ${_phoneController.text}\n\n${_messageController.text}';
    LauncherService.open(
      'mailto:${widget.profile.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    setState(() => _submitted = true);
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secContact),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Contact',
            title: 'Let\'s build something together',
            subtitle: 'Have a project in mind or an opportunity to discuss? Reach out.',
          ),
          const SizedBox(height: 36),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _ContactDetails(profile: widget.profile, socialLinks: widget.socialLinks),
              ),
              SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 32 : 0),
              Expanded(flex: 3, child: _buildForm(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _field(controller: _nameController, label: 'Name', hint: 'Your full name',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null),
            const SizedBox(height: 16),
            _field(
              controller: _emailController,
              label: 'Email',
              hint: 'you@example.com',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Please enter your email';
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
                return ok ? null : 'Please enter a valid email';
              },
            ),
            const SizedBox(height: 16),
            _field(
                controller: _phoneController,
                label: 'Phone (optional)',
                hint: '+91 00000 00000',
                required: false),
            const SizedBox(height: 16),
            _field(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me about your project...',
              maxLines: 5,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter a message' : null,
            ),
            const SizedBox(height: 24),
            GradientButton(
              label: 'Send Message',
              icon: Icons.send_rounded,
              onPressed: _submit,
            ),
            if (_submitted) ...[
              const SizedBox(height: 14),
              Text(
                'Your email app should now be open with your message ready to send.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.brandCyan),
              ).animate().fadeIn(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.brandCyan, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactDetails extends StatelessWidget {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;
  const _ContactDetails({required this.profile, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    final items = <_ContactItem>[
      _ContactItem(Icons.email_rounded, 'Email', profile.email,
          () => LauncherService.openEmail(profile.email)),
      _ContactItem(Icons.phone_rounded, 'Phone', profile.phone,
          () => LauncherService.openPhone(profile.phone)),
      if (profile.location.isNotEmpty)
        _ContactItem(Icons.location_on_rounded, 'Location', profile.location, null),
      if (socialLinks.github != null)
        _ContactItem(Icons.code_rounded, 'GitHub', 'View profile',
            () => LauncherService.open(socialLinks.github!)),
      if (socialLinks.linkedin != null)
        _ContactItem(Icons.business_center_rounded, 'LinkedIn', 'View profile',
            () => LauncherService.open(socialLinks.linkedin!)),
      if (socialLinks.whatsapp != null)
        _ContactItem(Icons.chat_rounded, 'WhatsApp', 'Message me',
            () => LauncherService.openWhatsApp(socialLinks.whatsapp!)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: AppColors.brandGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.label, style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.value, style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  _ContactItem(this.icon, this.label, this.value, this.onTap);
}
