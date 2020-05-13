//
//  LyticsBase+errorDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {
    static func error(_ error: Error, addtionalUserInfo userInfo:[String: Any]?) {
        providers
            .filter{ $0.enable }
            .compactMap{ $0 as? ErrorDispatcher }
            .forEach { $0.error(error, addtionalUserInfo: userInfo) }
    }
}
