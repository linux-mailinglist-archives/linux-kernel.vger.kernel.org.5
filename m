Return-Path: <linux-kernel+bounces-13951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FC82157F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD187281CED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAEAF9C8;
	Mon,  1 Jan 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="CQLPc2Iq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from libero.it (smtp-33-i2.italiaonline.it [213.209.12.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC150F9C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.176] ([87.20.18.66])
	by smtp-33.iol.local with ESMTPA
	id KQTkrVxdl0IGyKQTkrOG02; Mon, 01 Jan 2024 23:09:48 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1704146988; bh=mDe350ZREd+2N67YfHmo9OtfQvcQA9XR54gWaDV8xMo=;
	h=From;
	b=CQLPc2Iq5XGEs5KH4SbHg9vAjrOOatWqX33EpV6cqeHmlCUJbYMjOD+G5HwczAv3r
	 Go6dNlhGYD8tr1U7xEvve1yjCHBIG0qzdNgsWJJZb1uQf3iV1Eml5pUvYCfXqkWokH
	 ffsgiIYDHlEkbuEqca2ISGwU3GEtieaHT8gJiixntkaC3+CgNnU1FZiSUj12lwjphW
	 Sf9Yj91TtseEB+jA01jizlGGnQz9LVszrEh0LmaL42V+VTccvuJy+nUEuitKCciS7N
	 pV1VMuZAUZlDVYY6A9YIXgXTrUOqmDoO75YXd17NVEUUhXdHVoNfBSTPHouogA4OW8
	 aYu6V6Zu5doEg==
X-CNFS-Analysis: v=2.4 cv=WdjKKWtX c=1 sm=1 tr=0 ts=6593382c cx=a_exe
 a=3SqfP+zelxMsqVWg0RdiUA==:117 a=3SqfP+zelxMsqVWg0RdiUA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=f3xpugNLimARsEotuToA:9 a=QEXdDO2ut3YA:10
 a=hwl4U-1iQxQA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <d90fd289-0535-c4ab-8dc0-5e0fb0a36a72@inwind.it>
Date: Mon, 1 Jan 2024 23:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
From: Valerio Vanni <valerio.vanni@inwind.it>
Subject: Unable to unsubscribe
To: linux-kernel@vger.kernel.org
Content-Language: it-IT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 231230-2, 30/12/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfKkam4ZT6jdXUHtrTRHqo1USCi8IkwNRXw6JRpPRuDacUHKNRNUbuo6L628HOu5VdxPoraiMmymJFECetOe6A/ORV6PEJFfpLxuZ1GI5WSYWZTLlRZiX
 O0CJfuHQSSJ418+zMI8qmRsgPt/55Ff4jxqf8BUddXARM3owDsNjHYzdkSAlEOysHtVTz4N6rMHf+XcXIKj1d7qDT7iYmVRbx6E=

Some time I subscribed to linux-kernel list, but now I want to unsubscribe.

I read here
https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo
that to subscribe and unsubscribe a list I have to use the address provided.

For linux-kernel I find:
linux-kernel+unsubscribe@vger.kernel.org

I wrote two o three times, but nothing happens. I don't get any error 
oro bounce messages. Simply, it doesn't work: I continue to receive 
messages.

At the same time, I was trying to subscribe linux media with
linux-media+subscribe@vger.kernel.org

But, again, nothing happens.

Is there any other way?

I wrote also to postmaster@vger.kernel.org, but got no answer.

