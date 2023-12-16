import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart' show immutable;

final Map<String, AuthError> authErrors = {
  'user-not-found': const UserNotFoundAuthError(),
  'weak-password': const WeakPasswordAuthError(),
  'invalid-credential': const InvalidEmailAuthError(),
  'operation-not-allowed': const OperationNotAllowedAuthError(),
  'email-already-in-use': const EmailAlreadyInUseAuthError(),
  'requires-recent-login': const RequiresRecentLoginAuthError(),
  'no-current-user': const NoCurrentUserAuthError(),
  'network-request-failed': const NetworkFailedError()
};

@immutable 
abstract class AuthError{
  final String title, content;
  const AuthError({required this.title, required this.content});

  factory AuthError.from(FirebaseAuthException exception) =>
    authErrors[exception.code.toLowerCase().trim()] ?? const UnknownAuthError();
}

@immutable 
class UnknownAuthError extends AuthError{
  const UnknownAuthError(): 
    super(title: 'Authentication Error', content: 'Unknown Authentication Error!',);
}

@immutable 
class NoCurrentUserAuthError extends AuthError{
  const NoCurrentUserAuthError(): 
    super(title: 'No Current User!', content: 'No Current User With This Information was found.');
}

@immutable 
class RequiresRecentLoginAuthError extends AuthError{
  const RequiresRecentLoginAuthError(): 
    super(title: 'Requires Recent Login!', content: 'Please, logout and log back in to perform this operation.');
}

@immutable 
class OperationNotAllowedAuthError extends AuthError{
  const OperationNotAllowedAuthError(): 
    super(title: 'Operation Not Allowed!', content: 'You cannot perform this operation at this moment.');
}

@immutable 
class UserNotFoundAuthError extends AuthError{
  const UserNotFoundAuthError(): 
    super(title: 'User Not Found!', content: 'This User was not found on the server.');
}

@immutable 
class WeakPasswordAuthError extends AuthError{
  const WeakPasswordAuthError(): 
    super(title: 'Weak Password!', content: 'Length of password is too short.');
}

@immutable 
class InvalidEmailAuthError extends AuthError{
  const InvalidEmailAuthError(): 
    super(title: 'User not Found!', content: 'This User was not found. Please enter a valid one.');
}

@immutable 
class EmailAlreadyInUseAuthError extends AuthError{
  const EmailAlreadyInUseAuthError(): 
    super(title: 'Email Already In Use', content: 'This email is already registered. Please enter another.');
}

@immutable 
class NetworkFailedError extends AuthError{
  const NetworkFailedError()
    :super(title: 'Network Request Failed', content: 'Please Check Your Network Connenction and Try Again.');
}
