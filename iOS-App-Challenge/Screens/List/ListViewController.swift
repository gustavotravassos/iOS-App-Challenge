//
//  ListViewController.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

// MARK: - TableView Delegate
extension ListViewController: UITableViewDelegate {}


// MARK: - TableView DataSource
extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
}
