import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import '../../core/config/app_router.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class JoinCallPage extends StatefulWidget {
  final String? prefilledMeetingId;
  
  const JoinCallPage({
    super.key,
    this.prefilledMeetingId,
  });

  @override
  State<JoinCallPage> createState() => _JoinCallPageState();
}

class _JoinCallPageState extends State<JoinCallPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _joinRoomIdController = TextEditingController();
  final _createFormKey = GlobalKey<FormState>();
  final _joinFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // If meeting ID is provided via deep link, switch to Join tab and prefill
    if (widget.prefilledMeetingId != null) {
      _joinRoomIdController.text = widget.prefilledMeetingId!;
      _tabController.index = 1; // Switch to Join Meeting tab
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _joinRoomIdController.dispose();
    super.dispose();
  }

  String? _validateRoomId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Meeting ID';
    }
    return null;
  }

  String _getCurrentUserName() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'Anonymous User';
  }

  Future<void> _createMeeting() async {
    if (_createFormKey.currentState!.validate()) {
      // Generate unique meeting ID
      final meetingId = const Uuid().v4().substring(0, 8).toUpperCase();
      final callerName = _getCurrentUserName();
      
      // Navigate to video call
      context.go('${AppRouter.webrtcCall}?roomId=$meetingId&isCaller=true&callerName=${Uri.encodeComponent(callerName)}');
      
      // Show meeting created success
      BotToast.showText(
        text: 'Meeting created! ID: $meetingId',
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.green,
      );
    }
  }

  void _joinMeeting() {
    if (_joinFormKey.currentState!.validate()) {
      final meetingId = _joinRoomIdController.text.trim().toUpperCase();
      final callerName = _getCurrentUserName();
      context.go('${AppRouter.webrtcCall}?roomId=$meetingId&isCaller=false&callerName=${Uri.encodeComponent(callerName)}');
    }
  }

  Future<void> _shareMeetingLink() async {
    // Generate meeting ID for sharing
    final meetingId = const Uuid().v4().substring(0, 8).toUpperCase();
    final meetingUrl = 'videocallapp://join/$meetingId';
    
    try {
      await Share.share(
        'Join my video meeting!\n\nMeeting ID: $meetingId\nDirect Link: $meetingUrl\n\nIf you don\'t have the app installed, download it first and then use the meeting ID to join.',
        subject: 'Video Meeting Invitation',
      );
      
      // Also copy to clipboard
      await Clipboard.setData(ClipboardData(text: meetingUrl));
      
      BotToast.showText(
        text: 'Meeting link copied to clipboard!',
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.blue,
      );
    } catch (e) {
      BotToast.showText(
        text: 'Failed to share meeting link',
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.red,
      );
    }
  }

  Widget _buildCreateTab() {
    return Form(
      key: _createFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.add_circle_outline,
            size: 64,
            color: Color(0xFF667eea),
          ),
          const SizedBox(height: 24),
          const Text(
            'Start New Meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667eea),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Create an instant meeting and invite others',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: _createMeeting,
            text: 'Start Meeting',
            isLoading: false,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _shareMeetingLink,
                  icon: const Icon(Icons.share),
                  label: const Text('Share Link'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF667eea),
                    side: const BorderSide(color: Color(0xFF667eea)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade600,
                  size: 20,
                ),
                const SizedBox(height: 8),
                Text(
                  'Your meeting will start instantly with a unique meeting ID that you can share with others.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinTab() {
    return Form(
      key: _joinFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.meeting_room_outlined,
            size: 64,
            color: Color(0xFF667eea),
          ),
          const SizedBox(height: 24),
          const Text(
            'Join Meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667eea),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the meeting ID to join an existing meeting',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CustomTextField(
            controller: _joinRoomIdController,
            label: 'Meeting ID',
            keyboardType: TextInputType.text,
            validator: _validateRoomId,
            textCapitalization: TextCapitalization.characters,
            hintText: 'e.g. ABC12345',
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: _joinMeeting,
            text: 'Join Meeting',
            isLoading: false,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.tips_and_updates_outlined,
                  color: Colors.green.shade600,
                  size: 20,
                ),
                const SizedBox(height: 8),
                Text(
                  'Get the meeting ID from the person who created the meeting or click on a meeting link they shared.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade700,
                  ),
                  textAlign: TextAlign.center,
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
    final currentUser = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${currentUser?.displayName ?? 'User'}'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              icon: Icon(Icons.add),
              text: 'Create Meeting',
            ),
            Tab(
              icon: Icon(Icons.login),
              text: 'Join Meeting',
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            // Create Meeting Tab
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildCreateTab(),
                  ),
                ),
              ),
            ),
            // Join Meeting Tab
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildJoinTab(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}