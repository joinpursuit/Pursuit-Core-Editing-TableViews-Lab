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
    var addedItems = [ShoppingItem]()
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let newItemVC = segue.source as? NewItemViewController else {return}
        guard let textFromItem = newItemVC.itemTextField.text, let textFromPrice = newItemVC.priceTextField.text, let priceAsDouble = Double(textFromPrice) else {return}
        let newItem = ShoppingItem(name: textFromItem, price: priceAsDouble)
        shoppingItems.append(newItem)
        let lastIndex = shoppingTableView.numberOfRows(inSection: 0)
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        shoppingTableView.insertRows(at: [lastIndexPath], with: .fade)
    }
    @IBAction func deleteItemButton(_ sender: UIButton) {
        if shoppingTableView.isEditing {
            shoppingTableView.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        } else {
            shoppingTableView.setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            shoppingItems.remove(at: indexPath.row)
            shoppingTableView.deleteRows(at: [indexPath], with: .fade)
        default:
            print("")
        }
    }
    
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
        switch section {
        case 0:
            return shoppingItems.count
        case 1:
            return addedItems.count
        default:
            return 0
        }
//        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = shoppingItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "\(item.price)"
            
            return cell
        case 1:
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "\(item.price)"
            
            return cell
        default:
            return cell
        }
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "\(item.price)"
//
//        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "To Buy"
        case 1:
            return "Bought: Tap Item to Add"
        default:
            return "error"
        }
    }
    //My attempt at clicking to move an item from shopping list to bought list. It failed.
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            shoppingItems.remove(at: indexPath.row)
//            shoppingTableView.deleteRows(at: [indexPath], with: .fade)
//        case 1:
//            addedItems.append(shoppingItems[indexPath.row])
//            shoppingTableView.insertRows(at: [indexPath], with: .fade)
//        default:
//            print("")
//        }
//    }

}
