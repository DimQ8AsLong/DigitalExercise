//
//  Model.swift
//  DigitalExercise
//
//  Created by Saad Al Mubarak on 2/10/19.
//  Copyright © 2019 Saad Al Mubarak. All rights reserved.

// this model is built using quicktype.io tool

import Foundation



// begin class (model)

class Begin: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: [Result]?
    
    
    // set keys to fimiliar coding style
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
    
    
    // need to initilize the class
    init(status: String?, copyright: String?, numResults: Int?, results: [Result]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}


// Class Result (Model)
class Result: Codable {
    let url: String?
    let adxKeywords: String?
    let column: String?
    let section: String?
    let id, assetID: Int?
    let byline: String?
    let type: ResultType?
    let title, abstract, publishedDate: String?
    let source: Source?
    let desFacet, orgFacet, perFacet, geoFacet: Facet?
    let media: [Media]?
    let views: Int?
    
    
    // set keys to fimiliar coding style
    enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column, section, id
        case assetID = "asset_id"
        case byline, type, title, abstract
        case publishedDate = "published_date"
        case source
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media, views
    }
    
    
    // need to initilize the class
    init(url: String?, adxKeywords: String?, column: String?, section: String?, id: Int?, assetID: Int?, byline: String?, type: ResultType?, title: String?, abstract: String?, publishedDate: String?, source: Source?, desFacet: Facet?, orgFacet: Facet?, perFacet: Facet?, geoFacet: Facet?, media: [Media]?, views: Int?) {
        self.url = url
        self.adxKeywords = adxKeywords
        self.column = column
        self.section = section
        self.id = id
        self.assetID = assetID
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.publishedDate = publishedDate
        self.source = source
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.views = views
    }
}



enum Facet: Codable {
    case string(String)
    case stringArray([String])
    
    
    // initalize decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Facet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Facet"))
    }
    
    // encoder function
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}


// Media Class (Model)
class Media: Codable {
    let type: MediaType?
    let subtype: Subtype?
    let caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?
    
    
    // set keys to fimiliar coding style
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
    
    
    // need to initilize the class
    init(type: MediaType?, subtype: Subtype?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}


// Media Metadata Class (Model)
class MediaMetadatum: Codable {
    let url: String?
    let format: Format?
    let height, width: Int?
    
    // need to initilize the class
    init(url: String?, format: Format?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}



// set keys to fimiliar coding style
enum Format: String, Codable {
    case jumbo = "Jumbo"
    case large = "Large"
    case largeThumbnail = "Large Thumbnail"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case normal = "Normal"
    case square320 = "square320"
    case square640 = "square640"
    case standardThumbnail = "Standard Thumbnail"
    case superJumbo = "superJumbo"
}



enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}

enum Source: String, Codable {
    case theNewYorkTimes = "The New York Times"
}

enum ResultType: String, Codable {
    case article = "Article"
    case interactive = "Interactive"
}

// MARK: Convenience initializers and mutators

extension Begin {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Begin.self, from: data)
        self.init(status: me.status, copyright: me.copyright, numResults: me.numResults, results: me.results)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status: String?? = nil,
        copyright: String?? = nil,
        numResults: Int?? = nil,
        results: [Result]?? = nil
        ) -> Begin {
        return Begin(
            status: status ?? self.status,
            copyright: copyright ?? self.copyright,
            numResults: numResults ?? self.numResults,
            results: results ?? self.results
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Result {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Result.self, from: data)
        self.init(url: me.url, adxKeywords: me.adxKeywords, column: me.column, section: me.section, id: me.id, assetID: me.assetID, byline: me.byline, type: me.type, title: me.title, abstract: me.abstract, publishedDate: me.publishedDate, source: me.source, desFacet: me.desFacet, orgFacet: me.orgFacet, perFacet: me.perFacet, geoFacet: me.geoFacet, media: me.media, views: me.views)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        url: String?? = nil,
        adxKeywords: String?? = nil,
        column: String?? = nil,
        section: String?? = nil,
        id: Int?? = nil,
        assetID: Int?? = nil,
        byline: String?? = nil,
        type: ResultType?? = nil,
        title: String?? = nil,
        abstract: String?? = nil,
        publishedDate: String?? = nil,
        source: Source?? = nil,
        desFacet: Facet?? = nil,
        orgFacet: Facet?? = nil,
        perFacet: Facet?? = nil,
        geoFacet: Facet?? = nil,
        media: [Media]?? = nil,
        views: Int?? = nil
        ) -> Result {
        return Result(
            url: url ?? self.url,
            adxKeywords: adxKeywords ?? self.adxKeywords,
            column: column ?? self.column,
            section: section ?? self.section,
            id: id ?? self.id,
            assetID: assetID ?? self.assetID,
            byline: byline ?? self.byline,
            type: type ?? self.type,
            title: title ?? self.title,
            abstract: abstract ?? self.abstract,
            publishedDate: publishedDate ?? self.publishedDate,
            source: source ?? self.source,
            desFacet: desFacet ?? self.desFacet,
            orgFacet: orgFacet ?? self.orgFacet,
            perFacet: perFacet ?? self.perFacet,
            geoFacet: geoFacet ?? self.geoFacet,
            media: media ?? self.media,
            views: views ?? self.views
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Media {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Media.self, from: data)
        self.init(type: me.type, subtype: me.subtype, caption: me.caption, copyright: me.copyright, approvedForSyndication: me.approvedForSyndication, mediaMetadata: me.mediaMetadata)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        type: MediaType?? = nil,
        subtype: Subtype?? = nil,
        caption: String?? = nil,
        copyright: String?? = nil,
        approvedForSyndication: Int?? = nil,
        mediaMetadata: [MediaMetadatum]?? = nil
        ) -> Media {
        return Media(
            type: type ?? self.type,
            subtype: subtype ?? self.subtype,
            caption: caption ?? self.caption,
            copyright: copyright ?? self.copyright,
            approvedForSyndication: approvedForSyndication ?? self.approvedForSyndication,
            mediaMetadata: mediaMetadata ?? self.mediaMetadata
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension MediaMetadatum {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MediaMetadatum.self, from: data)
        self.init(url: me.url, format: me.format, height: me.height, width: me.width)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        url: String?? = nil,
        format: Format?? = nil,
        height: Int?? = nil,
        width: Int?? = nil
        ) -> MediaMetadatum {
        return MediaMetadatum(
            url: url ?? self.url,
            format: format ?? self.format,
            height: height ?? self.height,
            width: width ?? self.width
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func BeginTheTask(with url: URL, completionHandler: @escaping (Begin?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
