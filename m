Return-Path: <linux-kernel+bounces-20358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB24827DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97B51F24519
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A624A16;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WanLWf60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6312E73
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D232EC43330;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=0PtUnC1YFSAiO4MKYGIwmd0MoPL5fk8E1Uk05FnKu24=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WanLWf6013cm1R6Cw/jQop0ecLUlQJYYY7jcHnpR9Op7Ey+6u+Wzr8hGNGtzQ5y2z
	 WaDJr1jBCaJcM+9PNt4E1kuMP/cqsJlrw43PK3PZq/uvu0HklNZngh5aImp3nald5k
	 8wgpQujADtk2B8UfMTgFvFAangTDV2BrOQXXxpa4RerUwJU2OLKsMc9TAWM3bFbpST
	 KdxwQ1Mjm+dhjEC+l5TdkLArsfjAaoamw+ktLHgYvzSHoFr9BflO0dD+WzT1eZX+Gr
	 yPzSeTZ8JqP4KS51EizuX1VVvRIBAUTALx13TJFEwQsges5bDhTEugknwwAyxAlcTj
	 7EKfWp0I5/Pug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BADF7D8C977;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ subsystem changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvLCmUqAriMV/Va@gmail.com>
References: <ZZvLCmUqAriMV/Va@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvLCmUqAriMV/Va@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-01-08
X-PR-Tracked-Commit-Id: 69ffab9b9e698248cbb4042e47f82afb00dc1bb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bdf0621f89f87858ca26344378188eff194eddd
Message-Id: <170477306276.30368.15307884288206940338.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 11:14:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bdf0621f89f87858ca26344378188eff194eddd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

