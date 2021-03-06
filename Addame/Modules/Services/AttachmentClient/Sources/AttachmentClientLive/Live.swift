//
//  Live.swift
//  
//
//  Created by Saroar Khandoker on 27.01.2021.
//

import Combine
import Foundation
import FuncNetworking
import AttachmentClient
import AddaMeModels
import InfoPlist

public struct AttachmentAPI {
  
  public static let build = Self ()
  
  private var baseURL: URL { EnvironmentKeys.rootURL.appendingPathComponent("/attachments") }
  
  func updload(avatar: Attachment) -> AnyPublisher<Attachment, HTTPError> {
    let builder: Request = .build(
      baseURL: baseURL,
      method: .post,
      authType: .none,
      path: "",
      contentType: .json,
      dataType: .encodable(input: avatar)
    )
    
    return builder.send(scheduler: RunLoop.main)
      .map { $0 }
      .catch { (error: HTTPError) -> AnyPublisher<Attachment, HTTPError> in
        return Fail(error: error).eraseToAnyPublisher()
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

}

extension AttachmentClient {
  public static func live(api: AttachmentAPI) -> Self {
    .init(uploadAvatar: api.updload(avatar:))
  }
}
