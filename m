Return-Path: <linux-kernel+bounces-20279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE1827CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519DD1C233AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFB4655A;
	Tue,  9 Jan 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkSgMvEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277E7497
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D5DCC43141;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=tWO/bKLtrWhDo8abgqdqaiCDnKAUnwsvuGtZtWM6tG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gkSgMvEI1+/vPfAikzhkyYdDTtZz2VzDXrY+EQImKsZn1mHYGkRTq4jvfEgxKsamr
	 hx7ApJ4t8tKcmeGj0wU0WKG34G6s5nrOKwiSYIO1FkRdJYd8KUGCbqY3eomyqRIeTG
	 i81ApIHjpnMOIuL8fnUZcaCiVhGyO1NmzavCctUNw9aav/lx/blMNlzZzwQVunJn1q
	 qO247Q8VK/9TIWmpBI4iGA+JVbt6D8kQTiO7WFz7apllCJjP1fGx5vNWuHgpzs4JMs
	 04NaPiW5ptZfKEQPztogE1k8v1f5x2RrmojzrOBNzl97Netzjb828zBQoqmBIGrAD6
	 GBdlb3uTBwJkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A025DFC686;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvbw0RICmvVvGtP@gmail.com>
References: <ZZvbw0RICmvVvGtP@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvbw0RICmvVvGtP@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-01-08
X-PR-Tracked-Commit-Id: edc8fc01f608108b0b7580cb2c29dfb5135e5f0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33677aef32cf07ebbed07647e88136258c4b95ba
Message-Id: <170476626443.5897.1321768425005193499.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:25:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33677aef32cf07ebbed07647e88136258c4b95ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

