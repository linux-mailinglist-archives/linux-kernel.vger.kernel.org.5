Return-Path: <linux-kernel+bounces-20236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDEA827C43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6611C2335F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533A47764;
	Tue,  9 Jan 2024 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/y7SFX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CE6104
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 675C4C43143;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=rbKx72xQ64cqYj8TThp2DCrEEizrd/sGAklqDX8FQgM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s/y7SFX8yW3+r1D5ej3XmkcnwymT/Ra2zxkQAleOKqxwRl8Rc/ZHqFIr/19GvEdqo
	 wNpSrF2UhNnBFYCNkuLylW4dtFilaFd3ydkDRcHTJhW4pzOjyxpQRRlxsqxP4O+HTX
	 o20/bNMkMdzQnZFqxUrI/TcU5Mz7YOFljncpLM1JJB/rT+YR0lSqdDLFPoBS5RY0rr
	 FkyBusQ8CxY+jZ2JmasFyotA+pWPgIkilwGN75jgaJITh6RC1tq8jpgdDhH3bLvAth
	 T+9QjkPENH7D2Zb18cwO08ZZh5l7j1zKB+JKyZ3aci/M8n8HYcwKRq++/HATSRGKsH
	 m1TykLFI++Vcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54F16D8C977;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107221144.GAZZshoHEj5DPOPdyS@fat_crate.local>
References: <20240107221144.GAZZshoHEj5DPOPdyS@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107221144.GAZZshoHEj5DPOPdyS@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.8
X-PR-Tracked-Commit-Id: d642ef7111014805f2e21e9cddb0c0a93ae1313d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e900042f04848b5be9238d866df0952cfc548cf9
Message-Id: <170476125834.27312.9095475761837339481.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:38 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jan 2024 23:11:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e900042f04848b5be9238d866df0952cfc548cf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

