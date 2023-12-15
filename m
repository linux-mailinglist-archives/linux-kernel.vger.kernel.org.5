Return-Path: <linux-kernel+bounces-1569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E081503D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E491C234F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0D41851;
	Fri, 15 Dec 2023 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsVuoNaW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF033FE4F;
	Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73839C433C7;
	Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702669148;
	bh=ojZFu3u2JD8wwHOvuAdwSBtt0KnHsqAa5vvrw4tljAU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NsVuoNaWUoUqe+obp0XMBmbUHUEhEhEFPECG0EIx9vU78rbCNolACd5DWcfGx02pw
	 Yyie/kbx+YQoRFwcmu3U7ogFlZsioU076j/hQBSGb5EX2qmFS/JTgDhJitWjg/9Eol
	 nU2PuctCTlXGVrKzX5JmpSUfRpzjN0lvAPkT9S9rtF0uOsw0Idz9eJLfKSaUw4ljBe
	 SVvJ7lRLS8L4RhKWsds36/j2UDaqAAaR/6kYGpPF58t2xSk6mOmUPCuHRQDEPYNq12
	 abc13dvOboiiE6SA6c3Dh563yzoXBuJxuAmdOLWBYVFRy+txox8fnLdy1aTnj+DQ4u
	 XCodNfIG6I3mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E7B8C4166E;
	Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <87edfoosas.wl-tiwai@suse.de>
References: <87edfoosas.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edfoosas.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc6
X-PR-Tracked-Commit-Id: 315deab289924c83ab1ded50022e8db95d6e428b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26e7a301419d2ef4696e581109c61b4e772e1fb8
Message-Id: <170266914838.22768.1174929899636540765.pr-tracker-bot@kernel.org>
Date: Fri, 15 Dec 2023 19:39:08 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Dec 2023 08:09:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26e7a301419d2ef4696e581109c61b4e772e1fb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

