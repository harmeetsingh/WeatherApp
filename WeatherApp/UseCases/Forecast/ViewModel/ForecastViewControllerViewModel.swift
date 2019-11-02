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

    var cityLabelText: Observable<String> { get }
    var degreesLabelText: Observable<String> { get }
    var dayLabalText: Observable<String> { get }
    var showErrorView: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
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

    private(set) var cityLabelText: Observable<String> = .init("Greater London")
    private(set) var degreesLabelText: Observable<String> = .init("")
    private(set) var dayLabalText: Observable<String> = .init("")
    private(set) var showErrorView: Observable<Bool> = .init(false)
    private(set) var isLoading: Observable<Bool> = .init(false)

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

            dayLabalText.send(dayOfWeek)
        }
        
        if let dayTemperature = forecasts.first?.dayTemperature {

            degreesLabelText.send("\(dayTemperature)°C")
        }
    }
}

// MARK: Forecast request

extension ForecastViewControllerViewModel {
    
    func fetchForecast(for cityID: Int) {

//        repository.fetchForecasts(for:cityID) { [weak self] (forecasts: [Forecast]?, error: Error?) in
//            
//            if let error = error {
//                
//                self?.delegate?.forecastViewControllerViewModel(self, forecastRequestError: error)
//            
//            } else if let forecasts = forecasts {
//
//                self?.forecasts = forecasts
//                self?.delegate?.forecastViewControllerViewModel(self, forecasts: forecasts)
//            }
//        }
    }
}

// MARK: UI
//
//extension ForecastViewControllerViewModel {
//    
//    func dayLabelTitle() -> String? {
//        
//        return forecasts.first?.date.dayOfWeek()
//    }
//    
//    func degreesLabelTitle() -> String {
//        
//        if let dayTemperature = forecasts.first?.dayTemperature {
//            
//            return "\(dayTemperature)°C"
//        }
//        
//        return ""
//    }
//}
//
//// MARK: UITableView
//
//extension ForecastViewControllerViewModel {
//    
//    func numberOfRows(in section: Int) -> Int {
//        
//        return forecasts.count - 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "Constants.Identifiers.ForecastTableViewCell") as? ForecastTableViewCell {
//            
//            let forecast = forecasts[indexPath.row + 1]
//            let forecastCellViewModel = ForecastTableViewCellViewModel(with: forecast)
//            
//            cell.configure(with: forecastCellViewModel)
//            
//            return cell
//        }
//        
//        return UITableViewCell()
//    }
//}
