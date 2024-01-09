Return-Path: <linux-kernel+bounces-20235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D47827C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A1B23273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1A33CED;
	Tue,  9 Jan 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcXcTwYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EA568B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 579CAC43601;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=sPXxSEZ9GB/y9X4kws8xeWqOJMPmHhNj07xdrPT9zZk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TcXcTwYYsuNjgCc0xySFf7L3bapjLWARLkVuBhquukzJklcqG3vTq4Og+Nfb+6xto
	 7odGsJL9/18zbrOM5QO0O2zMXrNZyt/hXrwS9SNjC1LMlVXAM2Aq2BicXatan58OQq
	 aVmtrUzbDtmjIGi0wDbttRtu/L7cpQQfkcKtk8KS+494x27GTdMILra2B+aKy/zGTs
	 XALFR/4BVLMt3YdCInuPzEq1TGC5DJb7BPGSQQsr83uaLDG/q8c/ynorBlwWsaIdvz
	 Gao0Can3mjRZ0p3y4tiNuYLh8efObQuDiFMkENrWFT2TlypiNIyfQC4XIsfb5OaS3x
	 DXfAFhBI6d/0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46C24DFC686;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107220823.GAZZsg18/8q1JNRksh@fat_crate.local>
References: <20240107220823.GAZZsg18/8q1JNRksh@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107220823.GAZZsg18/8q1JNRksh@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.8
X-PR-Tracked-Commit-Id: 7991ed43587d1106315208cc289c851d6915d4a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc5e5c5923407b4b312d999af27aaddbdd33c790
Message-Id: <170476125828.27312.10932425656350115229.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:38 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jan 2024 23:08:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc5e5c5923407b4b312d999af27aaddbdd33c790

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

