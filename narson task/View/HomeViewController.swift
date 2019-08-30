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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        segmentedControl.addUnderlineForSelectedSegment()
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
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
}

