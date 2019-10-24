import Foundation

protocol CoordinatorFactoryType {
    func makeApp() -> AppCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {

    let repository: RepositoryType
    
    func makeApp() -> AppCoordinatorType {
        return AppCoordinator()
    }
}
