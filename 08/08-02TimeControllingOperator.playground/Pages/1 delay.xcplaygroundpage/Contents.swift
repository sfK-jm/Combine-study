import Foundation
import Combine

let publisher = [1, 2, 3, 4].publisher

let subscription = publisher
    .map({ value in
        print("delay 전: \(value)")
        return value
    })
    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print("delay 후: \(value)")
    }

