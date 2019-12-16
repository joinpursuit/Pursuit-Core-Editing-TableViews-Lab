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
    
    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Item"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 5
        textField.borderStyle = .bezel
        textField.placeholder = "Enter item here..."
        textField.addTarget(self, action: #selector(validateText), for: .editingChanged)
        return textField
    }()
    
    private lazy var purchasedLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchased?"
        return label
    }()
    
    private lazy var purchasedSwitch: UISwitch = {
        let swtch = UISwitch()
        swtch.setOn(true, animated: true)
        return swtch
    }()
    
    private lazy var newGroceryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .disabled)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(newGrocery), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CreateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        newView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    @objc private func validateText() {
        guard textField.hasText else {
            newGroceryButton.isEnabled = false
            return
        }
        newGroceryButton.isEnabled = true
    }
    
    @objc private func newGrocery() {
        let status = purchasedSwitch.isOn ? Grocery.Status.purchased : Grocery.Status.notPurchased
        let item = textField.text!
        delegate?.updateGroceries(Grocery(status: status, item: item))
        self.dismiss(animated: true, completion: nil)
                
    }
    
    private func configureView() {
        view.backgroundColor = .systemTeal
        setupNewView()
        setupTitleLabel()
        setupStackView1()
        setupStackView2()
        setupButton()
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
    
    private func setupStackView1() {
        let stackView = UIStackView(arrangedSubviews: [itemLabel, textField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: newView.centerYAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -20)])
    }
    
    private func setupStackView2() {
        let stackView = UIStackView(arrangedSubviews: [purchasedLabel, purchasedSwitch])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -20)])
    }
    
    private func setupButton() {
        view.addSubview(newGroceryButton)
        
        newGroceryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newGroceryButton.bottomAnchor.constraint(equalTo: newView.bottomAnchor, constant: -20),
            newGroceryButton.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            newGroceryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
}
