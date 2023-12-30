Return-Path: <linux-kernel+bounces-13594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961A4820883
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CC0B2162F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17CCA73;
	Sat, 30 Dec 2023 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2WDHCHg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E6C2C6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2304DC433C8;
	Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703970036;
	bh=inapjz8OEs8iop6ljFqb3QxarAOGRlN4CDU1WNyE4NQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J2WDHCHg3Yk0JFSBD/8FYjVvBS3yEz9XJFF3Hw4/dXgyojx3YFN+qmNll7/LY7EAD
	 8Y9vVcB/3/7PxTa1fBWGxh31x3PK2jTbC8T9PdXcTL1IcfY/Uhkm6lDIt+c6/cakec
	 TIakkV6rgtnp5hbYHOuWEeXD2o0/TtQnnXOxv/gAm/o3nGrtorgQF2TK66MAxPHX2S
	 mPcSuUB8j+1AnCy89/8k6kaF3ihwh6ys3z+/XeUWZVxeCKUVjH5+PvgIEiUJQKv+Qv
	 /DDvd9qhS5CHj0IxAqGCrdTfZeH7SlSQ2ai9ollTDoIV8xEZsr33sW4vFG4k8NRBns
	 M+6FAYrpf3+MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09D17E333D7;
	Sat, 30 Dec 2023 21:00:36 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231230102134.149235d7@gandalf.local.home>
References: <20231230102134.149235d7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231230102134.149235d7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc7
X-PR-Tracked-Commit-Id: d05cb470663a2a1879277e544f69e660208f08f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 453f5db0619e2ad64076aab16ff5a00e0f7c53a2
Message-Id: <170397003603.6933.14799055565311392408.pr-tracker-bot@kernel.org>
Date: Sat, 30 Dec 2023 21:00:36 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Dec 2023 10:21:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/453f5db0619e2ad64076aab16ff5a00e0f7c53a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

