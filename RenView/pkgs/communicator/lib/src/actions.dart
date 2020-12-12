import 'package:common_state/common_state.dart';
import 'package:meta/meta.dart';

import 'api_call_results.dart';

class LoginAction {
  const LoginAction({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}

class LoginFailedAction {
  LoginFailedAction({@required this.reason});

  final LoginFailureReason reason;
}

class LoginSuccessfulAction {
  LoginSuccessfulAction({
    @required this.userIdentity,
    @required this.token,
  });

  final UserIdentity userIdentity;
  final String token;
}

class RegisterAction {
  const RegisterAction({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.isOwner,
  });

  final String name;
  final String email;
  final String password;
  final bool isOwner;
}

class RegistrationFailedAction {}

class RegistrationSuccessfulAction {
  RegistrationSuccessfulAction();
}

class FetchRestaurantsForUserAction {}

class FetchRestaurantsForOwnerAction {
  FetchRestaurantsForOwnerAction({
    @required this.ownerId,
  });

  final String ownerId;
}

class RestaurantsFetchedAction {
  RestaurantsFetchedAction({
    @required this.restaurants,
  });

  final List<RestaurantIdentity> restaurants;
}

class CreateRestaurantAction {
  CreateRestaurantAction({
    @required this.name,
    @required this.address,
  });

  final String name;
  final String address;
}

class RestaurantCreatedAction {
  RestaurantCreatedAction({
    @required this.restaurant,
  });

  final RestaurantIdentity restaurant;
}

class EditRestaurantAction {
  EditRestaurantAction({
    @required this.id,
    this.name,
    this.address,
  }) : assert(name != null || address != null);

  final String id;
  final String name;
  final String address;
}

class DeleteRestaurantAction {
  DeleteRestaurantAction({
    @required this.id,
  });

  final String id;
}

class FetchReviewsForRestaurantAction {
  FetchReviewsForRestaurantAction({
    @required this.restaurantId,
  }) : assert(restaurantId != null);

  final String restaurantId;
}

class ReviewsForRestaurantFetchedAction {
  ReviewsForRestaurantFetchedAction({
    @required this.restaurantId,
    @required this.reviews,
  })  : assert(restaurantId != null),
        assert(reviews != null);

  final String restaurantId;
  final List<ReviewIdentity> reviews;
}
