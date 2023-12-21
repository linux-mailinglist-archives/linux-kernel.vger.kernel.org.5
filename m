Return-Path: <linux-kernel+bounces-8909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0B81BE10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C120B22CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52990651B2;
	Thu, 21 Dec 2023 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehGLyfqq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DF651AB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 809F9C433C8;
	Thu, 21 Dec 2023 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703182810;
	bh=VZ/8cn58uU8ckO6xLg9QEsnP2vM6ZmHOsa1PINTYTEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ehGLyfqqs4rBJUnDoTD/v7lRn5qofdlV7dK9vUG/Xdh4+9y7T8USHvk6A0UecmqP9
	 wMU2epWGaU+g7tk0g86inDcy5FlwbS4l6bd4l4/fGjHFeS6hkoFRgZ7Doou9Zx/zfr
	 KZ1G8y1b7Hx4I3JekmiNSnC3jPU5Xp2bwXDF1a7c5r/53Sm6iH3xRyR7phUeHYSVdm
	 X6htuqL8h53lpP1I3bSNq2ikYKsjMGrqIz1Xv/T/xmvO5uAGA6jcVc5gJ4p4e+KtEO
	 s4Vortrgw5CMF+nj0QC0K2R6xZvi6KRS5BndGDqy/1+m98xkBogA650wqa4K/Fb6ve
	 CHw43ECKedTYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C73CDD4EE5;
	Thu, 21 Dec 2023 18:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A few more fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231221102703.08dc1273@gandalf.local.home>
References: <20231221102703.08dc1273@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231221102703.08dc1273@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6-2
X-PR-Tracked-Commit-Id: 88b30c7f5d27e1594d70dc2bd7199b18f2b57fa9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13b734465a9d1cd09551d52eb5faf5fe55e6a9ea
Message-Id: <170318281043.26746.7426331881024017858.pr-tracker-bot@kernel.org>
Date: Thu, 21 Dec 2023 18:20:10 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Dec 2023 10:27:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13b734465a9d1cd09551d52eb5faf5fe55e6a9ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

