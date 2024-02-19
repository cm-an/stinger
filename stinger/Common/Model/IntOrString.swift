//
//  IntOrString.swift
//  stinger
//
//  Created by 안춘모 on 2/19/24.
//

import Foundation

enum IntOrString: Codable {
    enum Error: Swift.Error {
        case parsingError
    }
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Int.self) {
            self = .int(value)
            return
        }
        
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }
        throw Error.parsingError
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .int(value):
            try container.encode(value)
        case let .string(value):
            try container.encode(value)
        }
    }
}

extension IntOrString: Hashable {
    static func == (lhs: IntOrString, rhs: IntOrString) -> Bool {
        switch (lhs, rhs) {
        case let (.int(leftValue), .int(rightValue)):
            return leftValue == rightValue
        case let (.string(leftValue), .string(rightValue)):
            return leftValue == rightValue
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .int(value):
            hasher.combine(value)
        case let .string(value):
            hasher.combine(value)
        }
    }
}
