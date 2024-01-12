Return-Path: <linux-kernel+bounces-25045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34282C6A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494891F24D05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1B168D2;
	Fri, 12 Jan 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bma43wJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD715E9B;
	Fri, 12 Jan 2024 21:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BE6C433F1;
	Fri, 12 Jan 2024 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705094876;
	bh=nG/zzTs1OJApe3bStUxLO8VBpGZkKDQIYbtHShVWgTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bma43wJH8k/c4grX8KUD4FEG9wb+qIcmnJTKLqteS+PbF8DpT2KwvM81wbK4Q4rNz
	 KPtwQ6ESSqi1zSjB6rBSeho1jPMwXM01GlJ8qnwFksxkJMxyWSzOnToY1y5TkCSfky
	 vFRzIC3we/uNq9+dgjBr9AHIzPR2GvSy3HuDw4bfgD0cNPALKMGB40MJu2c0l3zZD0
	 iYdhj8mVWc5g9VxymWEuyX7NyAkRhFBkhjMWcs+QZLDAQZRuZcq5g0znXk5dOGft4R
	 P756HDo29ZNNW5943cn9VuDuGKvuxSn94l6u4A3rU8UPh7D3X3apJSuuqhvdGyASxP
	 u3CrTrh4rnhOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90A26D8C96D;
	Fri, 12 Jan 2024 21:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a5pcp18r.wl-tiwai@suse.de>
References: <87a5pcp18r.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5pcp18r.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc1
X-PR-Tracked-Commit-Id: fd38dd6abda589a8771e7872e4dea28c99c6a6ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7912a6391f3ee7eb9f9a69227a209d502679bc0c
Message-Id: <170509487656.8774.845348567307890807.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 21:27:56 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 12:18:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7912a6391f3ee7eb9f9a69227a209d502679bc0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

