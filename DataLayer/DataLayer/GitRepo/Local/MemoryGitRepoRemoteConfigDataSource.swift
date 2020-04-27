//
//  MemoryConfigDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class MemoryGitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    var gitRepoReliabilityMultiplierModel = GitRepoReliabilityMultiplier()
    public init(enable: Bool, multiplier: Double) {
        gitRepoReliabilityMultiplierModel.enable = enable
        gitRepoReliabilityMultiplierModel.multiplier = multiplier
    }

    public func gitRepoReliabilityMultiplier(
        completion: @escaping (Result<GitRepoReliabilityMultiplier, Error>) -> Void
    ) {
        completion(.success(gitRepoReliabilityMultiplierModel))
    }
}
