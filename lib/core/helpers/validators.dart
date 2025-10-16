import 'package:flutter/material.dart';
import '../l10n/translations/app_localizations.dart';
import '../helpers/regex.dart';

abstract class Validations {
  static String? validateName(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return AppLocalizations.of(context)!.name_is_required;
    } else if (!AppRegExp.isNameValid(name)) {
      return AppLocalizations.of(context)!.name_is_not_valid;
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.email_is_required;
    } else if (!AppRegExp.isEmailValid(email)) {
      return AppLocalizations.of(context)!.email_is_not_valid;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    } else if (!AppRegExp.isPasswordValid(password)) {
      return AppLocalizations.of(context)!.password_is_not_valid;
    }
    return null;
  }

  static String? loginValidatePassword(BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    }
    return null;
  }

  static String? confirmPassword(
    BuildContext context,
    String? newPassword, [
    String? confirmPassword,
  ]) {
    if (newPassword == null || newPassword.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    } else if (newPassword.length < 6) {
      return AppLocalizations.of(
        context,
      )!.password_must_be_at_least_6_characters;
    } else if (confirmPassword != null && newPassword != confirmPassword) {
      return AppLocalizations.of(context)!.passwords_do_not_match;
    }
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppLocalizations.of(context)!.confirm_password_is_required;
    } else if (!AppRegExp.isPasswordValid(confirmPassword)) {
      return AppLocalizations.of(context)!.confirm_password_is_not_valid;
    } else if (password != confirmPassword) {
      return AppLocalizations.of(
        context,
      )!.password_and_confirm_password_must_be_same;
    }
    return null;
  }

  static String? validatePhoneNumber(
    BuildContext context,
    String? phoneNumber,
  ) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return AppLocalizations.of(context)!.phone_number_is_required;
    } else if (!AppRegExp.isPhoneNumberValid(phoneNumber)) {
      return AppLocalizations.of(context)!.phone_number_is_not_valid;
    }
    return null;
  }

  static String? validateRequired(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.this_field_is_required;
    }
    return null;
  }

  static String? validateInternationalPhoneNumber(
    BuildContext context,
    String? phoneNumber,
  ) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return AppLocalizations.of(context)!.phone_number_is_required;
    }

    final internationalPhoneRegex = RegExp(r'^\+\d{7,15}$');

    if (!internationalPhoneRegex.hasMatch(phoneNumber)) {
      return AppLocalizations.of(context)!.enter_phone_with_country_code;
    }

    return null;
  }
}
