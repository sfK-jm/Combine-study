import UIKit
import Combine

let publisher = [1, 2, 3, 4].publisher

let subscritpion = publisher
    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }

