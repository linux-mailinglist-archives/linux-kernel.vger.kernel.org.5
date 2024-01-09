Return-Path: <linux-kernel+bounces-20232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD02827C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705D71F242FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2196FD2;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKs330gI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AC28F1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01240C433B2;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=iZFZppPIG06qGT7Gg6N6jBw5khpDXbzXrB8FqHjvCkc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CKs330gIG0grIvdnA958SAyy5D+noY2zyvSlhKr6uzVvB8+wO11gMIQMRm5jGv16L
	 tJqXn0N98cv487mCRdgYxwREDHVMtnc1TH1ne2Q6j3M96BtgDzeSfyCqrw1V6RJzs3
	 1HI8JZPxUBfzHTrZKSKKj5rFjSZUBpJP9Hm/GCBdpd10JSFHyUaZgkqvOtwg9w81Cw
	 fT/VdGsjhjBtfb6jBdmsfFGM43DxT2PvULp7iVQHqtX/Q1pwaILexR/OIx4s664btO
	 jXQK2SNqVny7qijUnbOysbJK8qoBJ7B9rfpPyhzUoiASXRz20KirUK3i9lemj0pg8x
	 qCmdTQnRFEthQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5004DFC686;
	Tue,  9 Jan 2024 00:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240106151221.GAZZlt1Vq7yyq/aujW@fat_crate.local>
References: <20240106151221.GAZZlt1Vq7yyq/aujW@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240106151221.GAZZlt1Vq7yyq/aujW@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.8
X-PR-Tracked-Commit-Id: f789383fa34a266d0c1a76f272043a15a8edf733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41a80ca4ae2de711e04b399f614f676daf72d938
Message-Id: <170476125793.27312.9729873971165559311.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:37 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jan 2024 16:12:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41a80ca4ae2de711e04b399f614f676daf72d938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

