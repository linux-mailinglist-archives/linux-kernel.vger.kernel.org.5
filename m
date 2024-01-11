Return-Path: <linux-kernel+bounces-24038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189AA82B5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FB01F24B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA125788B;
	Thu, 11 Jan 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUxbSmP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AF57873
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80144C433B2;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705004419;
	bh=Mq9+/BoFQY0JzZNuA0jOTyobGVKGRsHORK8Xgv3AUOc=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=lUxbSmP8Hzvv1gQoZZatahc7TsUEH5iieD/rzz1yOJwhnNM9h0hu0FR/z8pjMiAlf
	 wdU3Mp+WhPL4Lik1UvZjHNFT3QA/Px/gLvVpvItg/uTFrWXj8RbGXNBiIB36ebOZTn
	 w4vLWdnCT4qQr6Wsxt1fHx6qQFVt1uSIIpE/0kTkY/GtK9kWmjDM2zEURnXUb2JW9O
	 pTcxNKnVVCWAJUaufzAOBIT3HNzsaKjmfgboxjnbXHY5bTtEc1CeCkAH/RgorJg+37
	 sfQsJPI2f41PF3E4uAyja0XhygH6lYScmVD4E4u13nciDnkI9aFG5SgW/7f3KQCvWQ
	 fDIcVH8lfetow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C437D8C974;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <3c697540-fa12-45e3-9662-521688f8d14e@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com> <3c697540-fa12-45e3-9662-521688f8d14e@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <3c697540-fa12-45e3-9662-521688f8d14e@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.8
X-PR-Tracked-Commit-Id: c2dba4d19f6542e52e59873a596cce0388d0df64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bad490858c3ebdbb47e622e8f9049f828d2abba
Message-Id: <170500441943.14602.9293827223673270137.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 20:20:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 17:20:36 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bad490858c3ebdbb47e622e8f9049f828d2abba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

