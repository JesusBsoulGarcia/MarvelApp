//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class ResponseData: APIModel {

    public var count: Int?

    public var limit: Int?

    public var offset: Int?

    public var results: [CharData]?

    public var total: Int?

    public init(count: Int? = nil, limit: Int? = nil, offset: Int? = nil, results: [CharData]? = nil, total: Int? = nil) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.results = results
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        count = try container.decodeIfPresent("count")
        limit = try container.decodeIfPresent("limit")
        offset = try container.decodeIfPresent("offset")
        results = try container.decodeArrayIfPresent("results")
        total = try container.decodeIfPresent("total")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encodeIfPresent(count, forKey: "count")
        try container.encodeIfPresent(limit, forKey: "limit")
        try container.encodeIfPresent(offset, forKey: "offset")
        try container.encodeIfPresent(results, forKey: "results")
        try container.encodeIfPresent(total, forKey: "total")
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ResponseData else { return false }
      guard self.count == object.count else { return false }
      guard self.limit == object.limit else { return false }
      guard self.offset == object.offset else { return false }
      guard self.results == object.results else { return false }
      guard self.total == object.total else { return false }
      return true
    }

    public static func == (lhs: ResponseData, rhs: ResponseData) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
