//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import XCTest
import UIKit

@testable import Marvel

class MarvelTests: XCTestCase {
    var homeVC : HomeViewController!
    var detailVC : DetailViewController!
   
   
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //homeVC =  HomeViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
       
 
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    //test CommicBook model
    func test_init_takesTitle() {
        let commicBook = commic(thumbnailUrl: "", title: "Batman", description: "", imageUrl: "")
        XCTAssertNotNil(commicBook.title,"title should not be nil")
        
    }
    
    func test_init_whenGivenTitle() {
        let commicBook = commic(thumbnailUrl: "thunmbnailurl", title: "Batman", description: "batman movie", imageUrl: "imageUrl")
      
        XCTAssertEqual(commicBook.title,"Batman","should set tile")
    }
    
    func test_init_whenGivenDescription() {
        let commicBook = commic(thumbnailUrl: "", title: "", description: "batman movie", imageUrl: "imageUrl")
        
        XCTAssertEqual(commicBook.description,"batman movie","should set description")
    }
    
    func test_init_whenGivenThumnaleUrl() {
        let commicBooK = commic(thumbnailUrl: "http://google.com", title: "", description: "", imageUrl: "")
        
        XCTAssertEqual(commicBooK.thumbnailUrl,"http://google.com","should set description")
    }
    
    //test HomeViewController
    func testLoadingHomeView() {
         XCTAssertNotNil(homeVC.view)
    }
    
    func testHomeHasCollectionView() {
        homeVC.loadViewIfNeeded()
        XCTAssertNotNil(homeVC.collectionView)
    }
   
    func testHomeHasCDatasourse() {
        homeVC.loadViewIfNeeded()
        XCTAssertNotNil(homeVC.collectionView.dataSource)
    }
    
    func testHomeHasCDatasourseSet() {
        homeVC.loadViewIfNeeded()
        XCTAssertTrue(homeVC.collectionView.dataSource is HomeViewController)
    }
  
    func testHomeVCDelegate() {
        homeVC.loadViewIfNeeded()
        XCTAssertTrue(homeVC.collectionView.delegate is HomeViewController)
    }
    
    func testHomeVCNoOfsections() {
        homeVC.loadViewIfNeeded()
        XCTAssertEqual(homeVC.collectionView.numberOfSections , 1)
    }
    
//    func testloadtable() {
//        var sut =  CommicBook.sharedInstance.commicBooks
//        let commicBooK = commic(thumbnailUrl: "http://google.com", title: "", description: "", imageUrl: "")
//         homeVC.commicBooks  = [commicBooK]
//          homeVC.loadViewIfNeeded()
//        XCTAssertEqual(homeVC.collectionView.numberOfItems(inSection: 1),1)
//    }
    
}
