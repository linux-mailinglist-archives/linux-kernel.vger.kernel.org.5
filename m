Return-Path: <linux-kernel+bounces-20363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B6827DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DB11F234C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFA2E84B;
	Tue,  9 Jan 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKP8Zu+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AB1DDD7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0B6C4167D;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773063;
	bh=ET9S4s4FsJukZTg0e0EpQg7ThhcpZTjhOi9jbh+CrSU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cKP8Zu+b0jawMHXH+HxR569SbqNzG1EDcQ7tZ7qvjAxRcJ+wxKnU4ROhcrWOuHN7z
	 G7/HeBLy/PLwPllYO0jYcqS7I32qtIIIrnkIPbEI7QGaM6Sdsv1K4tJjHfBct36XO+
	 2wDSZSRhw+GC77GRiHnwavAwR+9U5RFiNTisKqJIF6MrBXqlKedi21ddfKYwB4tw6q
	 nZmSzRI2bz47y8ooS0uccRTxWRcTGysJekqVanaQLJJC1/R6JuDgiQWtNSDrKUkVmj
	 2L5zBbg0lY/LVOew5vb+i97S3h9ATYgAdm/kdVYgZGjElajSCxViDNDHT8sDunpoK6
	 jsSbJOC7tY2KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B934DFC688;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZwBi/YmnMqm7zrO@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZwBi/YmnMqm7zrO@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-01-08
X-PR-Tracked-Commit-Id: cdb3033e191fd03da2d7da23b9cd448dfa180a8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfe8eb3b85c571f7e94e1039f59b462505b8e0fc
Message-Id: <170477306317.30368.12147719400572223834.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:23 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 15:07:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfe8eb3b85c571f7e94e1039f59b462505b8e0fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

