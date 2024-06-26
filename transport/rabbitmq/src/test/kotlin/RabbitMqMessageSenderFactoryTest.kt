/*
 * Copyright (C) 2023 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

package org.eclipse.apoapsis.ortserver.transport.rabbitmq

import com.rabbitmq.client.Channel
import com.rabbitmq.client.Connection
import com.rabbitmq.client.ConnectionFactory
import com.rabbitmq.client.Delivery

import io.kotest.assertions.throwables.shouldThrowWithMessage
import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe

import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.runs
import io.mockk.spyk
import io.mockk.verify

import java.lang.IllegalStateException
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

import org.eclipse.apoapsis.ortserver.model.orchestrator.AnalyzerWorkerResult
import org.eclipse.apoapsis.ortserver.model.orchestrator.OrchestratorMessage
import org.eclipse.apoapsis.ortserver.transport.AnalyzerEndpoint
import org.eclipse.apoapsis.ortserver.transport.Message
import org.eclipse.apoapsis.ortserver.transport.MessageHeader
import org.eclipse.apoapsis.ortserver.transport.MessageSenderFactory
import org.eclipse.apoapsis.ortserver.transport.OrchestratorEndpoint
import org.eclipse.apoapsis.ortserver.transport.RUN_ID_PROPERTY
import org.eclipse.apoapsis.ortserver.transport.TRACE_PROPERTY
import org.eclipse.apoapsis.ortserver.transport.json.JsonSerializer
import org.eclipse.apoapsis.ortserver.transport.testing.TEST_QUEUE_NAME

class RabbitMqMessageSenderFactoryTest : StringSpec({
    "Messages can be sent via the sender" {
        val config = startRabbitMqContainer("orchestrator", "sender")

        val payload = AnalyzerWorkerResult(42)
        val header = MessageHeader(traceId = "dick.tracy", ortRunId = 44)
        val message = Message(header, payload)

        val connectionFactory = ConnectionFactory().apply {
            setUri(config.getString("orchestrator.sender.serverUri"))
        }

        connectionFactory.newConnection().use { connection ->
            val channel = spyk<Channel>(
                connection.createChannel().also {
                    it.queueDeclare(
                        /* queue = */ TEST_QUEUE_NAME,
                        /* durable = */ false,
                        /* exclusive = */ false,
                        /* autoDelete = */ false,
                        /* arguments = */ emptyMap()
                    )
                }
            )

            val sender = MessageSenderFactory.createSender(OrchestratorEndpoint, config)
            sender.send(message)

            val latch = CountDownLatch(1)
            channel.basicConsume(
                TEST_QUEUE_NAME,
                true,
                { _: String, delivery: Delivery ->
                    val receivedMessage = String(delivery.body)

                    delivery.properties.headers[TRACE_PROPERTY].toString() shouldBe header.traceId
                    delivery.properties.headers[RUN_ID_PROPERTY].toString() shouldBe header.ortRunId.toString()

                    val serializer = JsonSerializer.forType<OrchestratorMessage>()
                    val receivedPayload = serializer.fromJson(receivedMessage)

                    receivedPayload shouldBe payload

                    latch.countDown()
                },
                { _: String -> true shouldBe false }
            )

            // Ensure that the callback was called asynchronously.
            latch.await(3, TimeUnit.SECONDS) shouldBe true
        }
    }

    "The channel is closed by the AutoClosable implementation" {
        val channel = mockk<Channel> {
            every { close() } just runs
        }

        val sender = RabbitMqMessageSender(
            channel = channel,
            queueName = TEST_QUEUE_NAME,
            endpoint = AnalyzerEndpoint
        )

        sender.close()

        verify { channel.close() }
    }

    "The connection is closed if the sender cannot be created" {
        val exceptionMessage = "RabbitMQ exception"
        val exception = IllegalStateException(exceptionMessage)

        val connection = mockk<Connection> {
            every { createChannel() } throws exception
            every { close() } just runs
        }

        val connectionFactory = mockk<ConnectionFactory> {
            every { newConnection(any<String>()) } returns connection
        }

        val factory = RabbitMqMessageSenderFactory()
        shouldThrowWithMessage<IllegalStateException>(exceptionMessage) {
            factory.createSenderWithConnection(AnalyzerEndpoint, connectionFactory, TEST_QUEUE_NAME)
        }

        verify { connection.close() }
    }
})
