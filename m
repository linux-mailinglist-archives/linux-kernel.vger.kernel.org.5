Return-Path: <linux-kernel+bounces-121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F34813C71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591A51F2274A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A906A327;
	Thu, 14 Dec 2023 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9oj7k5W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050C282E7;
	Thu, 14 Dec 2023 21:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C06E4C433C8;
	Thu, 14 Dec 2023 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702588686;
	bh=ZQ2DviISMnE200PVMk6uk8tQNm3oO+RYRPtVNSJ3kKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d9oj7k5W0P3tAP5mr2x/X8eZnjacqkJS4zWLouSYax4X89NzWqSb1Cbcci/DOMQbx
	 P8K83jiH+YhpeAFVym1ZYt4mAq6xvGnE4WVVUnChaB5SFDbwdPBFC5BQDInqUFlTC8
	 Bvyiuglh4rKyNmNeOovp7UGRW6b/7jhnlshzHCuPAch6sNdj3pII7t1BAJ/dVeeirR
	 YQM9pd+RWx+5CsLltDG2/x5ibYcoF0yBugXn5Gb2YGF7k+S28ZStrVSOcAMjWZl1Py
	 YObCsuaFQ35O44ZxdA1R0AY/2vLSpBdIVVGoAI+V0P2bxWBbjZ5bAlnZxvr0emlCs9
	 4/wex99DmgTtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE3C6DD4EFA;
	Thu, 14 Dec 2023 21:18:06 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231214143515.27817-1-pabeni@redhat.com>
References: <20231214143515.27817-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231214143515.27817-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc6
X-PR-Tracked-Commit-Id: 7bb26ea74aa86fdf894b7dbd8c5712c5b4187da7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7402612e2e61b76177f22e6e7f705adcbecc6fe
Message-Id: <170258868670.16863.14433967067353648168.pr-tracker-bot@kernel.org>
Date: Thu, 14 Dec 2023 21:18:06 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Dec 2023 15:35:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7402612e2e61b76177f22e6e7f705adcbecc6fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

