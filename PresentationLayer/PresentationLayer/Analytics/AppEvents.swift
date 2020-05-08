//
//  AppEvents.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 08/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Analytics

enum AppEvents: AnalyticsEventType {
    case gitRepoSelected(repoName: String)
    case gitRepoTermSearched(term: String)

    var data: [String: Any]? {
        switch self {
        case let .gitRepoSelected(repoName):
            return ["repoName": repoName]
        case let .gitRepoTermSearched(term):
            return ["searchTerm": term]
        }
    }

    var name: String {
        switch self {
        case .gitRepoSelected: return "git_repo_select"
        case .gitRepoTermSearched: return "git_repo_searched"
        }
    }
}
