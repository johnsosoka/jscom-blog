---
layout: post
title: "Weekend Project: LLM Contact Classifier & Spam Filter"
category: blog
tags: llm classifier langchain aws lambda python chatgpt openai
---

It has been a while since I've published a technical blog post on here, so I'm easing back in with something simple--but
useful. I've had a contact form on this website for years now, I haven't touched it since [this blog post](/blog/2022/02/15/contact-form-service-enhanements.html)
way back in 2022.

## Today's Project

The ultimate goal of this project is to both classify incoming contact messages & automatically filter out spam. I already 
have existing infrastructure for blocking an IP address or user-agent string, but I wanted to take it a step further and
automate the process with an LLM. 

Currently there is an AWS lambda function that receives messages from an API Gateway endpoint, performs some basic validations
and the publishes to an incoming message SQS queue. A second lambda function reads from that queue, checks the sender's IP address
and user-agent string against a DynamoDB table of blocked contacts, and if the sender is not blocked, it republishes the message to a 
second SQS queue which triggers a 3rd lambda function that sends the email to me.

We'll be targeting the filtering lambda function for this project. The existing flow will remain the same, but we'll add an
LLM classification step before the message is forwarded to the notification queue.

