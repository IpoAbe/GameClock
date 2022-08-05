//
//  TimePickerViewController.swift
//  GameClock
//
//  Created by IpoAbe on 2022/03/25.
//

import UIKit

class TimePickerViewController: UIViewController {
    @IBOutlet private weak var pickerView: UIPickerView!
    
    var player: Player = .P1
    private var hour = 0
    private var min = 0
    private var sec = 0
    private var totalSec = 0
    
    let times = [[Int](0...9),[Int](0...59),[Int](0...59)]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        adjustPicker(player)
    }
    
    private func adjustPicker(_ player: Player) {
        switch player {
        case .P1: totalSec = userDefaults.integer(forKey: p1TimeKey)
        case .P2: totalSec = userDefaults.integer(forKey: p2TimeKey)
        }
        
        let h = totalSec / 3600
        let m = totalSec % 3600 / 60
        let s = totalSec % 3600 % 60
        
        hour = h
        min = m
        sec = s
        
        for component in 0..<times.count {
            switch component {
            case 0: pickerView.selectRow(h, inComponent: component, animated: true)
            case 1: pickerView.selectRow(m, inComponent: component, animated: true)
            case 2: pickerView.selectRow(s, inComponent: component, animated: true)
            default: print("adjustPickerエラー")
            }
        }
    }
}

// MARK: - PickerView Delegate
extension TimePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(times[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: hour = times[component][row]
        case 1: min = times[component][row]
        case 2: sec = times[component][row]
        default: print("pickerでエラー")
        }
        
        totalSec = hour * 60 * 60 + min * 60 + sec
        
        switch player {
        case .P1: userDefaults.set(totalSec, forKey: p1TimeKey)
        case .P2: userDefaults.set(totalSec, forKey: p2TimeKey)
        }
    }
}

