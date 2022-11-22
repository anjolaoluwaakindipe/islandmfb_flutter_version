import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {Key? key,
      this.label = "",
      this.hint = "",
      required this.textController,
      this.onChanged,
      this.labelColor,
      this.textInputType,
      this.maxCharacterLength,
      this.hideText = false,
      this.inputFormatters,
      this.suffixIconWidget,
      this.validator,
      this.readOnly = false,
      this.enabled,
      this.suffixIcon,
      this.isPassword = false,
      this.maxLines,
      this.prefixIcon})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController textController;
  final Color? labelColor;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final int? maxCharacterLength;
  final bool hideText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIconWidget;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool? enabled;
  final Widget? suffixIcon;
  final bool isPassword;
  final int? maxLines;
  final Widget? prefixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool passwordvisible = false;
  bool? isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != ""
            ? Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.labelColor ?? blackColor,
                ),
              )
            : Container(
                height: 0,
              ),
              
        widget.label != ""
            ? const SizedBox(
                height: 10,
              )
            : Container(
                height: 0,
              ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: TextFormField(
            keyboardType: widget.textInputType,
            maxLength: widget.maxCharacterLength,
          
            obscureText:
                widget.hideText || (widget.isPassword && !passwordvisible),
            cursorColor: primaryColor,
            cursorWidth: 2,
            enableSuggestions: !isPassword!,
            autocorrect: !isPassword!,
            decoration: InputDecoration(

              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: 10, right: 10, top: 25, bottom: 25),
              prefixIcon: widget.prefixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: widget.hint,
              filled: true,
              errorStyle: const TextStyle(color: primaryColor),
              fillColor: accentColor,
              hoverColor: accentColor,
              suffixIcon: widget.isPassword
                  ? Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: 40,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              passwordvisible = !passwordvisible;
                            });
                          },
                          child: !passwordvisible
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  size: 25,
                                  color: greyColor,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 25,
                                  color: greyColor,
                                ),
                        ),
                      ),
                    )
                  : widget.suffixIconWidget,
            ),
            controller: widget.textController,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
          ),
        ),
      ],
    );
  }
}
