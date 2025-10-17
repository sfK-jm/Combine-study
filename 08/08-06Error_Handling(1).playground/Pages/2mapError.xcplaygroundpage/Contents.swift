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
        .tryMap { num in
            if num == 0 { throw MyError.zeroError }
            if num == 2 { throw URLError(.badURL) }
            return 100 / num
        }
        .mapError({ error in
            if let myError = error as? MyError {
                return myError
            } else if let urlError = error as? URLError {
                return MyError.urlError
            } else {
                return MyError.unknown
            }
        })
        .eraseToAnyPublisher()
}

divisionPublisher()
    .sink { completion in
        print(completion)
    } receiveValue: { num in
        print(num)
    }

