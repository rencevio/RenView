import 'package:common_state/common_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../communicator.dart';

List<Middleware<State>> communicatorMiddleware<State>({
  @required Communicator communicator,
}) =>
    [
      (Store<State> store, dynamic action, NextDispatcher next) {
        if (action is LoginAction) {
          communicator.login(
            email: action.email,
            password: action.password,
            onSuccess: ({user, token}) => store.dispatch(LoginSuccessfulAction(
              userIdentity: UserIdentity(
                id: user.id,
                email: user.name,
                name: user.email,
                role: UserRole.fromString(user.role),
              ),
              token: token,
            )),
            onError: (reason) => store.dispatch(LoginFailedAction(reason: reason)),
          );
        } else if (action is RegisterAction) {
          communicator.register(
            name: action.name,
            isOwner: action.isOwner,
            email: action.email,
            password: action.password,
            onSuccess: () => store.dispatch(RegistrationSuccessfulAction()),
            onError: () => store.dispatch(RegistrationFailedAction()),
          );
        } else if (action is FetchRestaurantsForUserAction) {
          _fetchRestaurants(communicator: communicator, dispatcher: store.dispatch);
        } else if (action is FetchRestaurantsForOwnerAction) {
          _fetchRestaurants(ownerId: action.ownerId, communicator: communicator, dispatcher: store.dispatch);
        }

        next(action);
      },
    ];

void _fetchRestaurants({
  @required Communicator communicator,
  @required void Function(dynamic) dispatcher,
  String ownerId,
}) =>
    communicator.fetchRestaurants(
      ownerId: ownerId,
      onSuccess: (restaurants) => dispatcher(
        RestaurantsFetchedAction(
          restaurants: restaurants.restaurants
              .map(
                (r) => RestaurantIdentity(
                  id: r.id,
                  address: r.address,
                  name: r.name,
                  averageRating: r.averageRating,
                ),
              )
              .toList(growable: false),
        ),
      ),
      onError: () {
        print('Restaurant fetch failed!');
      },
    );
