//
//  Client.swift
//  GPUWindow (iOS)
//
//  Created by 齐旭晨 on 2022/3/23.
//

import Foundation
import NIO

class TCPClientHandler: ChannelInboundHandler{
    typealias InboundIn = ByteBuffer
    typealias OutboundOut = ByteBuffer
    private var numBytes = 0
    
    func channelActive(context: ChannelHandlerContext) {
        let message = "SwiftNIO rocks!"
        var buffer = context.channel.allocator.buffer(capacity: message.utf8.count)
        buffer.write(string: message)
        context.writeAndFlush(wrapOutboundOut(buffer), promise: nil)
    }
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var buffer = unwrapInboundIn(data)
        let readableBytes = buffer.readableBytes
        if let received = buffer.readString(length: readableBytes){
            print(received)
        }
        if numBytes == 0{
            print("noting left to read, close the channel")
            context.close(promise: nil)
        }
    }
    
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: \(error.localizedDescription)")
        context.close()
    }
}
