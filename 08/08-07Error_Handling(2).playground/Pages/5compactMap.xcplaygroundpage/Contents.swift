import Foundation
import Combine

let publisher = [1, 2, 0, 4, 5].publisher
    .compactMap({ value -> Int? in
        if value == 0 {
            return nil
        }
        
        return 100 / value
    })

publisher
    .sink { value in
        print(value)
    }

