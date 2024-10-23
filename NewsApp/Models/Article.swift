import Foundation

struct Article: Identifiable, Codable, Equatable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var isBookmarked: Bool = false
    let publishedAt: String
    var id: String {
        return "\(title)-\(publishedAt)-\(url)"
    }

    // Codable keys to ensure proper encoding/decoding
    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt
    }
}
