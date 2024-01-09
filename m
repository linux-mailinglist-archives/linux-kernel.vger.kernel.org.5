Return-Path: <linux-kernel+bounces-20360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0904827DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7112128531F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B22E835;
	Tue,  9 Jan 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn7dOB9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC113AE2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3755C4166A;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773063;
	bh=43a2iEzX8SiDVjT2VWLrXb9DrjGyn5tsJiyDU/R42Oo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rn7dOB9N0LR7N0SQKJhh+3c1TjrhHc0ssH1nHAit7z1ArW2OjNnTLzpBq5iAM8FaR
	 e33poC+qWOksCJ6EqAKwj3rR4L98HeBXmfXAAe7+Z1f4iONdj7by5LQJEg9qCVyCZv
	 JzhTpnEx/7+L2rbrrxPrITAcb24gVc80GUqj4jQGGPNukpfd7Kxy3s5+12I/b0+6ny
	 KJwvXE6dyW/Tou3/Xts+cUTQWtDjJVgJ5Ubykv9GtvauD0y2fvGazKqgkynXo6v/gT
	 lNLa0LMnbrhdcugH29ggp4dXCTjoDQkoIqdxiLGWssGiyMq+c2VX89c8qfmKgIQL3j
	 4V6PG57b+xEiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E05F1C41620;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] Timer subsystem changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvR8LSj0ea7XZ9+@gmail.com>
References: <ZZvR8LSj0ea7XZ9+@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvR8LSj0ea7XZ9+@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-01-08
X-PR-Tracked-Commit-Id: da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f24dc33f8e0a765bf9bdf1c190ae5b9a23343d65
Message-Id: <170477306291.30368.8552615206373383101.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 11:44:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f24dc33f8e0a765bf9bdf1c190ae5b9a23343d65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

