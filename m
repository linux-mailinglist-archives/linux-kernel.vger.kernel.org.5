Return-Path: <linux-kernel+bounces-21638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CB82922E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053B21C25018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E23D960;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEW+We9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C366364C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03244C433A6;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850266;
	bh=DJuidrvUYciWTEy85d/BbC7qoSN0XIxrWGpxyTQomVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gEW+We9RbQmNuTSx+3iFF+IJJiQcn0bTKI6geHLA8E8PQwXu4c2njyF6BmxO+hnLc
	 dz0LCZ0lDN4q73UE5yWtmoRw04032Vk9obrpxckhxigbj5U51a4D/NyGx9FqlJBT4b
	 NfsSIG3VwP8LrFw41bvvtUyo4EG8aXK9P2pXgU2Ylt+FOC1sF+MDAzFM+WxP9YTkBW
	 Tywdin+ELtujNucv80mYT+r+0QbymnSRVs7ZAltGBdzaA98qyQcFR01WtNkLcPoHBF
	 BOs/BSNadACsBNpJQX+/acK/GbJ1lok1SmlsRgAVMYBB5XxI2aV6t9xLhs3/aT7/aD
	 igWlI2Xi7B7KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCF9DDFC690;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.8-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <8fc798ad-7235-467e-a31f-a79ae33a4324@redhat.com>
References: <8fc798ad-7235-467e-a31f-a79ae33a4324@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8fc798ad-7235-467e-a31f-a79ae33a4324@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-1
X-PR-Tracked-Commit-Id: 236f7d8034ff401d02fa6d74bae494a2b54e1834
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fda5698c289b2ff21d53d935c43351c424f8388
Message-Id: <170485026590.7649.4971732105513415464.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:31:05 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 13:04:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fda5698c289b2ff21d53d935c43351c424f8388

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

