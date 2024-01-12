Return-Path: <linux-kernel+bounces-24303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D082BA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CF31C25242
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC65B5C2;
	Fri, 12 Jan 2024 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5SAS8bM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AA136B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74226C433F1;
	Fri, 12 Jan 2024 05:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036054;
	bh=9uOQOWcu9589qjg7vOdNOoKIK2O4vFqMz6HYx7sCDuk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O5SAS8bMY2jZfXvDunL6bUdvnTnnLSRufT+wj+BRND7pX2xIBs5nqid7FOCXwPcES
	 NBJU928mpq6uFgfVzDFAYXWR0kh6kCzDCd6CSqh8Hm0g1LCzamUSiEb0olbUVZTfhd
	 re5gZgVkuvgmgU8odbfHaXzTlWL47yVkucRqidoAingR/KYuxUopJkOAuoF+tzgQ4P
	 QY3M/QC7W1JQoT2ph7KLO50M6pnib3ZyuGFI+sYsRodRF9BDWA4mvmD5aSnI0fPCA4
	 k/YqYrKZJrrWXBH10gCcvVB+ELWCKHU3N75ONZsPtu8H8KywAlkAeIlfZDfHOmISEM
	 CSSNvGYoeDVOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59A2DD8C972;
	Fri, 12 Jan 2024 05:07:34 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZaAzOgd3iWL0feTU@google.com>
References: <ZaAzOgd3iWL0feTU@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <ZaAzOgd3iWL0feTU@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1
X-PR-Tracked-Commit-Id: c3c2d45b9050180974e35ec8672c6e788adc236a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70d201a40823acba23899342d62bc2644051ad2e
Message-Id: <170503605435.7299.7615566737748705278.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:34 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 10:28:10 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70d201a40823acba23899342d62bc2644051ad2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

