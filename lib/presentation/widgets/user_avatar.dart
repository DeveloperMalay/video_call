import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserAvatar extends StatelessWidget {
  final String? displayName;
  final String? photoURL;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;

  const UserAvatar({
    super.key,
    this.displayName,
    this.photoURL,
    this.size = 100,
    this.backgroundColor,
    this.textColor,
    this.textSize,
  });

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'U';
    
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words.first[0]}${words.last[0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words.first[0].toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(displayName);
    final avatarSize = size;
    final fontSize = textSize ?? avatarSize * 0.4;
    final bgColor = backgroundColor ?? const Color(0xFF667eea);
    final fgColor = textColor ?? Colors.white;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: photoURL != null && photoURL!.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: photoURL!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildInitialsWidget(
                  initials,
                  fontSize,
                  fgColor,
                ),
                errorWidget: (context, url, error) => _buildInitialsWidget(
                  initials,
                  fontSize,
                  fgColor,
                ),
              ),
            )
          : _buildInitialsWidget(initials, fontSize, fgColor),
    );
  }

  Widget _buildInitialsWidget(String initials, double fontSize, Color textColor) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}