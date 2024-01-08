Return-Path: <linux-kernel+bounces-19192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7842826994
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046A9B2133C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EB3BE49;
	Mon,  8 Jan 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=su-phil.net header.i=@su-phil.net header.b="ETNbNaDr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D238468
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=su-phil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=su-phil.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=su-phil.net
	; s=ds202310; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
	:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1i8D+JDWFcGIJpntjI1cJeRtp/4WsgdOK2r9XtyoTIw=; b=ETNbNaDruV8dg36iGvQ9ODBuxF
	ApU7JhS2Xs7bQmzi5KIX3HdwlUvTKJPXZgQdoJpksZuCNmZrD8BQJ7Llpz6dyW9yNYMRSPVbqVRAL
	7gvG9BH7HIPS0bY4WbiEzvPjaoRo+dHqZP0p5K43WI3F8pzQiy6jEdxIbpLCdsrgXJ5L/2FWUJfa/
	4jLHA9IP6LEY3pojmczh8V6iXZiaUcqTFNOuzfyvaQC8LL2BIJUyG/mSC2IqVLMxWc2x94IyuN/PU
	3mdkRWHvJ0byXE4jvNQ2oA6dQudBI2o+7ovmqKvXLqdseBKNJZnk+z85tDH1WGOzzOzh/+WqYpSXX
	nVZDyttw==;
Received: from [84.215.119.50] (port=62162 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <7@su-phil.net>)
	id 1rMl7E-000SJB-AZ
	for linux-kernel@vger.kernel.org;
	Mon, 08 Jan 2024 09:36:12 +0100
Message-ID: <f5c4d86c-bea5-47da-93aa-054eebe22aa3@su-phil.net>
Date: Mon, 8 Jan 2024 09:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Bit Sys (some more finetunings, was design concept,fair pay
 philosophy, low jitter)
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <7@su-phil.net>
To: linux-kernel@vger.kernel.org
References: <93a701b7-71cd-47e2-83f7-19e30c63f876@su-phil.net>
In-Reply-To: <93a701b7-71cd-47e2-83f7-19e30c63f876@su-phil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Mightaswell finetune this to Bit Sys. Overwriting also the X, and 
"operating". Simplifying things, and keeping the change to bitstream 
oriented instead of file oriented, and what I have said earlier of fair 
pay philosophy with roots in Iclam, and also low jitter internals.

It is now Ta Cin oriented, that I also considered earlier. (as a canon 
of earlier Cin designs).

A little videoseries here also on my chan where I test this out: 
https://www.youtube.com/playlist?list=PLkTsFr6AEJaz-6jCWek9kQWJdkgpXacFn

Hail Zi, Dev of The Cosmos, The Great, The Good.

-Peace.
Ywe Cærlyn.
https://su-phil.net/

