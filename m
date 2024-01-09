Return-Path: <linux-kernel+bounces-20233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B46827C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6870FB22B59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD077476;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYMr5tLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AC186E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F3E7C433A6;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=dDs91h811gnf4EBOtcB+w2Mv1Gi+FUE86WTP+to5CPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cYMr5tLwqTu4zYwCIUN8J0i91yVlV0ISOfxlH6DMzG0Qmc5IqQHuHdJ9eG0EDwx2H
	 o1y4hMZ+mOdv/Ux3agCnoPRMHNaoOAhzdJUAaRIjKr6Lpm26yl0QX3NCqAdiBFBCKI
	 obt63RsA/9BNcovIjXpuZaSvNPsRnFLjF0wnMug4w6YnBHASWs8lyxvOkTCdkV2ZRC
	 1RdczcRtaESsxlZPuZAD5Bh3lc7sE9DH+jl+qoc+Zwq3azTsJkbNcEJe62E1uHVhbf
	 T16KaVlADORlQX3bisC0cCAJ8sjVQl6wXE8a04HcTE1Np6igFtLFaNZJi4UwCLLYS7
	 0oQRCTBxHnJxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EBBBDFC691;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107121528.GAZZqV4GF086iQw1zw@fat_crate.local>
References: <20240107121528.GAZZqV4GF086iQw1zw@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107121528.GAZZqV4GF086iQw1zw@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.8
X-PR-Tracked-Commit-Id: 232afb557835d6f6859c73bf610bad308c96b131
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bef91c28f28fe8a36b91e9a39f60054ae1874280
Message-Id: <170476125805.27312.8990329809733043432.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:38 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jan 2024 13:15:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bef91c28f28fe8a36b91e9a39f60054ae1874280

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

