Return-Path: <linux-kernel+bounces-25173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D882C90C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891101F23C03
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D51A28F;
	Sat, 13 Jan 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8ujaX/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26919454
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 02:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E3BDC433C7;
	Sat, 13 Jan 2024 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705111782;
	bh=eNrEAeh3Ph2mc5buAE6n7kd3722wGgLeSTeJ99oKDiU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i8ujaX/uE13t8BGQBmPSch+z2VBNyeT09D8j7YDgPWbAQqi+PRa/fntJphSff0rcE
	 MWor5cpNzmJpjLJ0KIaIYrUfWI4tdEOylUapI0l2LvLlOT5p1ls2N6NLmBLYerpE/6
	 nGEnFBDjq8oRa6cU7VQNI5LVvLqfKmMmIim2mgcXGMQ0L+K6Q5I1DgvO9gKvNCjQ0F
	 MPY7vRzMaQGXYToSndbD+leFkbkUNYd0DUWVrOFyF1kPO21+wd9X7qVtmi1VFxWrpF
	 djQ953dgCoff3askDKBTMz0OJaRsSPy1+L5Iado0bEDqZmj0h0SuNF7AlcwUBzIWDl
	 NE64N5bIWUjOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45CECD8C96D;
	Sat, 13 Jan 2024 02:09:42 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd_JM5mnQjUQLbsEBS8kTAaFy5Z+eYveFQgMpRDhiagzRA@mail.gmail.com>
References: <CAKYAXd_JM5mnQjUQLbsEBS8kTAaFy5Z+eYveFQgMpRDhiagzRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd_JM5mnQjUQLbsEBS8kTAaFy5Z+eYveFQgMpRDhiagzRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc1
X-PR-Tracked-Commit-Id: f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
Message-Id: <170511178228.6595.8786450365209064008.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jan 2024 02:09:42 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 22:21:25 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/052d534373b7ed33712a63d5e17b2b6cdbce84fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

