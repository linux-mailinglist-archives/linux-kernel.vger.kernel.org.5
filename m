Return-Path: <linux-kernel+bounces-20362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C001827DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5111F234C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CDD2E84A;
	Tue,  9 Jan 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxLdx2By"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE24699;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21312C4166C;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773063;
	bh=INq9N/RBO+BUMf0NvqNuU1L9ysliXo0RWPdyZpegPcU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QxLdx2ByrUxIfDWfU65IH/rYRHI/dHvxAbBec4aZoxxYzIyi2VsIt5EyvuV3XSMnk
	 NtKe5jXKJ2wYgW5SgkU9eTKecR03jpayCJWXDi/nDkQXbLV+Ua2lkLA4QN4y1pI+X7
	 Xwqwwi8ojiqrO8u6VNgFy8Ui6VYxJSiRl22ZBn6jgN1qgJ12sUDCkIar6TK6nk/VkE
	 sWeOcJzv7cayWmz3jlVo9z1f1mTr07LfqwHM6wgiR/VsJGp3Vcclzj98I9fk82GbVN
	 uZQor5I1xe/dxbqE2bH3PV+61nfrSU0DzkPqKqsNS8ovChMVxIY2A0PEj3xVVPv9dP
	 NYJByx0HYSZNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10107DFC690;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvi/bFoxFRnS4vp@gmail.com>
References: <ZZvi/bFoxFRnS4vp@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvi/bFoxFRnS4vp@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-01-08
X-PR-Tracked-Commit-Id: fdd041028f2294228e10610b4fca6a1a83ac683d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aac4de465af08ccec90ef47bdcc13435e48a7223
Message-Id: <170477306306.30368.17690485857633138463.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:23 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:56:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aac4de465af08ccec90ef47bdcc13435e48a7223

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

