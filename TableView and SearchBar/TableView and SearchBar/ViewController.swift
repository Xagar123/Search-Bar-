//
//  ViewController.swift
//  TableView and SearchBar
//
//  Created by Admin on 27/11/22.
//

import UIKit



class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
   
    let searchController = UISearchController()
    
    let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let data = ["one","two","three","four"]
    var filterData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        filterData = data
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func updateSearchResults(for searchController: UISearchController) {
        print("update function")
        guard let text = searchController.searchBar.text else {return}
        
        print(text)
        let vc = searchController.searchResultsController as? ViewController
        
        if text == "" {
            filterData = data
        }

        for itemlist in data
        {
            if itemlist.uppercased().contains(text.uppercased()){
                filterData.append(itemlist)
            }
        }
        self.tableView.reloadData()
        
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filterData[indexPath.row]
        return cell
    }
    
    
}

