//
//  LibraryManagementSystemTests.swift
//  LibraryManagementSystemTests
//
//  Created by Beehub on 07/12/20.
//

import XCTest
@testable import LibraryManagementSystem

class LibraryManagementSystemTests: XCTestCase {
    var viewControllerUnderTest: WelcomeViewController!
    
    var sut: UserRegistrationModel!
    let fullName = "Sergey"
    let email = "test@test.com"
    let password = "12345678"
    let confirmPassword = "12345678"
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeViewController

        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    
    func testUserModelStruc_canCreateNewInstance() {
        sut = UserRegistrationModel(FullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword)
        XCTAssertNotNil(sut)
    }
    
    func testUserFirstName_shouldPassIfValidFirstName() {
        sut = UserRegistrationModel(FullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword)
        XCTAssertTrue(sut.isValidFullName())
    }
    
    func testUserRegistrationModel_shouldPassIfValidEmail() {
            sut = UserRegistrationModel(FullName: fullName,
            email: email,
            password: password,
            confirmPassword: confirmPassword)
        XCTAssertTrue(sut.isValidEmail())
    }
        
    func testUserRegistrationModel_shouldPassIfInValidEmail() {
        sut = UserRegistrationModel(FullName: fullName,
        email: "test.com",
        password: password,
        confirmPassword: confirmPassword)
        XCTAssertFalse(sut.isValidEmail())
    }
        
    func testUserRegistrationModel_shouldPassIfValidPasswordLength() {
        sut = UserRegistrationModel(FullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword)
        XCTAssertTrue(sut.isValidPasswordLength())
    }
        
    func testUserPassword_passwordAndRepeatPasswordMustMatch() {
        sut = UserRegistrationModel(FullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword)
            
        XCTAssertTrue(sut.doPasswordsMatch())
    }
        
    func testUserPassword_shouldPassIfPasswordIsValid() {
        sut = UserRegistrationModel(FullName: fullName,
            email: email,
            password: password,
            confirmPassword: confirmPassword)
            XCTAssertTrue(sut.isValidPassword())
    }


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
