//
//  GitPullRequestsListViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright (c) 2020 Taverna Apps. All rights reserved.
//
//  This file was generated by Mobiplus Clean
//

import DomainLayer
import UIKit

class GitPullRequestsListViewController: UIViewController {
    final class func initWith(withViewModel viewModel: GitPullRequestsListViewModel,
                              andRepo repo: GitRepositoryModel) -> GitPullRequestsListViewController {
        let vc = GitPullRequestsListViewController()
        vc.viewModel = viewModel
        vc.repo = repo
        return vc
    }

    private(set) var viewModel: GitPullRequestsListViewModel!
    private(set) var repo: GitRepositoryModel!

    private var dataSource: [GitPullRequestModel] = []

    @IBOutlet private var tableView: UITableView!

    fileprivate func configTableView() {
        tableView.register(R.nib.gitPullRequestsTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
    }

    fileprivate func deselectRow(indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    fileprivate func handleLoadingView(_ value: Bool) {
        if value {
            showLoadingIndicator(text: "Loading")
        } else {
            removeLoadingIndicator()
        }
    }

    fileprivate func setDataSource(_ data: [GitPullRequestModel]) {
        dataSource = data
        tableView.reloadData()
    }

    fileprivate func bindViewModel() {
        viewModel.failMessage.observe(listener: showError)
        viewModel.isLoading.observe(listener: handleLoadingView)
        viewModel.pullRequests.observe(listener: setDataSource)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(repo.name) Pull Requests"
        configTableView()
        viewModel.load(repo: repo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel.isLoading.removeAllObservers()
        viewModel.failMessage.removeAllObservers()
        viewModel.pullRequests.removeAllObservers()
    }
}

extension GitPullRequestsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.select(index: indexPath.row)
        deselectRow(indexPath: indexPath)
    }
}

extension GitPullRequestsListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = R.reuseIdentifier.gitPullRequestsTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)!
        let pullRequest = dataSource[indexPath.row]
        cell.pullRequestAuthor = pullRequest.author
        cell.pullRequestImage = pullRequest.image
        cell.pullRequestTitle = pullRequest.title
        cell.pullRequestDescription = pullRequest.description
        cell.pullRequestDate = pullRequest.createdAt?.string(format: .ddMMyyyyHHmmss) ?? ""
        return cell
    }
}
