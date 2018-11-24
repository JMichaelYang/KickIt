import 'package:kickit/apis/api_relationship.dart';

/// Two different sources for where to get relationship data.
enum RelationshipFlavor {
  REMOTE,
  LOCAL,
}

/// Relationship dependency injector.
class InjectorRelationship {
  /// A single instance of the injector.
  static final InjectorRelationship _instance =
      new InjectorRelationship._internal();

  /// The flavor to use when generating a new [ApiRelationshipBase].
  static RelationshipFlavor _flavor;

  /// Internal constructor for the default value.
  InjectorRelationship._internal();

  /// Returns the current instance of [InjectorRelationship].
  factory InjectorRelationship() {
    return _instance;
  }

  /// Configures [InjectorRelationship] to use the given flavor.
  static void configure(RelationshipFlavor flavor) {
    _flavor = flavor;
  }

  /// Produces a new [ApiRelationshipBase] based on the current flavor.
  ApiRelationshipBase get relationshipApi {
    switch (_flavor) {
      case RelationshipFlavor.LOCAL:
        return new ApiRelationshipMock();
        break;
      default:
        return new ApiRelationship();
        break;
    }
  }
}
