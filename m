Return-Path: <linux-kernel+bounces-21431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1288828F08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AFE1C248C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83473EA8B;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKtu6hrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7D3E49C;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D391AC433B1;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836413;
	bh=AyOTKFAp/kX9VM/IO/5jrxVQnN4sO5GwJb/8agSO7tA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gKtu6hrAdBm9reGsr0D3uc7mkFMFYXc5f84b8Dg6pm2Gd3Qmm2ooWdNmSe11UFvt+
	 wnyLdwE+vd1imPHkFCAn4ZoWk2fY3HK1W1DUBcHWnFMR2D9OKS10W+RDP8BujNDOSI
	 8QoQzGPjijwo+nu9oMDpdxZhVvXoitT3J4DQHtXhWpYjxi64I0nx5Y4W6MzQjlGn9Z
	 Fwfpf5CXd7ov0zp/AX47nGhI0xD2HWJXZLChwv2BGzer8pU/hfv8pdXITFjvHMGGRL
	 woF7IphYpxsoHx4trYDimwEF6ch3UWjHRBbm7H8UbpZE6LNWQ2chSwO7xzLBzmHRYP
	 0RUpKV9m87gJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE4C2D8C96F;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108113311.192252-1-mic@digikod.net>
References: <20240108113311.192252-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108113311.192252-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc1
X-PR-Tracked-Commit-Id: 0daaa610c8e033cdfb420db728c2b40eb3a75134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9b4c5890858015bfe2089b7573319bcf4a92907
Message-Id: <170483641377.1854.18445063340511430332.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:13 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 12:33:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9b4c5890858015bfe2089b7573319bcf4a92907

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

