Return-Path: <linux-kernel+bounces-20234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F010827C40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9456E1C232B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E633CE6;
	Tue,  9 Jan 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqHUGXsv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED2539F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BF3FC43399;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=Hm663RmLr8q8MOYoG5h/50LklfTeksiTuKUefdRtgR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bqHUGXsvzZqNFDm7Fnq7r9N8BYGqXSRIX1hYyt1V8FYb/QJ669Bm6SruH335Db7Qd
	 0srer/6OfTMYDD9K1Zfs3B/57MBFK+PQXugPusH95zSN08Q0XZFmMisHuJ8AZ/M1gs
	 6+Ng+pkRRUk+ZyXAV9Z3oi/WaonzE9tdbqEqXxlVXDqMC3zb5ngkqHpyO0iiqVHTs7
	 6X9YkHgxpnSY2/kylarO31rAaEqhIIv3IDLbjECdrrVvJF6DyqeXf/59Bwhv44otXf
	 gzUiX4C4ds4JkzJH9Alero/oXnp+I95ZCFtVvmQgnZSDZK/SWewHI8qrzp4DIEm3Xi
	 eJ3hfXH0qtC+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29C0BDFC688;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107125653.GAZZqflcax9rVtvbcj@fat_crate.local>
References: <20240107125653.GAZZqflcax9rVtvbcj@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107125653.GAZZqflcax9rVtvbcj@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.8
X-PR-Tracked-Commit-Id: 1f68ce2a027250aeeb1756391110cdc4dc97c797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3edbe8afb617a736ae0dcc877311bdb112a00123
Message-Id: <170476125816.27312.108305048815976542.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:38 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jan 2024 13:56:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3edbe8afb617a736ae0dcc877311bdb112a00123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

