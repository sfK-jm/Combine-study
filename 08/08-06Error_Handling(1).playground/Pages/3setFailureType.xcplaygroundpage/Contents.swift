import Foundation
import Combine

enum MyError: Error {
    case zeroError
    case urlError
    case unknown
}


func divisionPublisher() -> AnyPublisher<Int, MyError> {
    
    let publiisher = [1, 2, 0, 3, 4].publisher
    
    return publiisher
        .setFailureType(to: MyError.self)
        .eraseToAnyPublisher()
}

divisionPublisher()
    .sink { completion in
        print(completion)
    } receiveValue: { _ in
        
    }
