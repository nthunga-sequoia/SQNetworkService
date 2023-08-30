//
//  Environment.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    var BaseServiceURL: String {
        switch self {
        case .development:
            return "https://hrx-backend-dev.sequoia-development.com"
        case .staging:
            return "https://stg-combine.com/purchaseService"
        case .production:
            return "https://hrx-backend.sequoia.com/"
        }
    }
}
