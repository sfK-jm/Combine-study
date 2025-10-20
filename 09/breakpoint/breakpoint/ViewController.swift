//
//  ViewController.swift
//  breakpoint
//
//  Created by Junmo Sung on 10/20/25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var cancellables: Set<AnyCancellable> = []
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let numberPublisher = (1...20).publisher
        
        numberPublisher
            .breakpointOnError()
            .breakpoint(receiveOutput: { number in
                if number == 10 { return true }
                return false
            })
            .sink { number in
                print(number)
            }
            .store(in: &cancellables)
    }


}

