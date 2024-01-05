Return-Path: <linux-kernel+bounces-18178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DC8259BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CA71F219BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771C34CDE;
	Fri,  5 Jan 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVYebEZ2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9234CD6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E8EC433C8;
	Fri,  5 Jan 2024 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704478219;
	bh=1HLYg5Tk7fI9rIiNU/+JZuqGBriCKiLmdd9L4ueaysA=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=mVYebEZ2CTaj3PaeT8oQVWLjoWrFMcjSl2RIzcBHFntvOEX+7+KJUaBNl3uI/mSd8
	 I3/BNxa1gWDieP3Jh1cfgB/Bb6j60UijJ0NzkG3fx4B3esVRIdmzDDCKu9jgEkqEAW
	 d0HdPxXsf7QriZOxqBhK4/O4A6S67Tn9B00H4XVs0qyTRN6s50lV9MHS++LRsIiSKH
	 MWZzD5dNjmwBPcGdbWPDbtjUuCQXyiNnNsVBfMXsaHGrgL4QDOZwJS6HDqp9Nsvl9Y
	 C/lunnfT2W59RnqVQvA5pwoqVqyxm28pvrJknQXCG+zlGSsfw4lewl7AOvQ14tO1Fh
	 OgzI/BrznaabQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 324BDDCB6D8;
	Fri,  5 Jan 2024 18:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.7, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ade6f246-910d-4d9a-aab4-1ae21a18da00@app.fastmail.com>
References: <ade6f246-910d-4d9a-aab4-1ae21a18da00@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ade6f246-910d-4d9a-aab4-1ae21a18da00@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-3a
X-PR-Tracked-Commit-Id: 643fe70e7bcdcc9e2d96952f7fc2bab56385cce5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d0dc8559c847e2dcd66c5dd93dbab3d3d887ff5
Message-Id: <170447821915.10283.2607340512395858597.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 18:10:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, Chen-Yu Tsai <wens@csie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jan 2024 16:38:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-3a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d0dc8559c847e2dcd66c5dd93dbab3d3d887ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

