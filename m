Return-Path: <linux-kernel+bounces-5935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A298191AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F67B22ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4753B78A;
	Tue, 19 Dec 2023 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwUEZGxQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0913B29D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF5CAC433C9;
	Tue, 19 Dec 2023 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703018518;
	bh=IGs2C3Wv5l8ipm2943bFpvRyxIRZS2lbR5fsFwi8FGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TwUEZGxQYHT/yLT4sxP9c1sndn8Ok0VrBj6ySjt1xF6Mgxc6907Xs+xxUsYJbpBlM
	 nLFiPQHuRjEfLlO6e6bSc9knq9Gq5XGsaiiUVhEj/vIyZOEK5ryrYLfoh8CbTsusB9
	 LDn9k9m5FN8CBtdOjVvZ17rFLycQWRPqY7oIQ3qPFL79ts/v1f0H+w5yKYZGG5uAMD
	 LTmdfKE9XDQ4qAhd6NpjqOs3pY2mBcu0nUkeRLV4EsG46lG3yQ1gCAW9k0TESLmRd/
	 KuFSdnZVdjPPU1385j0L/U39MVCVPCISBSa+/NBDQoYlBNZinG0u0eEg4DnFc13pod
	 2WTw1F/b3FDqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA95BC41677;
	Tue, 19 Dec 2023 20:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: fix for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231219124923.0841ca34@gandalf.local.home>
References: <20231219124923.0841ca34@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231219124923.0841ca34@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6
X-PR-Tracked-Commit-Id: b803d7c664d55705831729d2f2e29c874bcd62ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55cb5f43689d7a9ea5bf35ef050f12334f197347
Message-Id: <170301851788.10204.3949337881841515333.pr-tracker-bot@kernel.org>
Date: Tue, 19 Dec 2023 20:41:57 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Dec 2023 12:49:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55cb5f43689d7a9ea5bf35ef050f12334f197347

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

