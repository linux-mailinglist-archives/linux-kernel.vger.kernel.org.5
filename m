Return-Path: <linux-kernel+bounces-18841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379278263DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4BA1F217B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482E12E43;
	Sun,  7 Jan 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=su-phil.net header.i=@su-phil.net header.b="c+2eCYU5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4F12B9A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=su-phil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=su-phil.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=su-phil.net
	; s=ds202310; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
	:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Su0J6PDwJjUaKIUfnQFKIpv0/g2f4+PTHB9mU/mQvp8=; b=c+2eCYU5aqpVReTM5JZUrUamjQ
	GEMdNQm2YdqW64CZyju4WpcSKWgD8FLkKOMq3nqy1OA4U6301ia4k+WQteap3qbJA3+TPIQkryLAI
	WiHWwDoTPvZ1bPI7Kl2a8pleFCd6pdwfKqyq/3lxOCCzxhumvZx0mtZ0D41XakMVWZXqhAaukB7R8
	hy69cCQ8YZ3heZ2N/w5E66ZcXLxCse1GEuSCZvGIjhN6s1019nzqfWRx3AZLwPGv+IqiiokxcJroV
	Di1E/BdHX0O5Wd8EF08SYM3DN32f494zwmi6pQNPvCWo5yBAFHh7eLOrF2SmCIdMpApQEf3yjoo4T
	007M7E8A==;
Received: from [84.215.119.50] (port=59825 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <7@su-phil.net>)
	id 1rMQvB-00DTZe-Du
	for linux-kernel@vger.kernel.org;
	Sun, 07 Jan 2024 12:02:25 +0100
Message-ID: <89cfbbb2-5f3d-4606-9578-f33b811062d1@su-phil.net>
Date: Sun, 7 Jan 2024 12:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bit-X (was low-jitter, philosophy etc)
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <7@su-phil.net>
To: linux-kernel@vger.kernel.org
References: <93a701b7-71cd-47e2-83f7-19e30c63f876@su-phil.net>
In-Reply-To: <93a701b7-71cd-47e2-83f7-19e30c63f876@su-phil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bit-X summary:

I´ve talked about various philosophical aspects of a good unix 
derivative. Bit-X is about all this, such as fair pay principles with 
basis in The Quran, The Bible will not work here as it is too incoherent.
The Christian Church seems much able to be replaced with an AB 
principles. That many know from christian culture, that you need to 
emulate B as an A, but can be an A(ce) when it is possible.

This goes for GUI design aswell. B here might be Bi, which follows the 
thinking of some of what the devs on Amiga have stated, and later BeOS.

I was a mascot with protracker in the Amiga days, and I have some 
concept art of a follow up on this on my channel aswell: 
https://www.youtube.com/@BiT_The_Haqon_from_Hyperia/

Basically this would be the B channel. The A channel really is Iclamic, 
Adli,  like AB principle states, it really matters subconsciously.

Adli means follower of Justice, and replaces Amiga here also.

And one can ofcourse be an A with a low-jitter kernel config, and CPU 
design, and acceleration of commonly used C functions on CPU, for inner 
loop low jitter optimization.

-Peace!
Ywe Cærlyn
https://su-phil.net/

