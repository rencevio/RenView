import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

class UserRole {
  const UserRole._(this._role);

  static const user = UserRole._('user');
  static const owner = UserRole._('owner');
  static const admin = UserRole._('admin');

  @override
  String toString() => _role;

  UserRole.fromString(String role) : this._(role);

  final String _role;
}

@FunctionalData()
class UserIdentity extends $UserIdentity {
  UserIdentity({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.role,
  });

  UserIdentity.empty()
      : this(
          id: '',
          email: '',
          name: '',
          role: UserRole.fromString(''),
        );

  final String id;
  final String email;
  final String name;
  final UserRole role;
}

@FunctionalData()
class RestaurantIdentity extends $RestaurantIdentity {
  RestaurantIdentity({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.averageRating,
  });

  final String id;
  final String name;
  final String address;
  final double averageRating;
}
