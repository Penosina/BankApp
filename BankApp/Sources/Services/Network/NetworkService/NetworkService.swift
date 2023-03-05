//
//  NetworkService.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import Alamofire
import PromiseKit

final class NetworkService: NetworkServiceProtocol {
	let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>

	init(authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>) {
		self.authInterceptor = authInterceptor
	}

	func request<T: Decodable>(method: HTTPMethod,
							   url: URLConvertible,
							   authorized: Bool = false,
							   headers: HTTPHeaders? = nil,
							   parameters: Parameters? = nil) -> Promise<T> {
		let request = AF.request(url,
								 method: method,
								 parameters: parameters,
								 encoding: method == .get ? URLEncoding(arrayEncoding: .noBrackets) : JSONEncoding.default,
								 headers: headers,
								 interceptor: authorized ? authInterceptor : nil)
		return Promise { seal in
			firstly {
				Promise { seal in
					request.responseData { response in
						seal.fulfill(response)
					}
				}
			}.then { response in
				self.handleResponse(response)
			}.done { object in
				seal.fulfill(object)
			}.catch { error in
				seal.reject(error)
			}
		}
	}

	private func handleResponse<T: Decodable>(_ response: AFDataResponse<Data>) -> Promise<T> {
		return Promise { seal in
			if response.response?.statusCode == HTTPStatusCode.unauthorized.rawValue {
				seal.reject(NetworkServiceError.unauthorized)
				return
			}

//			if case .failure(let error) = response.result {
//				seal.reject(error.underlyingError ?? error)
//				return
//			}

			let statusCode = HTTPStatusCode(rawValue: response.response?.statusCode ?? 500)

			switch statusCode {
			case .okStatus, .created, .accepted, .noContent:
				if let data = response.data {
					decode(data, ofType: T.self).done { object in
						seal.fulfill(object)
					}.catch { error in
						seal.reject(error)
					}
				} else if T.self == EmptyResponse.self, let response = EmptyResponse() as? T {
					seal.fulfill(response)
				} else {
					seal.reject(NetworkServiceError.noData)
				}
			default:
				seal.reject(NetworkServiceError.requestFailed)
			}
		}
	}

	private func decode<T: Decodable>(_ data: Data, ofType type: T.Type) -> Promise<T> {
		return Promise { seal in
			do {
				let object = try JSONDecoder().decode(type.self, from: data)
				seal.fulfill(object)
			} catch {
				print(error)
				seal.reject(NetworkServiceError.failedToDecodeData)
			}
		}
	}
}
