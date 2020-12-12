import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@immutable
class UserRole {
  const UserRole._(this._role);

  static const user = UserRole._('user');
  static const owner = UserRole._('owner');
  static const admin = UserRole._('admin');

  @override
  String toString() => _role;

  const UserRole.fromString(String role) : this._(role);

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType == String) return _role == other;
    if (other.runtimeType == runtimeType) return _role == other._role;

    return false;
  }

  @override
  int get hashCode => _role.hashCode;

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
    role: const UserRole.fromString(''),
  );

  final String id;
  final String email;
  final String name;
  final UserRole role;
}

@FunctionalData()
class OtherUserIdentity extends $OtherUserIdentity {
  OtherUserIdentity({
    @required this.id,
    @required this.name,
    @required this.role,
  });

  OtherUserIdentity.empty()
      : this(
    id: '',
    name: '',
    role: const UserRole.fromString(''),
  );

  final String id;
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
    @required this.totalReviews,
  });

  final String id;
  final String name;
  final String address;
  final double averageRating;
  final int totalReviews;
}

@FunctionalData()
class ReviewIdentity extends $ReviewIdentity {
  ReviewIdentity({
    @required this.id,
    @required this.user,
    @required this.restaurantId,
    @required this.rating,
    @required this.visitDate,
    @required this.comment,
  })  : assert(id != null),
        assert(user != null),
        assert(restaurantId != null),
        assert(rating != null),
        assert(visitDate != null),
        assert(comment != null);

  final String id;
  final OtherUserIdentity user;
  final String restaurantId;
  final int rating;
  final DateTime visitDate;
  final Optional<String> comment;
}
