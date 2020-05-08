//
//  AnalyticsScreenEventDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol AnalyticsScreenEventDispatcher {
    func screen(event: AnalyticsScreenEventType)
}
