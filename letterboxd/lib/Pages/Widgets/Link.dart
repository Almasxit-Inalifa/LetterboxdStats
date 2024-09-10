import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatefulWidget {
  final Widget child;
  final String url;
  final HoverConfig hoverConfig;

  const Link({
    super.key,
    required this.child,
    required this.url,
    required this.hoverConfig,
  });

  @override
  _LinkState createState() => _LinkState();
}

class _LinkState extends State<Link> {
  bool _isHovered = false;

  void _launchURL() async {
    if (widget.url != '') {
      final Uri uri = Uri.parse(widget.url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        print('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: _launchURL,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(
            0,
            _isHovered ? widget.hoverConfig.translationYOnHover : 0,
            0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.hoverConfig.hoverColor ?? Colors.transparent
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class HoverConfig {
  final Color? hoverColor;
  final double elevationOnHover;
  final double translationYOnHover;

  HoverConfig({
    this.hoverColor,
    this.elevationOnHover = 0,
    this.translationYOnHover = 0,
  });
}
