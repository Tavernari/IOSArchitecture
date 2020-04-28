//
//  StartView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            RepositoriesListView(viewModel: .init(fetchGitRepositoriesUseCase: UseCaseFacade.fetchGitRepositoryUseCase()))
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
