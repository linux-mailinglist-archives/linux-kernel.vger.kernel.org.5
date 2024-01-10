Return-Path: <linux-kernel+bounces-21639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6A82922F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15172283058
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26173D964;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSQwp0fA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40165364D7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1950CC433B2;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850266;
	bh=bBEtsrH7a1D3POWKZvxyb898rlHNfC3WzAtRV+kqIFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uSQwp0fAX1F9KPtAExF1AoQLFkuWjZ62wdnSwP7xbsOZ7o/3FfBeTPJiETKYU5DPH
	 HZjnt8uG4uV1za9+xlBjQ6mBSale5NJE5q9BRjz3lJ6eC0bOmaMV3s4o0235/D0taQ
	 ZUdzew03V6uKm7qEwM4M9zp4CLhGOm4D/nAus8lJZncZ5lBuRwHKngsV8z2H+Vla4j
	 7qTW1VuUdwFzZ+3tK4sAegy9yh+BM2kKcUuwa4lEO+EB12v8v+wDLwZb86CrFDp5sF
	 4+P2qzsSnMEhQHBg6uLp/NgBCkbnwio9Rj/tIgWobxRvRl7vQUrOA2WNDJDsX+Iiyg
	 HwRVaEmqOhDGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08C1EC4167D;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZv/gs97F3xQwOGQ@mail.minyard.net>
References: <ZZv/gs97F3xQwOGQ@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZv/gs97F3xQwOGQ@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.8-1
X-PR-Tracked-Commit-Id: 9bd9fbd9032a3b7e9ea916d6e58ba0116e0621be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c6a3fc925b63d5201f1c11b93193d8a466a7d89
Message-Id: <170485026602.7649.10847066916193973045.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:31:06 +0000
To: Corey Minyard <minyard@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 07:58:26 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c6a3fc925b63d5201f1c11b93193d8a466a7d89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

