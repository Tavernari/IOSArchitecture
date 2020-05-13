//
//  LyticsBase+registerProvider.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {
    static func register(provider: ProviderType) {
        providers.append(provider)
    }
}
