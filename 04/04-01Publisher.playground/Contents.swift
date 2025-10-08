import Foundation
import Combine

// @Published

class IntClass {
    @Published var value = 0
}

let intClass = IntClass()

intClass.$value
    .sink { value in
        print("published value: ", value)
    }

intClass.value = 100
intClass.value = 200
