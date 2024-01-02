Return-Path: <linux-kernel+bounces-14228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FC82197A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FAF282EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6AD285;
	Tue,  2 Jan 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="bn4nZhdY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from libero.it (smtp-33-i2.italiaonline.it [213.209.12.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FCD26A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.176] ([87.20.18.66])
	by smtp-33.iol.local with ESMTPA
	id KbmDraFda0IGyKbmDrPseW; Tue, 02 Jan 2024 11:13:37 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1704190417; bh=O/zBqgBl5vL9jMlqXtMBXvRre2CeY3lfqNQQDtwpxhA=;
	h=From;
	b=bn4nZhdYLnk2gLACDeq1a31HaffOFely3Alxyam8vZNRv/UnOiypjSf9H38DJjoN7
	 nO12w1ovx3Qhpw9MBPEa1ViMqWP6MDR1w2GonH++PnVejPEJ6oied39gnlGcGWvU2V
	 hDbnRIdP6ZcPwoSHBzt4aL5qOW241Ik/XUxIotnNBE4SwBzdXXlIHdx7u+H9Pkwwvr
	 mzmh7mrAKrP8E1Rj7doz0g/H11XhlGiDjFrlL3Y+V4klj3vzBIWdf0JL7EbdVTECMq
	 /LyPcJpka0k38Ev7i4VAomdQh/ib+S/aXvS6JSpLkOGAH/pCsjpQShcN3XIKpbk9wy
	 ywxyFqQs+oq7w==
X-CNFS-Analysis: v=2.4 cv=WdjKKWtX c=1 sm=1 tr=0 ts=6593e1d1 cx=a_exe
 a=3SqfP+zelxMsqVWg0RdiUA==:117 a=3SqfP+zelxMsqVWg0RdiUA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=B5Cm0-LDo6s1g1MxHbQA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <55810ab0-c5a4-7ff7-4c8e-046b4ebbd567@inwind.it>
Date: Tue, 2 Jan 2024 11:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: Unable to unsubscribe
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <d90fd289-0535-c4ab-8dc0-5e0fb0a36a72@inwind.it>
 <20240102-laughing-tacky-bettong-d63ab6@lemur>
Content-Language: it-IT
From: Valerio Vanni <valerio.vanni@inwind.it>
In-Reply-To: <20240102-laughing-tacky-bettong-d63ab6@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 240102-0, 2/1/2024), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfMTn/stfcG8+XRhM9bksHKTle0KRV6gYCeahPgPhdztKuV96g5styuMzxMtwdQJ3yWrbRnwSTyuX/3F+S2lbVUKUYHPn2WV9zHzWo+moNDt5Y+aE46RZ
 ZY4aGDMC589lue6CGSYBnxLTr8dIVeRN5UU0eQiO9SvEgo0RgFhNTEp2/JGT/n1bwWIkiObodmSRXV7RekscdfoUH+lVigOPsapXvNKijwpL21YUX20Qb2G0
 CFCCrPbiOka204hMF9IwcA==

Il 02/01/2024 06:35, Konstantin Ryabitsev ha scritto:

>> For linux-kernel I find:
>> linux-kernel+unsubscribe@vger.kernel.org
>>
>> I wrote two o three times, but nothing happens. I don't get any error oro
>> bounce messages. Simply, it doesn't work: I continue to receive messages.
> 
> I see your unsubscription requests and I can see that we send a confirmation
> message to you. Can you please check all of your folders? The subject is
> "Confirm unsubscribe from linux-kernel@vger.kernel.org".

I found them in SPAM folder. It's not downloaded with POP, now I've 
looked with webmail.

Now I see that many list messages are detected as SPAM from my provider.

Thank you.

>> I wrote also to postmaster@vger.kernel.org, but got no answer.
> 
> It's holidays. :)

:-)


