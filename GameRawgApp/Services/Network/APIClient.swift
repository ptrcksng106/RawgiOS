//
//  APIClient.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/08/24.
//

import Combine
import Foundation

class APIClient {
  private var subscriptions = Set<AnyCancellable>()
  
  public func getGameList(page: Int? = nil, pageSize: Int? = nil) -> Future<[Result], Error> {
    return Future { promise in
      var urlComponents = URLComponents(string: "https://api.rawg.io/api/games")
      if let page = page, let pageSize = pageSize {
        let queryItems = [URLQueryItem(name: "key", value: "79b352b1eb0349db8481b08c1376d10e"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "page_size", value: "\(pageSize)")]
        urlComponents?.queryItems = queryItems
      }
      
      guard let url = urlComponents?.url else { return }
      print("Request URL: \(url)")
      URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { (data, response) in
          guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
          }
          // Print raw data for debugging
          if let rawString = String(data: data, encoding: .utf8) {
//            print("Raw Response Data: \(rawString)")
          }
          return data
        }
        .decode(type: DataGame.self, decoder: JSONDecoder())
        .map { $0.results }
        .sink(receiveCompletion: { completion in
          if case let .failure(error) = completion {
            print("API call failed with error: \(error.localizedDescription)")
          }
        }, receiveValue: { results in
          promise(.success(results))
        })
        .store(in: &self.subscriptions)
    }
  }
  
  public func getDevelopers(page: Int? = nil, pageSize: Int? = nil) -> Future<[Developer], Error> {
    return Future { promise in
      var urlComponents = URLComponents(string: "https://api.rawg.io/api/developers")
      if let page = page, let pageSize = pageSize {
        let queryItems = [URLQueryItem(name: "key", value: "79b352b1eb0349db8481b08c1376d10e"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "page_size", value: "\(pageSize)")]
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        print("Request URL: \(url)")
        URLSession.shared.dataTaskPublisher(for: url)
          .tryMap { (data, response) in
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
              throw URLError(.badServerResponse)
            }
            // Print raw data for debugging
            if let rawString = String(data: data, encoding: .utf8) {
              print("Raw Response Data: \(rawString)")
            }
            return data
          }
          .decode(type: DataDeveloper.self, decoder: JSONDecoder())
          .map { $0.developers }
          .sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
              print("API call failed with error: \(error.localizedDescription)")
            }
          }, receiveValue: { results in
            promise(.success(results))
          })
          .store(in: &self.subscriptions)
      }
    }
  }
  
  func getDetailGame(id: Int) -> Future<Detail, Error> {
    return Future { promise in
      var urlComponents = URLComponents(string: "https://api.rawg.io/api/games/\(id)")
      let queryItems = [URLQueryItem(name: "key", value: "79b352b1eb0349db8481b08c1376d10e")]
      urlComponents?.queryItems = queryItems
      
      guard let url = urlComponents?.url else { return }
      print("Request URL: \(url)")
      URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { (data, response) in
          guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
          }
          return data
        }
        .decode(type: Detail.self, decoder: JSONDecoder())
        .map { $0 }
        .sink(receiveCompletion: { completion in
          if case let .failure(error) = completion {
            print("API call failed with error: \(error.localizedDescription)")
          }
        }, receiveValue: { result in
          promise(.success(result))
        })
        .store(in: &self.subscriptions)
    }
  }
}
