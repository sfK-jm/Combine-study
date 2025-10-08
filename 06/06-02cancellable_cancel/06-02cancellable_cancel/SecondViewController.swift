//
//  SecondViewController.swift
//  06-02cancellable_cancel
//
//  Created by Junmo Sung on 10/8/25.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
    
    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("secondVC is loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { date in
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss:SSSS"
                let dateString = formatter.string(from: date)
                print("current time \(dateString)")
            }
            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        cancellables.forEach { cancellable in
//            cancellable.cancel()
//        }
        
        cancellables.removeAll()
    }
    
    deinit {
        print("secondVC is deinitialized")
    }
}
