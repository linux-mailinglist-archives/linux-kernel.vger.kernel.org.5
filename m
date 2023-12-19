Return-Path: <linux-kernel+bounces-5933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66998191AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405531F25D35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5C39AF2;
	Tue, 19 Dec 2023 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOkVDQYK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632A39AD7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFD1C433C7;
	Tue, 19 Dec 2023 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703018513;
	bh=IBAg6KoMW0tpFU64tSRXNGdLF5fWVhdSLcYQeFL3PHI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XOkVDQYKuRO70/49YYxAJjDYMVckZI2lkjNNF6UqYJ5mljATLIk+M5k+A0p1zuks2
	 UB3h8jHiZYKBf2IjhXqidSzVoWhaXzFSFV9Ii7nI50C1pwsr6kLCspVgzM2Z9MScGa
	 hzoCOOlSU6NP1pDubNQLPjKVBuLcXalnHoz/vXiA3h6ZgeIEORPQNtwRteBe8pVYp6
	 CoaADkyfejRoQaXDivOs8h/aCUAJCJfcGTAGaxYKjPEqO6ZCJTTrZJkttVqWd55+CF
	 L3xn6ffprYIXHlAdsNkoX7OIicJz1pYYUBHRUadlAv5u77ZbUlh+uxExxf2pEZCkuX
	 E9tEUv4J7ag/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B83FCC41677;
	Tue, 19 Dec 2023 20:41:53 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <889dc07d-f00f-4012-985d-314da7dda52d@kernel.org>
References: <889dc07d-f00f-4012-985d-314da7dda52d@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <889dc07d-f00f-4012-985d-314da7dda52d@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.7-fixes
X-PR-Tracked-Commit-Id: 9a733dc4fbeec3f6d99645b845712b035e7440cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c749e61a1104ba9cf00519e723a7fa8ac55db0d
Message-Id: <170301851374.10204.8664760239849581601.pr-tracker-bot@kernel.org>
Date: Tue, 19 Dec 2023 20:41:53 +0000
To: Vineet Gupta <vgupta@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Pavel Kozlov <Pavel.Kozlov@synopsys.com>, Dan Carpenter <dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Dec 2023 21:19:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c749e61a1104ba9cf00519e723a7fa8ac55db0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

