//
//  AuthorListVCTests.swift
//  MyTaskTests
//
//  Created by Ganesh Guturi on 04/09/24.
//

import XCTest
@testable import MyTask

final class AuthorListMockServiceWorker: AuthorListServiceWorkerProtocol {
    private(set) var serviceManager: APIServiceManagerProtocol?
    init(serviceManager: APIServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    func fetchAuthors(requestModel: APIRequestProtocol) async throws -> AuthorsResponseModel {
        do {
            let result = try JSONDecoder().decode(AuthorsResponseModel.self, from: mockData)
            print("result = \(result)")
            return result
        }
        catch {
            throw error
        }
    }
    
    private var mockData: Data {
        let jsonString = """
                            {
                                "entries": [{
                                    "name" : "user1",
                                    "url": "url1",
                                    "seed_count": 1
                                },
                                {
                                    "name" : "user2",
                                    "url": "url2",
                                    "seed_count": 2
                                }]
                            }
                            """
        return jsonString.data(using: .utf8)!
    }
}

final class AuthorListMockInteractor: AuthorListInteractorProtocol {
    var inputModel: AuthorListInputModelProtocol?
    var dbWorker: AuthorListDBWorkerProtocol?
    var serviceWorker: AuthorListServiceWorkerProtocol?
    var presenter: AuthorListPresenterProtocol?
    
    func setDBWorker(dbWorker: AuthorListDBWorkerProtocol) -> Self {
        self.dbWorker = dbWorker
        return self
    }
    
    func setPresenter(presenter: AuthorListPresenterProtocol) -> Self {
        self.presenter = presenter
        return self
    }
    
    func setServiceWorker(serviceWorker: AuthorListServiceWorkerProtocol) -> Self {
        self.serviceWorker = serviceWorker
        return self
    }
    
    func fetchAuthors() {
    }
}

final class AuthorListVCTests: XCTestCase {
    
    private var sut: AuthorListViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = setupSut()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    private func setupSut() -> AuthorListViewController {
        let inputModel = AuthorListInputModel()
        let vc = AuthorListViewController()
        let presenter = AuthorListPresenter(viewController: vc)
        let serviceWorker = AuthorListMockServiceWorker(serviceManager: APIServiceManager())
        let dbWorker = AuthorListDBWorker(model: inputModel)
        let router = AuthorListRouter(viewController: vc)

        let interactor = AuthorListInteractor()
            .setPresenter(presenter: presenter)
            .setServiceWorker(serviceWorker: serviceWorker)
            .setDBWorker(dbWorker: dbWorker)
        _ = vc.setInteractor(interactor)
            .setRouter(router)
        return vc
    }

    func testVC() {
        XCTAssertNotNil(sut.interactor)
        XCTAssertNotNil(sut.router)
    }
    
    func testInteractor() {
        let interactor = sut.interactor!
        XCTAssertNotNil(interactor.dbWorker)
        XCTAssertNotNil(interactor.serviceWorker)
        XCTAssertNotNil(interactor.presenter)
    }
    
    func testDBWorker() {
        let dbWorker = sut.interactor!.dbWorker!
        XCTAssertNotNil(dbWorker.inputModel)
    }

    func testServiceWorker() {
        let serviceWorker = sut.interactor!.serviceWorker!
        XCTAssertNotNil(serviceWorker.serviceManager)
    }
    
    func testPresenter() {
        let presenter = sut.interactor!.presenter!
        XCTAssertNotNil(presenter.viewController)
    }

    func testRouter() {
        XCTAssertNotNil(sut.router)
    }

    func testAutherListAPIInvocation() {
        let serviceWorker = sut.interactor?.serviceWorker
        let requestModel = AuthorsRequestModel()
        let exp = expectation(description: "Mock Service")
        Task { @MainActor in
            do{
                let resModel = try await serviceWorker!.fetchAuthors(requestModel: requestModel)
                XCTAssert(resModel.entries.count > 0)
                //verify at least one record
                XCTAssert(resModel.entries.first?.name == "user1")
                XCTAssert(resModel.entries.first?.url == "url1")
                XCTAssert(resModel.entries.first?.seedCount == 1)
                exp.fulfill()
            }catch{
                print(error)
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}
