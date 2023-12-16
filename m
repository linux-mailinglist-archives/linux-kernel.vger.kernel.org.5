Return-Path: <linux-kernel+bounces-2330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963B815B24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47B81C21A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED7328B1;
	Sat, 16 Dec 2023 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwhu8qhc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F0328A7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 18:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2679C433C8;
	Sat, 16 Dec 2023 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702752699;
	bh=akbTgXWkDvgnJXHxYTzKR00phRRDMAwH5ibXamyIg0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dwhu8qhcf7U1VDSyFqeS6hDLIcNloh73TDu9MOTyyR7fIW7bBiYG4M9n/pNy+6FXE
	 r846xKszy5abExq3KpuzyKsOkP2NZJ5X4rP7Jh9JgEUfVvKCVU4zMMXbFYqKs2z9GG
	 FsqqoR5Tyv6TpEJp8i/HJ2dciu0+NtXu/yAuYwn/Tui4KMVACqO3lgVUSxWhicLglI
	 lxhQarQvKDabJS7FWOlcwOdOnv3DcIjWN5/ganWpg7woAMz4fSsNyUQugofdmzOhHx
	 FR8rdt6Bq5THMaN3kA7hK/cqKVnpPB17+eBoEFKU8pDeULKLXCd5eu6vTuWdZo5LXN
	 kFhfC3ZzESuWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C77F5C4314C;
	Sat, 16 Dec 2023 18:51:38 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231215232956.3127a09b@rorschach.local.home>
References: <20231215232956.3127a09b@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231215232956.3127a09b@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc5
X-PR-Tracked-Commit-Id: 712292308af2265cd9b126aedfa987f10f452a33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
Message-Id: <170275269873.13191.5928138547084705519.pr-tracker-bot@kernel.org>
Date: Sat, 16 Dec 2023 18:51:38 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Beau Belgrave <beaub@linux.microsoft.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zheng Yejian <zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Dec 2023 23:29:56 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b8a9b2e6809d281890dd0a1102dc14d2cd11caf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

