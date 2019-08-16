//
//  ShoppingViewController.swift
//  labEditingTableViews
//
//  Created by Levi Davis on 8/16/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    @IBOutlet weak var shoppingTableView: UITableView!
    
    var shoppingItems = [ShoppingItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
        getModelData()
    }
    private func setUpProtocols() {
        shoppingTableView.dataSource = self
        shoppingTableView.delegate = self
    }

    private func getModelData() {
        self.shoppingItems = ShoppingItemFetchingClient.getShoppingItems()
    }
}

extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = shoppingItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath)
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.price)"
        
        return cell
    }
    
    
}
