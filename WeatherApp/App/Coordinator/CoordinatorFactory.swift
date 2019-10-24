import Foundation

protocol CoordinatorFactoryType {
    func makeForecast() -> ForecastCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {

    let repository: RepositoryType
    
    func makeForecast() -> ForecastCoordinatorType {
        return ForecastCoordinator()
    }
}
