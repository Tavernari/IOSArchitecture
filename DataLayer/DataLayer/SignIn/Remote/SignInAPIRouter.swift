//
//  SignInAPIRouter.swift
//  DataLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

enum SignInAPIRouter: APIRouter {
    var baseURL: String { "http://www.mocky.io/v2/" }

    case recover(email: String)

    var path: String {
        switch self {
        case .recover:
            return "5eb17969320000700028f78e"
        }
    }

    var method: APIRouterHttpMethod {
        return .get
    }
}
