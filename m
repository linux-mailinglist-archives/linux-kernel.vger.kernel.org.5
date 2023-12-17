Return-Path: <linux-kernel+bounces-2747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE981614B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1281F2134D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0846541;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx011+dj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769046B82;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20318C433C8;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834690;
	bh=7omZI5avzk14YeFcrTpugJNQisBEuPz+5Qz14EH58a4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xx011+dj+GbTYtkQaZwOLIXwJUsOIgQqC0+OG24GoPZ6hqQrOQW21i2qrHRvLnasd
	 jeIqjXzPMrugg/6QeCpd1C0m0pGZFEjUnFTrXlQUzaIPTrs7vHO10nXKCa5DOTg0My
	 6lVIO4aihpRJFKiGR/cI/m6/VRljS4f/4PKQQSHNVqMsQVXIuohf+Sv/T7Ed92e7Jr
	 TAJTC6FuNKopiP9fHBqUyNoaE9sjARy0nRP0fllnZoyt3H/Oh12CvfJBD8fQIw5lPy
	 TT88jiAI5lBldYRLzVyHUuIjrXpq5Rc35ZeWTlULQExs2yVTTQCTb0JzZoSDDaAW4M
	 6kx2XxdcjViug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E12CC4314C;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC/urgent for v6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231217115937.GAZX7iqX6fhyiF1mMZ@fat_crate.local>
References: <20231217115937.GAZX7iqX6fhyiF1mMZ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231217115937.GAZX7iqX6fhyiF1mMZ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.7_rc6
X-PR-Tracked-Commit-Id: 9483aa44912f26da2b69dade6099c2bf4b50a8c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef6a7c27db54f06cc5c79f5a756d649828d42f3d
Message-Id: <170283469005.25242.2081033780994860999.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:10 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 12:59:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.7_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef6a7c27db54f06cc5c79f5a756d649828d42f3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

