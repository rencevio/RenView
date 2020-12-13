import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../communicator.dart';
import 'api_call_results.dart';

List<Middleware<State>> communicatorMiddleware<State>({
  @required Communicator communicator,
}) =>
    [
      (Store<State> store, dynamic action, NextDispatcher next) {
        _middleware(store, action, communicator);

        next(action);
      },
    ];

Future<void> _middleware<State>(Store<State> store, dynamic action, Communicator communicator) async {
  if (action is LoginAction) {
    try {
      final result = await communicator.login(
        email: action.email,
        password: action.password,
      );

      store.dispatch(
        LoginSuccessfulAction(
          userIdentity: result.user.identity,
          token: result.token,
        ),
      );
    } on LoginException catch (e) {
      store.dispatch(LoginFailedAction(reason: e.reason));
    }
  } else if (action is RegisterAction) {
    try {
      await communicator.register(
        name: action.name,
        isOwner: action.isOwner,
        email: action.email,
        password: action.password,
      );

      store.dispatch(RegistrationSuccessfulAction());
    } on Exception {
      store.dispatch(RegistrationFailedAction());
    }
  } else if (action is FetchRestaurantsForUserAction) {
    await _fetchRestaurants(communicator: communicator, dispatcher: store.dispatch);
  } else if (action is FetchRestaurantsForOwnerAction) {
    await _fetchRestaurants(ownerId: action.ownerId, communicator: communicator, dispatcher: store.dispatch);
  } else if (action is CreateRestaurantAction) {
    final restaurant = await communicator.createRestaurant(name: action.name, address: action.address);
    store.dispatch(RestaurantCreatedAction(restaurant: restaurant.identity));
  } else if (action is EditRestaurantAction) {
    await communicator.editRestaurant(id: action.id, name: action.name, address: action.address);
  } else if (action is DeleteRestaurantAction) {
    await communicator.deleteRestaurant(id: action.id);
  } else if (action is FetchReviewsForRestaurantAction) {
    try {
      final reviews = await communicator.fetchReviewsForRestaurant(action.restaurantId);

      store.dispatch(
        ReviewsForRestaurantFetchedAction(
          restaurantId: action.restaurantId,
          reviews: reviews.reviews.map((r) => r.identity).toList(growable: false),
        ),
      );
    } on Exception {
      print('Reviews for restaurant fetch failed!');
    }
  } else if (action is CreateReviewAction) {
    final review = await communicator.createReview(
      restaurantId: action.restaurantId,
      rating: action.rating,
      visitDate: action.visitDate,
      comment: action.comment.valueOr(() => null),
    );

    store.dispatch(ReviewCreatedAction(review: review.identity));
  } else if (action is EditReviewAction) {
    await communicator.editReview(
      reviewId: action.reviewId,
      rating: action.rating,
      visitDate: action.visitDate,
      comment: action.comment.valueOr(() => null),
    );
  } else if (action is ReplyToReviewAction) {
    await communicator.replyToReview(reviewId: action.reviewId, reply: action.reply);
  }
}

Future<void> _fetchRestaurants({
  @required Communicator communicator,
  @required void Function(dynamic) dispatcher,
  String ownerId,
}) async {
  try {
    final restaurants = await communicator.fetchRestaurants(ownerId: ownerId);

    dispatcher(
      RestaurantsFetchedAction(
        restaurants: restaurants.restaurants.map((r) => r.identity).toList(growable: false),
      ),
    );
  } on Exception {
    print('Restaurant fetch failed!');
  }
}
