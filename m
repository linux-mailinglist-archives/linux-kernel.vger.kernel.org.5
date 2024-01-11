Return-Path: <linux-kernel+bounces-22971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9C82A5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EA11C21451
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E4EBF;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUw6iXhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3443D287;
	Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD21C433F1;
	Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939845;
	bh=t1TT3WyMi835UUT3EaPV6mWmLuSvB2krGc/DSGJlj2k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aUw6iXhCePhGEw57N3Hkn5quIfdnM3/bYCeuDLnzIIaMsz4l+j7s2AniRrzqPRxZ1
	 dMDiHKD3RbXJYpvC+hmLYyX5OCNfmX8nowGSDVnMYoT7WINl8qgM926X96LBSwI61i
	 NS+G8eo/1QWTcv+kAAUJXkqe45EsFxLQ6dsnrpSv95kIFPKRnRZfBrw9bEv6oC9kME
	 iYyMbsUSV1YxG+iXgjWQ8RUhFR7j4bxJeoGbazz6W2Oi//UDuSLJH8AQoXj3iPU1fq
	 1N9J3MJdrPHbpwOaVAWwm9xfBBxZkq0YzMG3w1N/Iglk166uATXuwEmF7n8F/JOXIO
	 MvbgimpY5TyqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB9E6DFC686;
	Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for the 6.8 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ0MdVwe+S82dwnX@tuxmaker.boeblingen.de.ibm.com>
References: <ZZ0MdVwe+S82dwnX@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ0MdVwe+S82dwnX@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-1
X-PR-Tracked-Commit-Id: b2b97a62f055dd638f7f02087331a8380d8f139a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de927f6c0b07d9e698416c5b287c521b07694cac
Message-Id: <170493984569.10151.11550503190233164697.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:05 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 10:05:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de927f6c0b07d9e698416c5b287c521b07694cac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

