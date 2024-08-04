//
//  CombineViewModel.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/08/24.
//

import Combine
import Foundation

class CombineViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var games: [Result] = []
  @Published var developers: [Developer] = []
  @Published var errorMessage: String?
  
  private let apiClient: APIClient //Construct buat object dari class yang lain
  private var cancellables = Set<AnyCancellable>()
  
  init(apiClient: APIClient = APIClient()) {
    self.apiClient = apiClient
  }
  
  func fetchGameList(page: Int? = nil, pageSize: Int? = nil) {
    apiClient.getGameList(page: page, pageSize: pageSize)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          print("API call finished successfully")
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
          print("API call failed with error: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] dataGame in
//        print("Received data: \(dataGame)")
        self?.games = dataGame
      })
      .store(in: &cancellables)
  }
  
  func fetchDeveloperList(page: Int? = nil, pageSize: Int? = nil) {
    apiClient.getDevelopers(page: page, pageSize: pageSize)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          print("API call finished successfully")
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
          print("API call failed with error: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] dataDeveloper in
//        print("Received data: \(dataDeveloper)")
        self?.developers = dataDeveloper
      })
      .store(in: &cancellables)
  }
}
