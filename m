Return-Path: <linux-kernel+bounces-10581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB681D677
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629B5B221C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8F2137A;
	Sat, 23 Dec 2023 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9R+THOq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B120B00
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9842C433C8;
	Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703362873;
	bh=yjJp0pUmgCZE5frsj2fxlGV36yRWOCg9MNbF84EUvN4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e9R+THOqXDbw24Ze5hita+W/uH8RKDx5BdlT2tKfbXGX3YRTEhhDC0HvUw4s9dV3D
	 hRnkwu+EhEFZqdB3wKNCOgOGvbfRpTtmsNQIXLyt0n5G+4GrJhVfCXKJq8B2B0eyge
	 /vQyGWkm73Ixra3oupRa2pPXzVxafFuz4BvnzX8WRxVqCObKE1eLBFYNIsyjZLzn7z
	 VagRNyyBjKChlawDrFCZWLAzf6ptAKQwh8r7VHYZMgF0s7O93hqsqolInucdLNeqs/
	 GvMM9zW2S/yvyzF9X4r0pEk69onT8BqqjJzihrlg3ffV+Wa3yhzLxVp7Iu+bUsDDZR
	 5XRi4OJdVmQUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96309DD4EE1;
	Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYbv3GXLNLuc+rka@gmail.com>
References: <ZYbv3GXLNLuc+rka@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYbv3GXLNLuc+rka@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-12-23
X-PR-Tracked-Commit-Id: d5a10b976ecb77fa49b95f3f1016ca2997c122cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f82f1c3a03694800a4104ca6b6d3282bd4e213d
Message-Id: <170336287361.28590.11919603856626374080.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 20:21:13 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Dec 2023 15:34:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f82f1c3a03694800a4104ca6b6d3282bd4e213d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

