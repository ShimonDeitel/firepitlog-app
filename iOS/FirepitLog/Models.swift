import Foundation

struct FireNight: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var guests: String
    var woodLogs: String
    var duration: String
}
