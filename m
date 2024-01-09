Return-Path: <linux-kernel+bounces-20277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044B7827CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61521F2426B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8F8C19;
	Tue,  9 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpV094yJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CB4422
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 715F7C43143;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=jP9g8NsYaFq7JRcPNa2T2EiuQC6bH2f2v+WaTRamhkc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rpV094yJz0RR4dwUlXWMU8XOjqGpdHv3uiiKZLWBZfANEr9lM5GocG/BZUx+aJG1B
	 5/K1/lz1QuvLOYsZVJs71cOE6s3bBxqlQADbtg2uSqhNDSlx7Lc/cwKTyz4Pa1GFzB
	 ltpjocBOOHBAe0LwNaO73Sjh2QA5CT9M+10YSsErc76Lz2q5CJKSoxkLwBsnz46OLp
	 UeYA3frKbObpNJK/itFe0orYwZF1nyfkU/VEPGZ9hDixExE8wE17QF5wjNKFo7MXg3
	 ClKZ/hHXzZaLESuIv2RIEQ3DzGoD5Qe4mx7R4JfpJ1cM+64QHCq6JZzALzkQ6FZ3Du
	 7kbel0YJeopTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57EE0DFC688;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvai7moEceR95bP@gmail.com>
References: <ZZvai7moEceR95bP@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvai7moEceR95bP@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-01-08
X-PR-Tracked-Commit-Id: 54aa699e8094efb7d7675fefbc03dfce24f98456
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b51cc5d02834a9c38cfd95b00b7d981b701b13f9
Message-Id: <170476626435.5897.968658646150784279.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:20:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b51cc5d02834a9c38cfd95b00b7d981b701b13f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

