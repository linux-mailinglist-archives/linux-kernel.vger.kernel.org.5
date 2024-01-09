Return-Path: <linux-kernel+bounces-20355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843D827DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E297B23393
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7191774B;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVMTPLP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E5DDAA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A735C433C7;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=ZzYHEls8W8XVCtU3olyc3Kx/o+kMSwON9s8qk5M/Jjc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tVMTPLP8sXif9o+Gk2su+0aygA08GhoBK997ep3msqvgxufeSoLM3l6ZVtaSwJ809
	 dyjCZGjM8GrvAUroO6u+/hldjNLpQRpiziXjBDx9VpnZ9uCC1C+Rk8ppPAxfFCNfmR
	 utl1qYnCcDSLILFpYM2+TLjT9W0J18YoYvPYIKidEKN82PiE/v4bim69pdNnh7M9G/
	 +2NAldjvBFAKviSQklKLWPFl6roxghqranxpaq163vK7p+vntKc4ylBeq04ZV6DSKR
	 zM1M5tEmLkXF1rIFFY9mVGY70u8YZVM/MiWdAUJaVtN7pVeJvblBQx+0N5bUv2J0Rk
	 X2MBjIkHHDM7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56E9EDFC690;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZu8bzshIjF689TQ@gmail.com>
References: <ZZu8bzshIjF689TQ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZu8bzshIjF689TQ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-01-08
X-PR-Tracked-Commit-Id: 2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cbf5b3105f31217053570e7ca722b739a9242a4
Message-Id: <170477306234.30368.12489838833295898344.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:12:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cbf5b3105f31217053570e7ca722b739a9242a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

