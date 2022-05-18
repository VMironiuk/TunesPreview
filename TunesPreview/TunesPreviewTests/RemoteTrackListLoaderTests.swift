//
//  RemoteTrackListLoaderTests.swift
//  TunesPreviewTests
//
//  Created by Vladimir Mironiuk on 18.05.2022.
//

import XCTest

final class RemoteTrackListLoader {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func load() {
        httpClient.get(from: URL(string: "http://a-url.com")!)
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
        let _ = RemoteTrackListLoader(httpClient: httpClient)
        XCTAssertNil(httpClient.requestedURL)
    }
}
