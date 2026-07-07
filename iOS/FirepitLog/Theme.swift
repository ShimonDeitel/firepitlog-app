import SwiftUI

enum Theme {
    static let background = Color(red: 0.110, green: 0.071, blue: 0.047)
    static let accent = Color(red: 0.851, green: 0.384, blue: 0.169)
    static let accent2 = Color(red: 0.941, green: 0.725, blue: 0.361)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
