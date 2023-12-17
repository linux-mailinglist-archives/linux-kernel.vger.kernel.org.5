Return-Path: <linux-kernel+bounces-2750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B218A816150
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681381F216A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78246BAB;
	Sun, 17 Dec 2023 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAAQKcHz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855E46445
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61330C433C7;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834726;
	bh=qW5hJEwrSMQJFYMnlP3CivfmgYFOwz7HfJr+7L9ZrWA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QAAQKcHzJ+vGaElYfu3jxv2zm2j1nRiaWXWzL4fOhtHr33r0M1L32AHpa3Ee1Hs9A
	 1NtQHSsIQPSTfOiYmQyvcLDPq88Le/MrUvJYM3m5IWzxZ/RMXqIK9XZjP6Hn4IQEvC
	 zrxXWuBRmVq9KvT8CCU+/RY2Rg7BGDTBeDp6gx7NATqRX7Yckka+N0wuNb41XJG/+8
	 267k2F4jwD9XmOPJbXjBybMafLJKmPPujlf6SEph5HAMl/htrxPxZ6CWdqFVG5Gp6G
	 Gl4e1nX9+baAskCD+lbd009Ctr1ycQboQAIOYlKkraAHTGxEM0OZx+f/dJEUNSm3s4
	 dfAVvBw2HpBJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43189C4314C;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZX8mcsYczF3bDOEy@matsya>
References: <ZX8mcsYczF3bDOEy@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZX8mcsYczF3bDOEy@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.7
X-PR-Tracked-Commit-Id: 4ee632c82d2dbb9e2dcc816890ef182a151cbd99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d04b70ea48b2d84ebf6cd9ad9b01ba50a58542e
Message-Id: <170283472627.25242.8188166217978914336.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:46 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 22:18:50 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d04b70ea48b2d84ebf6cd9ad9b01ba50a58542e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

