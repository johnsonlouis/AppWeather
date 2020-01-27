// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Alert {
    /// Error when fetching datas.
    internal static let message = L10n.tr("AppWeather-localizable", "alert.message")
    /// Error
    internal static let title = L10n.tr("AppWeather-localizable", "alert.title")
    internal enum Action {
      /// Close
      internal static let title = L10n.tr("AppWeather-localizable", "alert.action.title")
    }
  }

  internal enum Detail {
    /// Details
    internal static let title = L10n.tr("AppWeather-localizable", "detail.title")
  }

  internal enum Home {
    /// Home
    internal static let title = L10n.tr("AppWeather-localizable", "home.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
