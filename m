Return-Path: <linux-kernel+bounces-13593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFF820882
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551FB283DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687EC8F8;
	Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V42Vs1NH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25BC153
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00ECFC433C7;
	Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703970036;
	bh=xM/Zs3+Ak6NA9YBd/lvB39tUyTB3N0PsiEtQIn15Lg0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V42Vs1NHbeGgSTAAoSwaPS8QaI4hOkJeyHmKaRagyQbu62Ijtoqp29wkYen+31eE9
	 pI7HU/eu3s4yIp+iAcUFTIOLPxHgrqyd4Ol4gj6uoMmttxlufF2+Klvfz2Ism78/Ik
	 RQmEmI9YK/TLa3NKupJWWD3KlVeeYL9eu9bOVN0j725BcI1yMSW9/SuhGOXYtxOsde
	 8HPPVGX9KZukRmtAd8EPc1dEl2zDcXW2KS5Cm72IqFsVSeCMrDbOLDuNKstTL2bg91
	 UZKeFmG6x8oRk4/7FVLpKx1bXgHxyT307kke1POxJD/9z11QXCYOQtNrOt0+vZFF4x
	 Atqw+IrawmzSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4752E333D4;
	Sat, 30 Dec 2023 21:00:35 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix eventfs ownership again
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231222082959.7d08894a@gandalf.local.home>
References: <20231222082959.7d08894a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231222082959.7d08894a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6-3
X-PR-Tracked-Commit-Id: 7e8358edf503e87236c8d07f69ef0ed846dd5112
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 623b1f896fa8a669a277ee5a258307a16c7377a3
Message-Id: <170397003592.6933.5911086990783209569.pr-tracker-bot@kernel.org>
Date: Sat, 30 Dec 2023 21:00:35 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dongliang Cui <cuidongliang390@gmail.com>, Hongyu Jin <hongyu.jin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 08:29:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/623b1f896fa8a669a277ee5a258307a16c7377a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

