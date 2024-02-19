//
//  AsyncRequest.swift
//  stinger
//
//  Created by 안춘모 on 2/19/24.
//

import Foundation

class AsyncRequest: Codable {
    var requestID: String
    var checkAfter: Double
    var checkInterval: Double
    var maxCheck: Int
    
    private enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
        case checkAfter = "check_after"
        case checkInterval = "check_interval"
        case maxCheck = "max_check"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestID = try container.decode(String.self, forKey: .requestID)
        self.checkAfter = try container.decode(Double.self, forKey: .checkAfter)
        self.checkInterval = try container.decode(Double.self, forKey: .checkInterval)
        self.maxCheck = try container.decode(Int.self, forKey: .maxCheck)
    }
    
    func maxTimeInterval() -> TimeInterval {
        return self.checkAfter * 0.001 + self.checkInterval * 0.001 + Double(self.maxCheck)
    }
}
