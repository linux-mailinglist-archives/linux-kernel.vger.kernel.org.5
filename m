Return-Path: <linux-kernel+bounces-20373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B381B827DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372A428562E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D6713FE7;
	Tue,  9 Jan 2024 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKCfy+EB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB862134C3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C46C433F1;
	Tue,  9 Jan 2024 04:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773774;
	bh=PhgKY6SrmYL3ooxNGnbjhlitwkUHLaDOyQz1w7jsCuw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BKCfy+EBVafeHVUjgG50HgvHNIh7kzDvXdVeRXX777YsPeU/hpHWN5vY4GV2y1aK3
	 +YKA6dSnsBMmo1vE30l0sjoz619YhpLtKWurLTsxfzUAFtY5CJkFwwX1/bIiMQZFhi
	 A5QhxFf06G3MZcAk7MI0W+hYs5uXJ9jG5/ycDSGc+t5IYFUWeehUOhpKaxFgJnn7Do
	 on9fjY+3u6ChsO1WVZT73IdA1Ik9NfLxr5yGFcWcDaTvune5yg1OxzXQHsYbSHrvkX
	 emnk/xshqzEysra8zKxihPIXtA83u+uvqf8Zavj/+uFdeAlhby7zEFD75Pa9W3zgz1
	 OP/8a++TRwCig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 407F8DFC690;
	Tue,  9 Jan 2024 04:16:14 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYnvgTc22Exn7Z4C@mtj.duckdns.org>
References: <ZYnvgTc22Exn7Z4C@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYnvgTc22Exn7Z4C@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8
X-PR-Tracked-Commit-Id: a7fb0423c201ba12815877a0b5a68a6a1710b23a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
Message-Id: <170477377425.6664.5426847557963520639.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:16:14 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Dec 2023 06:09:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

