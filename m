Return-Path: <linux-kernel+bounces-2843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF08162BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A870282976
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61449F7B;
	Sun, 17 Dec 2023 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cufp2tts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C249F72
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D68FC433C7;
	Sun, 17 Dec 2023 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702851005;
	bh=IsFXbMEAhL78dopsPaTbt8vF8iZPvbL1jfvww3k77ao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cufp2ttsbZdkf9882hOVsgLvUaQTQbRkpxOElAX/odcKVBK9hDMctXdAXhqqqf1HI
	 Yxg3wmBigG+iQ7wtXCeyLfAHbHtP3accqM7WTG7XBDzRYHJc/gKFpn1tGokjmrh1GH
	 cVFmg3LnBcAH70UFRfx/at44s2yvySTcE8SnaCSB3GpY+JT4mj+Fch0tjcvRAaF3tL
	 3612bpaBar0Q81x7LRh/gNjc627ZW6PK0L9ed2AxFNQ7wt15LZhg2PFL0Bg2OK+Dew
	 yT+c3fPaFoSk948y1IiKlCQCBk/y/+GJEZo03787TD6NdJWdXcoAwOjRmW5NIK7cHl
	 YYFzzqXaY+9GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFF1DE2A04A;
	Sun, 17 Dec 2023 22:10:04 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231217202613.GAZX9ZZWMM/ytA74VC@fat_crate.local>
References: <20231217202613.GAZX9ZZWMM/ytA74VC@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231217202613.GAZX9ZZWMM/ytA74VC@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc6
X-PR-Tracked-Commit-Id: 7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 177c2ffe69555dde28fad5ddb62a6d806982e53f
Message-Id: <170285100491.18163.16735829252667356500.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 22:10:04 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 21:26:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/177c2ffe69555dde28fad5ddb62a6d806982e53f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

