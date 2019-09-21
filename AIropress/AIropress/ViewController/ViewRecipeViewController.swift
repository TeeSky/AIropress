//
//  ViewRecipeViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class ViewRecipeViewController: BaseViewController<ViewRecipeSceneView> {

    var viewModel: ViewRecipeVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configure(tableView: sceneView.tableView)

        sceneView.tableView.dataSource = self
        sceneView.tableView.delegate = self

        sceneView.resetButton.addTarget(viewModel, action: #selector(viewModel.onResetClicked), for: .touchUpInside)
        sceneView.prepareButton.addTarget(viewModel, action: #selector(viewModel.onPrepareClicked), for: .touchUpInside)
    }
}

extension ViewRecipeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.cellViewModel(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.identifier, for: indexPath)

        guard let baseTableCell = cell as? ConfigurableTableCell else {
            fatalError("All table view cell classes must implement ConfigurableTableCell.")
        }
        baseTableCell.configure(viewModel: cellVM)

        return cell
    }
}

extension ViewRecipeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight(for: indexPath)
    }
}
