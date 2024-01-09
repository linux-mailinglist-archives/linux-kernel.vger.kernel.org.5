Return-Path: <linux-kernel+bounces-20275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C595827CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55BA1F2438E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D279DD;
	Tue,  9 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/GBG5QG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B033EE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 498A8C43394;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=cxphhpI92/mQKo7i2qeSSVKUDbwh+NPZI72p5bqISRg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q/GBG5QGL4hBP/pjh4f0Lluc64JEjW/gKcFmPu+18hUBdQXnkWiXriy07Sa5CEOsQ
	 L2lqHzU0rpBvACM9Zkl7vzUPTfgzdWddpbEXwuXPCj331/ynxlwy5Ux4Dpej2iZlq1
	 wJ+DjVcPLjN5s3PVCBFzW0i5keajjuXD/6vu+pC0Qnl3htshUiiVMhBzTDmYIe7UVi
	 dNlRMOUU3uGRoJyhs1OsXLXtPrONiYo76kPJq30ZEDp6pWo4HI9eX5+DCUTs2a1Zrc
	 ykqc7XHXnPErgC4WXtcyXs+YOFfdPUnt68yWlEMfm1/qWTkq+JChXAcGLOZf5DQG0I
	 x+iyFB2RQbaMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CBCEDFC686;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvX8fAPmSwiESj4@gmail.com>
References: <ZZvX8fAPmSwiESj4@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvX8fAPmSwiESj4@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-01-08
X-PR-Tracked-Commit-Id: 257ca14f4d780e27a0605fd68053d2cc3178a232
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f73857ece4d85d2ee36571df9c13a733f3ba2732
Message-Id: <170476626417.5897.943574537387957388.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:09:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f73857ece4d85d2ee36571df9c13a733f3ba2732

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

