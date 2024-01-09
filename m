Return-Path: <linux-kernel+bounces-21542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B38290ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B51F26974
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7FE3E49C;
	Tue,  9 Jan 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmkI/Ezz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C973E487
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 554CCC433A6;
	Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843713;
	bh=Je3NMIwkcRM+RxSMehX2MUFdyKYQbqQBv3ZfMg/ndoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nmkI/EzzWwmZ2q0HBOV+vtEX0iA95dRsjiLSiRRpFVm1cPbQ0UqFVqD7IEQTfrVTn
	 YsatKh4v8rfKthasFOc3cdp514fhw8XPdxIw4ln+ZqctMIK7Pp+ZGEPa/WIfUvl/hO
	 G3GCbBvTtCUcj4k67sJKMpWN2/zKp7YOP9LR9NhCGHd+nAGucZAsvT7IFjIozqXOMg
	 Q0YEq2vHyEKKNDUnhs0Ln+1cJmvLNh8/MTSTu+S0wNItEiheA6aOUS/xdQiK7Sbq0w
	 GHVhXz/M/PMNXOHq3N45CtHYsElG9EBa6jjdZoZd77tgLtMzQpXMoU9AxmAUbBXkvB
	 AUFctRrZlVKNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44B23C4167D;
	Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107223803.33F1BC433C7@smtp.kernel.org>
References: <20240107223803.33F1BC433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107223803.33F1BC433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.8
X-PR-Tracked-Commit-Id: 1cadc04c1a1ac5015c2eb0fadfabf4b61bbe167e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da96801729b43eb6229425a23b7bdf6045685251
Message-Id: <170484371327.10226.1901922768551284228.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 23:41:53 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 07 Jan 2024 22:37:54 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da96801729b43eb6229425a23b7bdf6045685251

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

