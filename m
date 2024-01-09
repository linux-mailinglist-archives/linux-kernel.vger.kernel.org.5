Return-Path: <linux-kernel+bounces-20231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D541827C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D126F28547F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC306138;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/WB3MFs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAAECE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9BEAC433C7;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761257;
	bh=SLHCRElu8gxbJDZGValArzAaZrmWOnEWtqj9c6BLrLY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u/WB3MFsiKnBQibi2Gct3IDslgKd9trUdxaL+9fDuCtEprVlIzkWBsKgWVawvuZ/K
	 cQw+8YCr8YMaP8dlJIkaZTiPa2a/gfgCKIix0bKUAS/dNlCvWKanvaLTctPdmKrJ01
	 aabRaiKWmiG9udIEprtiaziV3Ay1HE6SN/tb4Ri5B4ASWdR/zgkgZbI2N29EgTPehR
	 LMf0bCl4XLMjjSHIPnlVK1HW+oLUTXtn8a8/GWznS3Jj0z13hjbFgk61kX2cbwJpX9
	 6iZj1yAReZfhRn+nWbDEZrY8tXxpqusZCiHm+2n6ulsai7sHQc442ifhO+w/zGmvbc
	 bJbV0s2MzTCsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7A97DFC691;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240106145243.GAZZlpOzM+N2UdoQED@fat_crate.local>
References: <20240106145243.GAZZlpOzM+N2UdoQED@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240106145243.GAZZlpOzM+N2UdoQED@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.8
X-PR-Tracked-Commit-Id: 9c21ea53e6bd1104c637b80a0688040f184cc761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e0b939180fcd2658d2eb8e5bfa4192d1bc32fad
Message-Id: <170476125781.27312.17616484829947473010.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:37 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jan 2024 15:52:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e0b939180fcd2658d2eb8e5bfa4192d1bc32fad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

