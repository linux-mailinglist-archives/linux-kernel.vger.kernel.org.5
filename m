Return-Path: <linux-kernel+bounces-18687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DE826100
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0051F22343
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B318D289;
	Sat,  6 Jan 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=su-phil.net header.i=@su-phil.net header.b="psot61m/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC1CA67
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=su-phil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=su-phil.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=su-phil.net
	; s=ds202310; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YrxEf8rbIYdkJxzs5xHnxttBnbH6PA+qgALUhYYiWls=; b=psot61m/VffWIzNJNuEpgV+kSX
	8JeIhWxWrzlZspCvQYiPpRdoqjMXtkf1rxUBAOtX4nCYpSt1Oa543e+7VWUdx+j3osbP/BODwJLmt
	BJGXTw3pPJUZ3AVc/+9MZMzZvXpUC4aMZ4wy9jFEs0uJrwFgq01CWFWqD1Z9tSLQSTELNXQ6UL2EI
	xODRNkEsy3kYtP4Qyv2TzIOVkNMM1nsWs5eWQ5bxSaQ5/y2TEp4hiKAAOd8uNnIU5i4+52nUeiFc4
	NEBuzgfpfBjBT2BG0xWdgWac221XWnCF3NF9dYFpO0v6xopyZjxAjTUvE5S6XM6QegQIUdxekISdJ
	t0Oa3fNw==;
Received: from [84.215.119.50] (port=56581 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <7@su-phil.net>)
	id 1rMBBG-00Aku3-KF
	for linux-kernel@vger.kernel.org;
	Sat, 06 Jan 2024 19:13:59 +0100
Message-ID: <93a701b7-71cd-47e2-83f7-19e30c63f876@su-phil.net>
Date: Sat, 6 Jan 2024 19:13:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <7@su-phil.net>
Subject: Bit X (was design concept, philosophy, low jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I´ve further finetuned things to Bit X.

See also this video series for the background: 
https://www.youtube.com/playlist?list=PLkTsFr6AEJaz-6jCWek9kQWJdkgpXacFn

Peace.

