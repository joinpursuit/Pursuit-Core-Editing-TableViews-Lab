//
//  ViewController.swift
//  EditingTableViewsLab
//
//  Created by Ahad Islam on 12/15/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

protocol CreateViewControllerDelegate: AnyObject {
    func updateGroceries(_ grocery: Grocery)
}

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Grocery Cell")
        return tableView
    }()
    
    private lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (presentVC))
        return button
    }()
    
    
    
    private var groupedGroceries = Dictionary(grouping: Grocery.getGroceries, by: {$0.status})
        .sorted(by: { $0.key < $1.key }) {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc private func presentVC() {
        print("Button pressed")
        let createVC = CreateViewController()
        createVC.delegate = self
        self.navigationController?.present(createVC, animated: true, completion: nil)
    }
    
    private func configureView() {
        view.backgroundColor = .systemPink
        self.title = "Groceries"
        setupTableView()
        setupBarButton()
    }
    
    private func setupBarButton() {
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleted")
            groupedGroceries[indexPath.section].value.remove(at: indexPath.row)
            if groupedGroceries[indexPath.section].value.count == 0 {
                groupedGroceries.remove(at: indexPath.section)
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedGroceries[section].key.description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedGroceries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedGroceries[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Grocery Cell", for: indexPath)
        let grocery = groupedGroceries[indexPath.section].value[indexPath.row]
        cell.textLabel?.text = grocery.item
        return cell
    }

}

extension ViewController: CreateViewControllerDelegate {
    func updateGroceries(_ grocery: Grocery) {
        switch grocery.status {
        case .notPurchased:
            groupedGroceries[grocery.status.rawValue].value.append(grocery)
            groupedGroceries[grocery.status.rawValue].value.sort(by: {$0.item < $1.item})
        case .purchased:
            groupedGroceries[grocery.status.rawValue].value.append(grocery)
            groupedGroceries[grocery.status.rawValue].value.sort(by: {$0.item < $1.item})
        }
        print("Updated Groceries")
    }
}
