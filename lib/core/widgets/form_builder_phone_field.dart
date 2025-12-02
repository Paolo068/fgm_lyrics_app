import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_form_field/phone_form_field.dart';

/// A FormBuilder field for phone number input that integrates with flutter_form_builder
class FormBuilderPhoneField extends FormBuilderFieldDecoration<PhoneNumber> {
  final PhoneController? phoneController;
  final bool isCountrySelectionEnabled;
  final bool showFlag;
  final bool showDialCode;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  FormBuilderPhoneField({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    this.phoneController,
    this.isCountrySelectionEnabled = true,
    this.showFlag = false,
    this.showDialCode = true,
    this.hintText = '',
    this.keyboardType = TextInputType.phone,
    this.textInputAction = TextInputAction.done,
    }) : super(
         builder: (FormFieldState<PhoneNumber?> field) {
           final state = field as _FormBuilderPhoneFieldState;

           return PhoneFormField(
             controller: state._effectiveController,
             onChanged: (PhoneNumber? value) {
               field.didChange(value);
             },
             keyboardType: keyboardType,
             textInputAction: textInputAction,
             autovalidateMode:
                 AutovalidateMode.disabled, // Let FormBuilder handle validation
             decoration: state.decoration.copyWith(
               hintText: hintText,
               hintStyle: TextStyle(color: Colors.grey.withAlpha(400)),
               isDense: true,
               errorText: field.errorText,
             ),
             countryButtonStyle: CountryButtonStyle(
               showFlag: showFlag,
               showDialCode: showDialCode,
               showDropdownIcon: false,
             ),
             isCountrySelectionEnabled: isCountrySelectionEnabled,
             countrySelectorNavigator:
                 CountrySelectorNavigator.draggableBottomSheet(
                   searchBoxTextStyle: const TextStyle(
                     fontSize: 17,
                     color: Colors.black87,
                   ),
                   searchBoxDecoration: InputDecoration(
                     hintText: hintText,
                     hintStyle: TextStyle(
                       fontStyle: FontStyle.italic,
                       color: Colors.white.withAlpha(128),
                     ),
                     isDense: true,
                     contentPadding: const EdgeInsets.only(left: 15, top: 10),
                   ),
                   scrollPhysics: const BouncingScrollPhysics(),
                 ),
             enabled: state.enabled,
             validator: null, // Validation is handled by FormBuilder
           );
         },
       );

  @override
  FormBuilderFieldDecorationState<FormBuilderPhoneField, PhoneNumber>
  createState() => _FormBuilderPhoneFieldState();
}

class _FormBuilderPhoneFieldState
    extends
        FormBuilderFieldDecorationState<FormBuilderPhoneField, PhoneNumber> {
  PhoneController? _controller;

  PhoneController get _effectiveController =>
      widget.phoneController ?? _controller!;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.phoneController ??
        PhoneController(
          initialValue:
              widget.initialValue ??
              const PhoneNumber(isoCode: IsoCode.CM, nsn: ""),
        );

    _effectiveController.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(FormBuilderPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.phoneController != oldWidget.phoneController) {
      oldWidget.phoneController?.removeListener(_handleControllerChanged);
      widget.phoneController?.addListener(_handleControllerChanged);

      if (oldWidget.phoneController != null && widget.phoneController == null) {
        _controller = PhoneController(
          initialValue: oldWidget.phoneController!.value,
        );
      }

      if (widget.phoneController != null) {
        setValue(widget.phoneController!.value);
        if (oldWidget.phoneController == null) {
          _controller?.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    final initialValue =
        widget.initialValue ?? const PhoneNumber(isoCode: IsoCode.CM, nsn: "");
    _effectiveController.value = initialValue;
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }
}
