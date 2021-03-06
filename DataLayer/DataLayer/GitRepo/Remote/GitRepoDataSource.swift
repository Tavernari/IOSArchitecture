//
//  GitRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class GitRepoDataSource: GitRepoDataSourceProtocol {
    public init() {}

    public func list(term: String, completion: @escaping (Result<GitReposResponseDTO, Error>) -> Void) {
        GithubRepoAPIRouter.search(term: term)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }

    public func stats(repo: GitRepositoryModel, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        var gitRepoStatsModel = GitRepoStatsModel()
        gitRepoStatsModel.name = repo.name
        gitRepoStatsModel.closedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.openedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.mergedPullRequests = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.proposedPullRequests = Int.random(in: 0 ... 1000)
        completion(.success(gitRepoStatsModel))
    }
}
