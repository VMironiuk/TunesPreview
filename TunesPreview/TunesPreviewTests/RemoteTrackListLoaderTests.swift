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

class RemoteTrackListLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, httpClient) = makeSUT()
        XCTAssertNil(httpClient.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "http://a-url.com")!
        let (sut, httpClient) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(httpClient.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (RemoteTrackListLoader, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let sut = RemoteTrackListLoader(httpClient: httpClient, url: url)
        return (sut, httpClient)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private(set) var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}
