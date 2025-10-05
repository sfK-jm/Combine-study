import UIKit
import Combine

func publisher1() -> Publishers.Sequence<[Int], Never> {
    let pub = [1, 2, 3].publisher
    return pub
}

func publisher2() -> AnyPublisher<Int, Never> {
    let pub = [1, 2, 3].publisher
        .eraseToAnyPublisher()
    return pub
}

func publisher3() -> AnyPublisher<Data, URLError> {
    let pub = URLSession.shared.dataTaskPublisher(for: URL(string: "https://catfact.ninja/fact")!)
        .map(\.data)
        .eraseToAnyPublisher()
    return pub
}

print("--- 1 ---")
publisher1()
    .sink { num in
        print(num)
}

print("--- 2 ---")
publisher2()
    .sink { num in
        print(num)
}

print("--- 3 ---")
let subscription = publisher3()
    .sink { _ in
    } receiveValue: { data in
        print(data)
    }
