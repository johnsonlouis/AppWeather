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
    /// Feels Like
    internal static let feelslike = L10n.tr("AppWeather-localizable", "detail.feelslike")
    /// Humidity
    internal static let humidity = L10n.tr("AppWeather-localizable", "detail.humidity")
    /// Pressure
    internal static let pressure = L10n.tr("AppWeather-localizable", "detail.pressure")
    /// Details
    internal static let title = L10n.tr("AppWeather-localizable", "detail.title")
    /// Wind
    internal static let wind = L10n.tr("AppWeather-localizable", "detail.wind")
    internal enum Max {
      /// Maximum
      internal static let temperature = L10n.tr("AppWeather-localizable", "detail.max.temperature")
    }
    internal enum Min {
      /// Minimum
      internal static let temperature = L10n.tr("AppWeather-localizable", "detail.min.temperature")
    }
  }

  internal enum Home {
    /// Home
    internal static let title = L10n.tr("AppWeather-localizable", "home.title")
    /// Today
    internal static let today = L10n.tr("AppWeather-localizable", "home.today")
    internal enum Detail {
      /// See more
      internal static let button = L10n.tr("AppWeather-localizable", "home.detail.button")
    }
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
