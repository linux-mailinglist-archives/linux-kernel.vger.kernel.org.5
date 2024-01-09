Return-Path: <linux-kernel+bounces-20361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88131827DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9221F23CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51F2E839;
	Tue,  9 Jan 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsqJ4eZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC314AAF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBB66C433A6;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=Ic58NtZS8wcur+t2mD9eVRUqODcX/UVDg+sEdmXuUmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jsqJ4eZx2Cw3SDN77TOBV34xLxDe4PRLH3LXjtibJuYToHtuJDsRdL2nrcnkvSOuo
	 J5BPF0MLOXq690y036Fe47OkhrGJMGjbJmhchKU2Dkjp+dA0InkCODFns47eFMe0lR
	 t3lzycyfXyplGjUxnHrPdiO8Nlyd5amw/cdMrD91R6YH68hDjry0lCjMz4/zbaF3An
	 6nriC3EGANIGor85tBQTdXrqzO8FUA/rXipJ1U3aiWaMz1Ees59YrGy0jZfJcAUQtf
	 lM1Chh7pA9SczpeSc7l6b1yDTrnj//L35nVl8woc6v7OdZBUgUEmC4/A6ChnTRrPvo
	 t1Zk+jLigwe+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6ED5DFC690;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] Generic syscall entry code changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvFimN17XOmnb1c@gmail.com>
References: <ZZvFimN17XOmnb1c@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvFimN17XOmnb1c@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-01-08
X-PR-Tracked-Commit-Id: 221a164035fd8b554a44bd7c4bf8e7715a497561
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdc202281a5d5e2c4bbbbf78bbd68f035a49421a
Message-Id: <170477306267.30368.3508599753354532316.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:51:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdc202281a5d5e2c4bbbbf78bbd68f035a49421a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

