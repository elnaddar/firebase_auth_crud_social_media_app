import 'package:flutter/material.dart';

class SmoothColorFilledButton extends StatefulWidget {
  const SmoothColorFilledButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  factory SmoothColorFilledButton.icon({
    Key? key,
    required Widget icon,
    required Widget label,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
  }) {
    return SmoothColorFilledButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          label,
        ],
      ),
    );
  }

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget child;

  @override
  State<SmoothColorFilledButton> createState() =>
      _SmoothColorFilledButtonState();
}

class _SmoothColorFilledButtonState extends State<SmoothColorFilledButton> {
  static const _defaultDuration = Duration(milliseconds: 500);
  static const _defaultBackgroundColor = Colors.grey;
  static const _hoverBackgroundColor = Colors.grey;
  static const _pressedOverlayColor = Colors.grey;
  static const _disabledOverlayColor = Colors.grey;
  static const _foregroundColor = Colors.grey;

  Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).filledButtonTheme.style;
    _backgroundColor ??= buttonTheme?.backgroundColor?.resolve({}) ??
        _defaultBackgroundColor.shade400;

    return MouseRegion(
      onEnter: (_) => _updateBackgroundColor(
          buttonTheme?.backgroundColor?.resolve({MaterialState.hovered}) ??
              _hoverBackgroundColor.shade200),
      onExit: (_) => _updateBackgroundColor(
          buttonTheme?.backgroundColor?.resolve({}) ??
              _defaultBackgroundColor.shade400),
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: _backgroundColor),
        duration: _defaultDuration,
        builder: (context, color, child) {
          final resolvedStyle = _resolveButtonStyle(buttonTheme, color);
          return FilledButton(
            style: resolvedStyle,
            onPressed: widget.onPressed,
            onLongPress: widget.onLongPress,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            clipBehavior: widget.clipBehavior,
            child: widget.child,
          );
        },
      ),
    );
  }

  void _updateBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  ButtonStyle _resolveButtonStyle(ButtonStyle? buttonTheme, Color? color) {
    return widget.style?.copyWith(
          backgroundColor: MaterialStateProperty.all(color),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonTheme?.overlayColor
                      ?.resolve({MaterialState.pressed}) ??
                  _pressedOverlayColor.shade300;
            }
            if (states.contains(MaterialState.disabled)) {
              return buttonTheme?.overlayColor
                      ?.resolve({MaterialState.disabled}) ??
                  _disabledOverlayColor.shade100;
            }
            return null;
          }),
          foregroundColor: widget.style?.foregroundColor ??
              buttonTheme?.foregroundColor ??
              MaterialStateProperty.all(_foregroundColor.shade800),
        ) ??
        ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonTheme?.overlayColor
                      ?.resolve({MaterialState.pressed}) ??
                  _pressedOverlayColor.shade300;
            }
            if (states.contains(MaterialState.disabled)) {
              return buttonTheme?.overlayColor
                      ?.resolve({MaterialState.disabled}) ??
                  _disabledOverlayColor.shade100;
            }
            return null;
          }),
          foregroundColor: buttonTheme?.foregroundColor ??
              MaterialStateProperty.all(_foregroundColor.shade800),
        );
  }
}
