Return-Path: <linux-kernel+bounces-16065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA268237A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB4C1C2476D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DE1F61F;
	Wed,  3 Jan 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhKFhYlo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F251F615
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BD8BC433C8;
	Wed,  3 Jan 2024 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320352;
	bh=101QkO2k65BCAMjWbc3ZNJnw8+CH2AuuahjHHtACVO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BhKFhYlo1Jgep96ypj3opPQBpI4N0o14AnhWg04x33misFhs8Gluge347Aar9DcNE
	 7vWeXxVGHyV/qH55Dd64XX2xhl4/c1VGrrQBDXj+/TI5wVr72jYR5bn6J3Z4OeNgzY
	 5lCCvGutErULQxeFV5OfrDZytECJwW4/+uk71tUCkME032e8ufVwVu8PDzICRqQI/+
	 +80rcKLHw7AiigeWy/MGJ+URiGQ//MJ5tCB8wHs+i7wa5UlhZ6S/6xvuXojMGtXQ7G
	 sN7oYWec8ouPBwy4wKWgwBqhlzT5Wh9/l6sea2UVSD/NdcFz2oGjEV+y/+1MFF3lcA
	 ligxkRTqit8ZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A3F0C43168;
	Wed,  3 Jan 2024 22:19:12 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Final fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240102210731.1f1c5bf5@gandalf.local.home>
References: <20240102210731.1f1c5bf5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240102210731.1f1c5bf5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc8
X-PR-Tracked-Commit-Id: fd56cd5f6d76e93356d9520cf9dabffe1e3d1aa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 360f0342b2e9374298e2222c846f3fe9d0295f0d
Message-Id: <170432035236.19489.11575939729330641498.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jan 2024 22:19:12 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Jan 2024 21:07:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/360f0342b2e9374298e2222c846f3fe9d0295f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

