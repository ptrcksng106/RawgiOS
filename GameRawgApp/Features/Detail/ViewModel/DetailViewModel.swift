//
//  DetailViewModel.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
  @Published var errorMessage: String?
  @Published var detailGame: Detail? = nil
  
  private let apiClient: APIClient
  private var cancellables = Set<AnyCancellable>()
  
  init(apiClient: APIClient = APIClient()) {
    self.apiClient = apiClient
  }
  
  func getDetailGame(id: Int) {
    apiClient.getDetailGame(id: id)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          print("API call finished successfully")
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
          print("API call failed with error: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] detailGame in
        print("Received data: \(detailGame)")
        self?.detailGame = detailGame
      })
      .store(in: &cancellables)
  }
}
