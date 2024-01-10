Return-Path: <linux-kernel+bounces-22750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF182A27B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E9A1C24F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A760E52F9C;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHrC1r7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9F524A9;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8AD4C433C7;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919125;
	bh=hIIl02LDTgUOTzfDEJ6Jjc4s6++7dnOR+E6k7BHeUPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pHrC1r7lGsDOK7v9Q2OSIlbx4J6g5dTIL6YDG5ZhzyyhH5U4IHmX9CWFAMoUzvGXG
	 Y7GTtilUu34uBMH6/CLERRmcKB9HJNuxbuYLx/dnYvR7pSQD5wJ3Sn5XM6vvVU++wl
	 BjdZAjC/Lp6iTOeaO6IsgN7CLpFJNz84f0woqkPWX61Paxgmp6+YpX72Y0Wfpqb3hh
	 IN1P1m0D2+ERmBA53gvm++kC2qaT0WEAFkxdIliL8ycq52zrWKKldjPdGhBk+16M/M
	 6PN6parxGYjMqQpWak8DB0f/BBJxcDdZXDZuVe0QW93DdeTTeyRsVQJMScAuYjTRws
	 Q1awNJeBkoLlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A29ADD8C97A;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202401081022.31D251086@keescook>
References: <202401081022.31D251086@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202401081022.31D251086@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.8-rc1
X-PR-Tracked-Commit-Id: 24a0b5e196cf70ccff97bc0add6fa7178ad50cc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72116efd6307077546c93e0432a197876cedff70
Message-Id: <170491912566.22036.5061179809330425876.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:45 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, Tony Luck <tony.luck@intel.com>, Weichen Chen <weichen.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:24:29 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72116efd6307077546c93e0432a197876cedff70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

