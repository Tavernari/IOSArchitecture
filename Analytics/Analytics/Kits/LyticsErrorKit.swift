//
//  LyticsErrorKit.swift
//  Analytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class LyticsErrorKit {
    private let error: Error
    init(error: Error){
        self.error = error
    }

    func dispatch() {
        Lytics.error(error, addtionalUserInfo: nil)
    }

    func dispatch(addtionalUserInfo userInfo:[String: Any]) {
        Lytics.error(error, addtionalUserInfo: userInfo)
    }
}
