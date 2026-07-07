import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 10

    @Published var items: [FireNight] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("firepitlog_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: FireNight) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: FireNight) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: FireNight) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([FireNight].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [FireNight] {
        [
        FireNight(date: Date().addingTimeInterval(-86400), guests: "Sam and Ellie", woodLogs: "6", duration: "2.5"),
        FireNight(date: Date().addingTimeInterval(-172800), guests: "Neighbors from next door", woodLogs: "4", duration: "3"),
        FireNight(date: Date().addingTimeInterval(-259200), guests: "Just family", woodLogs: "3", duration: "1.5")
        ]
    }
}
