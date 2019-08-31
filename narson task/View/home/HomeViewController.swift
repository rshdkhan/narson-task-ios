//
//  HomeViewController.swift
//  narson task
//
//  Created by Napster on 31/08/2019.
//  Copyright © 2019 Napster. All rights reserved.
//

import UIKit

enum Tab: Int {
    case top = 0
    case people = 1
    case tags = 2
}

class HomeViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var items: [Item] = []
    var allData: [Item] = []
    var search: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTF.delegate = self

        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(dismissKeyboardGesture)
        
        segmentedControl.addUnderlineForSelectedSegment()
        
        let store = Store()
        store.getItems(path: "items", type: Item.self) { (data, err) in
            if let err = err {
                print("show error message : \(err.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("show error message")
                return
            }
            self.items = data
            self.allData = data
            self.tableView.reloadData()
        }
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        segmentedControl.changeUnderlinePosition()
        
        switch segmentedControl.selectedSegmentIndex {
            case Tab.top.rawValue:
                self.topView.isHidden = false
                self.peopleView.isHidden = true
                self.tagView.isHidden = true
        
                break
            case Tab.people.rawValue:
                self.topView.isHidden = true
                self.peopleView.isHidden = false
                self.tagView.isHidden = true
        
                break
        
            case Tab.tags.rawValue:
                self.topView.isHidden = true
                self.peopleView.isHidden = true
                self.tagView.isHidden = false
        
                break
            default:
                break
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        let item = self.items[indexPath.row]
        
        cell.setupCell(item: item)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        search = string.isEmpty ? String(search.dropLast()) : textField.text!+string
        search = search.lowercased()
        
        if search.isEmpty {
            self.items = self.allData
            self.tableView.reloadData()
        } else {
            var filteredData: [Item] = []
            
            for item in self.allData {
                let title = item.title.lowercased()
                if title.starts(with: search) {
                    filteredData.append(item)
                }
            }
            
            self.items = filteredData
            self.tableView.reloadData()
        }
        
        return true
    }
}

