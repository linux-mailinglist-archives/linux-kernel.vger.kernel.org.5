Return-Path: <linux-kernel+bounces-13260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA208820222
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D83B221E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261214A91;
	Fri, 29 Dec 2023 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="j0w+FEdR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from libero.it (smtp-33-i2.italiaonline.it [213.209.12.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B414A90
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.176] ([87.20.18.66])
	by smtp-33.iol.local with ESMTPA
	id JL6tr7Gwz0IGyJL6trFXOH; Fri, 29 Dec 2023 23:13:43 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1703888023; bh=QAgNQYVvdXMqtQI+ITro3NvpQypcSHvbfAFVwQ1/vgg=;
	h=From;
	b=j0w+FEdRr0dO6y0OEXKx3DP54qS6d6jgZZwA7ahYMTAtAvbekxfFPwlqd+Ystcoj6
	 6wYr567EYwC7Vz5DFKx/4D9M08UXJ2JDlo7NQFEtR1+av6WeQHvYyH4uBKEe/G9St1
	 yCU5qgjAdfhPGSFi/i8dGOGRHp61TN8qH2K9KJwXOboAqOJ/gyd7C6xzfshUhsIcvI
	 G9jkfbDJykHpHQHcoUDN8fFErhwBAzqU7h9P0DRkV2NjAf7Aamz9UWhX7zl9vpEjMg
	 aLraRlW50oGc85Fgbt6OZlElGdAO/+c2M3M+aroKBRI/SGNJWqhSG+WdNKW8cFt+As
	 9LY16U67Vuo+g==
X-CNFS-Analysis: v=2.4 cv=WdjKKWtX c=1 sm=1 tr=0 ts=658f4497 cx=a_exe
 a=3SqfP+zelxMsqVWg0RdiUA==:117 a=3SqfP+zelxMsqVWg0RdiUA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=f3xpugNLimARsEotuToA:9 a=QEXdDO2ut3YA:10
 a=hwl4U-1iQxQA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <cc4f334a-f8e7-8130-2a12-1a64b315ca3b@inwind.it>
Date: Fri, 29 Dec 2023 23:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: it-IT
To: linux-kernel@vger.kernel.org
From: Valerio Vanni <valerio.vanni@inwind.it>
Subject: Unable to unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 231229-2, 29/12/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfI7tXLeyirRTDeiK6Dgq8KG+tv7H/kFmmtH8Exu/o/0R/4JQ2ZaoXMdU9KxJdnm+xxgrvhHX+7mF4joUTW71/y8zDFH6tAgafd50LRcBe+DsutlLvyp/
 lvPQ08RjhSxMMBz3f/+3f1Bx4IZgpuQgqtKqVY7jZeD9OZlWf5JxAJHRoKL2F7+L/eKIFUhM8zK4D04XeHwvryFxJj2NV85x+9Y=

I read here
https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo
that to subscribe and unsubscribe a list I have to use the link provided.

For linux-kernel I find:
linux-kernel+unsubscribe@vger.kernel.org

I wrote two o three times, but nothing happens. I don't get any error 
oro bounce messages. Simply, it doesn't work: I continue to receive 
messages.

At the same time, I was trying to subscribe linux media with
linux-media+subscribe@vger.kernel.org

But, again, nothing happens.

Is there any other way?

I wrote also to postmaster@vger.kernel.org

