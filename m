Return-Path: <linux-kernel+bounces-2037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A569F815730
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E11286D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E46125C5;
	Sat, 16 Dec 2023 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2/3Tyxi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EC107B6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3969C433C9;
	Sat, 16 Dec 2023 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702699641;
	bh=9n3JLGBd9SfukcAnP6QdO6GSunFRlwYsPjHF/wb3bOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g2/3TyxiBbNfGo+Qb9p/lDh8hGxnSFM8o8lPtzNaN0EFezEYR7xBP7JPwFIheDXnW
	 DzOSqPKVs/NBuPXcjPf+0myPR+Q8FAgL6GXo6SKhMt8KEdc0AaUhvvFA9nXwl3/TlR
	 hITK5pfuSw67VeOeAZ/tzxqRrPT1bFm2GoF/8pv6FQvl//r/WwSS2juRYVBaMG71is
	 IMLnAJPEOM9UfKObWSspwEoGrkzN/ESHs53YAx7E16UkoUtE5LireZEuqBlbNzEdsN
	 VsJj8UtZvIt04ygnh+n4iXO9WQC1HcZ+JMQUfkqFOO/rGuyTkxVCTprbA6wDFLgPdO
	 bu37pi859jupQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE449DD4EF5;
	Sat, 16 Dec 2023 04:07:21 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZXzliF7K4P32ZSYk@arm.com>
References: <ZXzliF7K4P32ZSYk@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXzliF7K4P32ZSYk@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3c0696076aad60a2f04c019761921954579e1b0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8e97fc6b4c057a350a9e9a1ad625e10cc9c39ee
Message-Id: <170269964170.27029.1461953363063526027.pr-tracker-bot@kernel.org>
Date: Sat, 16 Dec 2023 04:07:21 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Dec 2023 23:47:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8e97fc6b4c057a350a9e9a1ad625e10cc9c39ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

