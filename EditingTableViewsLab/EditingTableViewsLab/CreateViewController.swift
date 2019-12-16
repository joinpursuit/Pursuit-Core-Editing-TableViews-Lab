//
//  CreateViewController.swift
//  EditingTableViewsLab
//
//  Created by Ahad Islam on 12/15/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    private lazy var newView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Grocery Item"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        newView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    private func configureView() {
        view.backgroundColor = .systemTeal
        setupNewView()
        setupTitleLabel()
    }
    
    private func setupNewView() {
        view.addSubview(newView)
        newView.backgroundColor = .systemPurple
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.layer.borderWidth = 5
        newView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            newView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            newView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            newView.widthAnchor.constraint(equalToConstant: view.frame.width - 40)])
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: newView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -20)])
    }
    
}
