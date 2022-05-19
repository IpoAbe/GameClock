//
//  SettingsViewController.swift
//  GameClock
//
//  Created by 安部一歩 on 2022/04/08.
//
import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    var settings: [Setting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .gray
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func loadData() {
        settings.append(Setting(item: "Player 1", rightDetail: "1:00"))
        settings.append(Setting(item: "Player 2", rightDetail: "2:00"))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = settings[indexPath.row].item
        content.secondaryText = settings[indexPath.row].rightDetail
        cell.contentConfiguration = content
        
        return cell
    }
    
    //設定したいPlayerを識別するためindexPathの番号をPickerVCのvar indexNumに渡します。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicker" {
            if let indexNum = tableView.indexPathForSelectedRow?.row {
                guard let destinationVC = segue.destination as? PickerViewController
                else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                destinationVC.indexNum = indexNum
            }
        }
    }
}
