import UIKit
import Combine

// Convinience Publisher

// sequence publisher - Array
print("--- Array ---")
[1, 2, 3].publisher
    .sink { completion in
        switch completion {
        case .finished:
            print("정상 완료")
        case .failure(let error):
            print("에러 \(error)")
        }
    } receiveValue: { num in
        print(num)
    }

// sequence publisher - Set

print("--- Set ---")
Set([1, 2, 3]).publisher
    .sink { num in
        print(num)
    }

// sequence publisher - Dictionary

print("--- Dictionary ---")
["A": 1, "B":2, "C":3].publisher
    .sink { key, value in
        print("key: \(key) | value: \(value)")
    }

// Just

print("--- Just ---")

Just("Hi")
    .sink { value in
        print(value)
    }

// Empty
print("--- Empty ---")

let emptyPublisher = Empty<Int, Never>()

let emptySubscription = emptyPublisher
    .sink { completion in
        print(completion)
    } receiveValue: { num in
        print("Empty는 값을 방출하지 않음")
    }

let emptyPublisherCompleteImmediately = Empty<Int, Never>(completeImmediately: false)

let emptyCompleteImmediatelySubscription = emptyPublisherCompleteImmediately
    .sink { completion in
        print("completeImmediately: false은 끝나지도 않음")
    } receiveValue: { num in
        print("Empty는 값을 방출하지 않음")
    }


// Fail

print("--- Fail ---")

enum MyError: Error {
    case customError
}

let failPublisher = Fail<Int, MyError>(error: .customError)

let failScbscription = failPublisher
    .sink { completion in
        switch completion {
        case .finished:
            print("Fail은 완료되지 않기 때문에 다음 메세지는 출력 x")
        case .failure(let error):
            print("에러 발생: \(error)")
        }
    } receiveValue: { _ in
        print("fail은 값을 방출하지 않음")
    }


//Future
print("--- Future ---")

let futureSubscription = Future<Data, Never> { promise in
    URLSession.shared.dataTask(with: URL(string: "https://catfact.ninja/fact")!) { data, response, error in
        if let data = data {
            promise(.success(data))
        }
    }.resume()
}
.sink { data in
    print("future data:", data)
}

// Convinienve Publisher를 사용하는 이유

print("--- fetch site ---")

func fetchSite() -> AnyPublisher<Data, URLError> {
    guard let url = URL(string: "https://www.naver.com") else {
        return Fail<Data, URLError>(error: URLError(.badURL))
            .eraseToAnyPublisher()
    }
    
    let publisher = URLSession.shared.dataTaskPublisher(for: url)
        .map { (data: Data, response: URLResponse) in
            return data
        }
        .eraseToAnyPublisher()
    
    return publisher
}


let subscription = fetchSite()
    .sink { completion in
        switch completion {
        case .finished:
            print("완료")
        case .failure(let error):
            print("에러발생 \(error)")
        }
    } receiveValue: { data in
        print(data)
    }
