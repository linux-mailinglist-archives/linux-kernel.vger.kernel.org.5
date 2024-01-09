Return-Path: <linux-kernel+bounces-20274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27676827CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371D31C23360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F079D4;
	Tue,  9 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhIu1I6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3DC33DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 384F2C433C7;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=Cu+coxPzLauFonR4ZI99YPqxqDRxoEQ/oNoXe4wJ7TE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WhIu1I6ilfgq+v9vaTdMkZaFKaRp1/Mk6RZh7Ei9bt7DPZF09XTqP8tfog/wgT5P1
	 nfOdlqZpVEPlkadgeCaousKjgld3JG9WZZkL1/CtONIpYEWZjYrd/Ed5ljKf9yofY7
	 +HiDtcB2k2y+hgiaC84GxYR1Z0LIEEZvo4xTU88IFgFEZ0UxHdo+B1A/V+FV0eABeq
	 5sQ1my7pNiqjrbykTrEaZ05K3x2T1snanPLBTwZpw6bxV5+2ugzRD1YraDuxJm1jxk
	 5q0BRtofEan+rov6YoH4nl+eZL4du/VtufMfQrscBGwft4CRQlbjLUBngNl1/cwOp3
	 ccHfgm6Uyvjjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A8D5DFC691;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvWgXCxrBcVwFco@gmail.com>
References: <ZZvWgXCxrBcVwFco@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvWgXCxrBcVwFco@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-01-08
X-PR-Tracked-Commit-Id: bc90aefa99f74452d549d503a3f1cbf3adc9c6bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 106b88d7a91e2b4d40369a20b8ef07bb827dafd5
Message-Id: <170476626410.5897.1106115630172977929.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:03:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/106b88d7a91e2b4d40369a20b8ef07bb827dafd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

