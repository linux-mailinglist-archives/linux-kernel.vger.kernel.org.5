Return-Path: <linux-kernel+bounces-20357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA929827DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3581C2343E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A03E22091;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+urBpGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F911CB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2AEC43399;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=RWToJBzL+LDZ3hDqZenu92Mpdkgyh9pB1KIS2hRsuH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G+urBpGgDliaMnWSCubgnv8VF1cu1Ku1eIyWRPSL/f+8/o2UQVKsxA5PqeFlF49Yi
	 tJ5RApVM5k545war6vJwXUBN9iPYtYZRBOqqZh+IVJRsJ4bKqxbSEQVDoKygpqgeR8
	 dHtgRjzMO/2hsIarF60z4Z8G+nkRQTdx5xBimqQU4pK5zHF3ENeSBs1/lUlBofSeAp
	 upDyP9aWm9bxUCKDeRGKtZZllZpXQLPRMw7KdkLyuZQaR7yNpAKYjvZYmWTuff79uq
	 pFbIK8otqZlVYs/y90SXuL/SWirjAT81SVhehLUv/nrhT54JtV6dqwo61MkYHBrE11
	 DEX8GHW5gaeIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9464BC41620;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] debugobjects changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvDp8TCJRBe8wM6@gmail.com>
References: <ZZvDp8TCJRBe8wM6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvDp8TCJRBe8wM6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-01-08
X-PR-Tracked-Commit-Id: 9bb6362652f3f4d74a87d572a91ee1b38e673ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab9517fa9aab71e312c7acc6fefefe080db3c972
Message-Id: <170477306260.30368.5273164488710277701.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:43:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab9517fa9aab71e312c7acc6fefefe080db3c972

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

