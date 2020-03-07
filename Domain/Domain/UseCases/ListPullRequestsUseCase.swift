//
//  ListPullRequestsUseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift

public protocol ListPullRequestsUseCase {
    func execute(owner: String, repoName: String) -> Observable<[GitPullRequest]>
}

public class DoListPullRequestsUseCase: ListPullRequestsUseCase {

    private let repository: GitPullRequestRepository

    public init(repository: GitPullRequestRepository) {
       self.repository = repository
    }

    public func execute(owner: String, repoName: String) -> Observable<[GitPullRequest]> {
        return self.repository.list(owner: owner, onRepository: repoName)
    }
}
