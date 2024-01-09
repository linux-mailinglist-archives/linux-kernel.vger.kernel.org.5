Return-Path: <linux-kernel+bounces-20230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86308827C39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0291C2331D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2816112;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhbhGWao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837E46A8;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2C03C433A6;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761257;
	bh=RQED0v7D39ZBhiU7kT/JxgUryce0pBDAgtfA7qI6BOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YhbhGWao61St99gtYXSILL3zysOG3avtbIOlYfR1NMF6hVw4x7vQsrxrq2uciHuON
	 vTtebsmgnULuswUPboNTQHYN7z0IBHydRDgowFxEb/9yf6/JnZnkkM4nwfOW3aPdYP
	 JcjNTgh724pD3yNMLzUzI8Ty4zUHyv7OrqWmOVbRFiULJnox/Nvg4/oLP1a2ZoXpTc
	 hNRiDT8yLMVjGt+O36IoGiueGJnS3rTqfDeToiVJDvrAsm3WOD2hk6KvNxkD058lcw
	 DrY3etqGoHq+ZWeTfiy8ujFvk59+G+JB5Dj9CRzsd0UzeuDnvUiCZvJnll8AdE6TDO
	 gxiSTbmPkKZkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEADEDFC686;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240106121912.GAZZlFQJdtoGzRxIiE@fat_crate.local>
References: <20240106121912.GAZZlFQJdtoGzRxIiE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240106121912.GAZZlFQJdtoGzRxIiE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.8
X-PR-Tracked-Commit-Id: 1e92af09fab1b5589f3a7ae68109e3c6a5ca6c6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dee7f509db20402a25be94003f8f1ac3e17bdc1
Message-Id: <170476125771.27312.4101342657806000273.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:37 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jan 2024 13:19:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dee7f509db20402a25be94003f8f1ac3e17bdc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

