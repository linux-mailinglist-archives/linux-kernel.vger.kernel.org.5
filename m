Return-Path: <linux-kernel+bounces-24037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282E82B5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3199A28C78D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3A57886;
	Thu, 11 Jan 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ejaSE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DA5786E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52AE0C433B1;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705004419;
	bh=xAPLs0kZHPOYpKOC62JeUurrSrZCNPiIncXgGOfRsKc=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=g5ejaSE40SurMU+ltRgcKX2h+Hjv11GHO9hEdWZfwCCcsCPfVtxhKn5Yq9XC636oX
	 E+vSTMujaoOhCAijadxxGBIErLnJeRpse4U9wU9YTLwnSbT2tf6uHckDsm+zd4gFT4
	 TP1zy19NwsKckXm9FZGI2ICUOODqVCRamWEaRys+SqL3z9+XIvLHTlM7SHnJFeEXF2
	 EjYasUfWNOcrqXVbtsg8/e+pqymxdP+HA7gdQM9P6YcMg3CcBZvOHPmQ/jleveph85
	 jd5dUgYUKnYCepJ0Nezt42ex2JQmPWY6mnPUfEr3zQR7qykmxh4l4Lr/qyIFYItQai
	 WID3NkaUQhF+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EFDBD8C972;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] ARM: SoC code changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab382a86-641b-477d-b6da-7398c600395b@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com> <ab382a86-641b-477d-b6da-7398c600395b@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <ab382a86-641b-477d-b6da-7398c600395b@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.8
X-PR-Tracked-Commit-Id: 40974ee421b4d1fc74ac733d86899ce1b83d8f65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb249b275c591f064853157bf2b378fcedd6381b
Message-Id: <170500441925.14602.18328511720524613530.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 20:20:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 17:19:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb249b275c591f064853157bf2b378fcedd6381b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

