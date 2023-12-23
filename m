Return-Path: <linux-kernel+bounces-10350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE781D336
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B365428469C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F38F68;
	Sat, 23 Dec 2023 08:42:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE28BEC;
	Sat, 23 Dec 2023 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rGxaG-0007C2-1G; Sat, 23 Dec 2023 09:42:12 +0100
Message-ID: <c91d32c9-58d2-4823-96e4-e31f51c966e2@leemhuis.info>
Date: Sat, 23 Dec 2023 09:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short
 lifetimes generating when they shouldn't, causing applications to fail
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221231115.12402-1-dan@danm.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20231221231115.12402-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1703320934;a6fc74d3;
X-HE-SMSGID: 1rGxaG-0007C2-1G

On 22.12.23 00:10, Dan Moulding wrote:
> I started running v6.7-rc5 on a desktop and began having problems
> where Chromium would frequently fail to load pages and give an
> "ERR_NETWORK_CHANGED" message instead. 

This is already handled, but to ensure that his does not fall through
the cracks due to the festive days let me quickly add it to the tracking:

#regzbot ^introduced 629df6701c8a
#regzbot title net/ipv6/addrconf: Temporary addresses with short
lifetimes generating when they shouldn't, causing applications to fail
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

