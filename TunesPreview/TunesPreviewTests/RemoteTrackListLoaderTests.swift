//
//  RemoteTrackListLoaderTests.swift
//  TunesPreviewTests
//
//  Created by Vladimir Mironiuk on 18.05.2022.
//

import XCTest

final class RemoteTrackListLoader {
    private let httpClient: HTTPClient
    private let url: URL
    
    init(httpClient: HTTPClient, url: URL) {
        self.httpClient = httpClient
        self.url = url
    }
    
    func load() {
        httpClient.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    private(set) var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteTrackListLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let httpClient = HTTPClientSpy()
        let _ = RemoteTrackListLoader(httpClient: httpClient, url: URL(string: "http://a-url.com")!)
        XCTAssertNil(httpClient.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let httpClient = HTTPClientSpy()
        let sut = RemoteTrackListLoader(httpClient: httpClient, url: URL(string: "http://a-url.com")!)
        sut.load()
        XCTAssertNotNil(httpClient.requestedURL)
    }
}
