//
//  ForecastViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Bond

protocol ForecastViewControllerViewModelOutput {

    var city: Observable<String> { get }
    var temperature: Observable<String> { get }
    var day: Observable<String> { get }
    var showErrorView: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var cellViewModels: Observable<[ForecastTableViewCellViewModelType]> { get }
}

protocol ForecastViewControllerViewModelInput {

    func load()
}

protocol ForecastViewControllerViewModelType {

    var outputs: ForecastViewControllerViewModelOutput { get }
    var inputs: ForecastViewControllerViewModelInput { get }
}

class ForecastViewControllerViewModel: ForecastViewControllerViewModelType, ForecastViewControllerViewModelOutput, ForecastViewControllerViewModelInput {

    var outputs: ForecastViewControllerViewModelOutput { return self }
    var inputs: ForecastViewControllerViewModelInput { return self }

    // MARK: Properties
    
    private let repository: WeatherRepository
    private let greaterLondonCityId = 2648110

    private(set) var city: Observable<String> = .init("Greater London")
    private(set) var temperature: Observable<String> = .init("")
    private(set) var day: Observable<String> = .init("")
    private(set) var showErrorView: Observable<Bool> = .init(false)
    private(set) var isLoading: Observable<Bool> = .init(false)
    private(set) var cellViewModels: Observable<[ForecastTableViewCellViewModelType]> = .init([ForecastTableViewCellViewModelType]())

    // MARK: Instantiation
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func load() {
        isLoading.send(true)
        repository.fetchForecasts(for: greaterLondonCityId) { [weak self] result in

            guard let self = self else { return }
            self.isLoading.send(false)

            switch result {
                
            case .failure:
                self.showErrorView.send(true)
                
            case .success(let forecasts):
                self.showErrorView.send(false)
                self.updateUI(with: forecasts)
            }
        }
    }
    
    private func updateUI(with forecasts: [Forecast]) {

        if let dayOfWeek = forecasts.first?.date.dayOfWeek() {
            day.send(dayOfWeek)
        }
        
        if let dayTemperature = forecasts.first?.dayTemperature {
            temperature.send("\(dayTemperature)°C")
        }

        let viewModels = forecasts
            .map { ForecastTableViewCellViewModel(with: $0) }
        
        cellViewModels.send(viewModels)
    }
}
