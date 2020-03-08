//
//  ViewModelStatus.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

enum ViewModelLoadStatus: Equatable {
    case none
    case loading
    case loaded
    case fail(String)
}
