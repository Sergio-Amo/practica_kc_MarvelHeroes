//
//  MarvelHeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Sergio Amo on 17/11/23.
//

import XCTest
import Combine
import SwiftUI
import ViewInspector
@testable import MarvelHeroes

final class MarvelHeroesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMarvelHerosModel() throws {
        let heroes = [
            Hero(id: 1, name: "Foo", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),
            Hero(id: 2, name: "Bar", description: "LoremIpsum",
                 thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: nil))
        ]
        let model = MarvelHeros(code: 200, data: DataClass(offset: 0, total: 2, count: 2, results: heroes))
        
        XCTAssertNotNil(model)
        XCTAssertEqual("Foo", model.data?.results![0].name)
        
        let fullPath = model.data?.results![0].thumbnail?.thumbnailFullPath
        let testUrl = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
        XCTAssertEqual(testUrl, fullPath)
        let fullPathNilExtension = model.data?.results![1].thumbnail?.thumbnailFullPath
        XCTAssertNil(fullPathNilExtension)
    }
    
    func testMarvelSeriesModel() throws {
        let series = [
            Serie(id: 1, title: "Foo", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            Serie(id: 2, title: "Bar", description: "foo bar", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/00/51644d6b47668", thumbnailExtension: "jpg"))
            
        ]
        let model =  MarvelSeries(code: 200, data: SeriesDataClass(offset: 0,
                                                                   total: 14549,
                                                                   count: 2,
                                                                   results: series))
        
        XCTAssertNotNil(model)
        XCTAssertEqual("Foo", model.data?.results![0].title)
        XCTAssertNil(model.data?.results![0].description)
    }
    
    func testRootViewModel() {
        let expectation = self.expectation(description: "hero result")
        var suscriptor = Set<AnyCancellable>()
        
        let vm = RootViewModel(debug: true)
        XCTAssertNotNil(vm)
        
        vm.marvel.publisher
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTAssertEqual(1, 1) // Ok
                        expectation.fulfill()
                    case .failure:
                        XCTAssertEqual(1, 2) // Error
                        expectation.fulfill()
                }
            } receiveValue: { data in
                XCTAssertEqual(1, 1)
            }
            .store(in: &suscriptor)
        
        vm.getHerosTesting()
        
        self.waitForExpectations(timeout: 10)
    }
    
    func testHeroViewModel() {
        let hero = Hero(id: 1, name: "Foo", description: "LoremIpsum",
                        thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg"))
        
        let expectation = self.expectation(description: "hero result")
        var suscriptor = Set<AnyCancellable>()
        
        let vm = HeroViewModel(hero: hero, debug: true)
        XCTAssertNotNil(vm)
        
        vm.series.publisher
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTAssertEqual(1, 1) // Ok
                        expectation.fulfill()
                    case .failure:
                        XCTAssertEqual(1, 2) // Error
                        expectation.fulfill()
                }
            } receiveValue: { data in
                XCTAssertEqual(1, 1)
            }
            .store(in: &suscriptor)
        
        vm.getSeriesMock(from: 1)
        
        self.waitForExpectations(timeout: 10)
    }
    
    func testUrlExtension() {
        let secureURL = URL(string: "https://developer.marvel.com")!
        let url = URL(string: "http://developer.marvel.com")!
        let securedUrl = url.upgradeUrlScheme(url)
        XCTAssertEqual(secureURL, securedUrl)
    }
    
    func testUrlResponseExtension() {
        let url = URL(string: "https://developer.marvel.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/3.0", headerFields: nil)
        
        XCTAssertEqual(response?.getStatusCode(), 200)
    }
    
    func testHeroView() throws {
        let hero = Hero(id: 1, name: "Foo", description: "LoremIpsum",
                        thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg"))
        let view = HeroView(viewModel: HeroViewModel(hero: hero, debug: true))
        XCTAssertNotNil(view)
        
        let itemCount = try view.inspect().count
        XCTAssertEqual(itemCount, 1)
        
        //ScrollView
        let scroll = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(scroll)
        
        //HScroll
        let hScroll = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(hScroll)
        
        //Zstack
        let zstack = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(zstack)
        
        //WebImage
        let webImg = try view.inspect().find(viewWithId: 3)
        XCTAssertNotNil(webImg)
        
        //hero name
        let name = try view.inspect().find(viewWithId: 4)
        XCTAssertNotNil(name)
        
        XCTAssertEqual(try name.text().string(), "Foo")
    }
    
    func testSerieCellView() throws {
        let view = SeriesCellView(serie: Serie(id: 1, title: "Foo", description: "Desc", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")))
        
        XCTAssertNotNil(view)
        
        let itemCount = try view.inspect().count
        XCTAssertEqual(itemCount, 1)
        
        //zStack
        let zStack = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(zStack)
        
        //WebImage
        let webImg = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(webImg)
        
        //serie title
        let title = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(title)
        XCTAssertEqual(try title.text().string(), "Foo")
        
        //SystemImage
        let sysImg = try view.inspect().find(viewWithId: 3)
        XCTAssertNotNil(sysImg)
        XCTAssertEqual(try sysImg.image().actualImage().name(), "chevron.compact.down")
        
    }
}

