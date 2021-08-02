//
//  NewsModel.swift
//  NewsApp
//
//  Created by Vinsi on 01/08/2021.
//


// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [Result]?

    
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let uri: String?
    let url: String?
    let id: Int?
    let assetid: Int?
    let source: Source?
    let publishedDate: String?
    let updated: String?
    let section: String?
    let subsection: Subsection?
    let nytdsection: String?
    let adxKeywords: String?
    let column: JSONNull?
    let byline: String?
    let type: ResultType?
    let title: String?
    let abstract: String?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]?
    let etaid: Int?
    
}

// MARK: - Media
struct Media: Codable {
    let type: MediaType?
    let subtype: Subtype?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication
        case mediaMetadata
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String?
    let format: Format?
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}

enum Source: String, Codable {
    case newYorkTimes = "New York Times"
}

enum Subsection: String, Codable {
    case empty = ""
    case move = "Move"
    case olympics = "Olympics"
    case politics = "Politics"
}

enum ResultType: String, Codable {
    case article = "Article"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
