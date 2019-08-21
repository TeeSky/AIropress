//
//  DesiredTasteViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class DesiredTasteViewController: BaseViewController<DesiredTasteSceneView> {
    
    var viewModel: DesiredTasteVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configure(tableView: sceneView.tableView)
        
        sceneView.tableView.dataSource = self
        sceneView.tableView.delegate = self
        
        sceneView.calculateButton.addTarget(viewModel, action: #selector(viewModel.onCalculateClicked), for: .touchUpInside)
    }
}

extension DesiredTasteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.cellViewModel(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.identifier, for: indexPath)
        
        guard let baseTableCell = cell as? BaseTableCell else {
            fatalError("All table view cell classes must implement BaseTableCell.")
        }
        baseTableCell.configure(viewModel: cellVM)
        
        return cell
    }
}

extension DesiredTasteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight(for: indexPath)
    }
}
