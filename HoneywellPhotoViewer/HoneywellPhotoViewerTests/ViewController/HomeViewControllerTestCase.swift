//
//  HomeViewControllerTestCase.swift
//  HoneywellPhotoViewerTests
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import XCTest

@testable import HoneywellPhotoViewer

class HomeViewControllerTestCase: XCTestCase {
    var homeViewController : HomeViewController! = nil
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: AppConstants.mainStoryboardName, bundle: nil)
        homeViewController = storyboard.instantiateViewController(withIdentifier: AppConstants.Identifier.homeViewController) as? HomeViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeViewController = nil
    }
    
   

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK:- Test Cases
    
    
    
    
    // MARK: - Tableview Data Source TestCases
    func testNumberOfSections_ShouldBeCount1() {
        //ARRANGE
        setUpTableViewDataSource()
        setUpViewControllerToRootViewController()
        
        //ACT
        let noOfSection = homeViewController.numberOfSections(in: homeViewController!.tablePhoto)
        
        //ASSERT
        XCTAssertEqual(noOfSection, 1, "Incorrect number of Sections")
    }
    
    func testNumberOfRowsInSection0_ShouldBeCount2() {
        //ARRANGE
        setUpTableViewDataSource()
        setUpViewControllerToRootViewController()
        
        //ACT
        let rowCount = homeViewController.tableView(homeViewController.tablePhoto, numberOfRowsInSection: 0)
        
        //ASSERT
        XCTAssertEqual(rowCount, 2, "Incorrect number of rows")
    }
    
    func testcellForRowForPhotoItemCell() {
        //ARRANGE
        setUpTableViewDataSource()
        setUpViewControllerToRootViewController()
        let indexPath = IndexPath(row: 0, section: 0)
        
        //ACT
        let cell = homeViewController.tableView(homeViewController.tablePhoto, cellForRowAt: indexPath)
        //ASSERT
        XCTAssertEqual(cell.lblTitle.text , "Test1")
    }
    
    func testHeightForRow_ShouldReturnUITableViewAutomaticDimension() {
        //ARRANGE
        setUpTableViewDataSource()
        setUpViewControllerToRootViewController()
        let indexPath = IndexPath(row: 0, section: 0)
        
        //ACT
        let resultedDimension = homeViewController.tableView(homeViewController.tablePhoto, heightForRowAt: indexPath)
        
        //ASSERT
        XCTAssertEqual(resultedDimension, UITableView.automaticDimension)
    }
    
   
    
   
    
    func testPhotoServiceCall_ToCheckSuccessBlock() {
        //ARRANGE
        let mockPhotoServiceHelper = MockPhotoServiceHelper()
        homeViewController.photoServiceHelper = mockPhotoServiceHelper
        mockPhotoServiceHelper.webServiceCallShouldSucceed = true
        homeViewController.photoServiceCall()
        homeViewController.setUpData()
        setUpViewControllerToRootViewController()
        
        //ACT
        let noOfSection = homeViewController.numberOfSections(in: homeViewController!.tablePhoto)
        
        //ASSERT
        XCTAssertEqual(noOfSection, 1, "Incorrect number of section")
    }
    

    
    
    // MARK: - Helper Methods
    func setUpViewControllerToRootViewController() {
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func setUpTableViewDataSource(){
        let photoTestData = PhotoTestData()
        homeViewController.viewmodel.setupViewModels = photoTestData.getPhotoDataList()
    }

}

