/*
 * Created by Ubique Innovation AG
 * https://www.ubique.ch
 * Copyright (c) 2020. All rights reserved.
 */

import Foundation

struct CodableDiagnosisKey: Codable, Equatable {
    let keyData: Data
    let rollingPeriod: UInt32
    let rollingStartNumber: UInt32
    let transmissionRiskLevel: UInt8
}

/// Model of the exposed person
struct ExposeeListModel: Encodable {
    /// Secret keys
    let exposedKeys: [CodableDiagnosisKey]

    /// Authentication data provided by health institutes to verify test results
    let authData: String?

    let fake: Bool

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode key
        try container.encode(exposedKeys, forKey: .exposedKeys)
        // Encode auth if present only
        try container.encodeIfPresent(authData, forKey: .authData)

        try container.encode(fake ? 1 : 0, forKey: .fake)
    }

    enum CodingKeys: CodingKey {
        case exposedKeys, authData, fake
    }
}
