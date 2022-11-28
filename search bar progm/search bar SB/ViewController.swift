//
//  ViewController.swift
//  search bar SB
//
//  Created by Admin on 28/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        return table
    }()
    
    let data = ["one","two","three","four"]
    var filterData:[String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        filterData = data
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureUI(){
        print("configureUI")
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Bar"
        navigationController?.navigationBar.barTintColor = UIColor(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        showSearchBarButton(shouldShow: true)
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
    }

    @objc func handleShowSearchBar(){
//        navigationItem.titleView = searchBar
//        searchBar.showsCancelButton = true
      //  navigationItem.rightBarButtonItem = nil
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        }else{
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }

}

extension ViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("did taped cancle")
        // we have use the same line of code inside the search funcion
        //        navigationItem.titleView = nil
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        //        searchBar.showsCancelButton = false
        
        search(shouldShow: false)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("did search bar did begain editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("search bar did end editing")
    }
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search text is \(searchText)")
        //we are reseting the data
                if searchText == "" {
                    filterData = data
                }
        
                for itemlist in data
                {
                    if itemlist.uppercased().contains(searchText.uppercased()){
                        filterData.append(itemlist)
                    }
                }
                self.tableView.reloadData()
            }
//        if searchBar.text?.count == 0 {
//            filterData = data
//            self.tableView.reloadData()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//            //for removing the cursor and keyboard
//            //searchBar.resignFirstResponder()
//        }
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
