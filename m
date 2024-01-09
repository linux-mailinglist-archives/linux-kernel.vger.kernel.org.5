Return-Path: <linux-kernel+bounces-20280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4093827CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05F31C233DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642114655B;
	Tue,  9 Jan 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpFC/F9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD06132
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55429C43330;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=BACx+VHtQNr/GM0fA9BWO7JBesPl3QPFlcpr+XiBrFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mpFC/F9dDHLHW10QOiIAG71RhxvRWdLrFDKzdXOhIv5o/LpZFv863XV7bxb4A5bFK
	 bMU0b+1pbp+OFyqMpvqyGRfKEMpPVTvcg9nJTjU6KhfQwheIty1dlrcbXdlZAgcMn/
	 EnOLI6zToiKg7/kb07stkVyn15akgzRWDPzWlTBnMC6aEBv2qhAhJ5x+dF8QaLiJjn
	 ijsh0ICn3ZDScphb3qXWr39D8vgqWCYWCI6w2z1vVFWIWstDv+0PtpWcq7nWNlX0Fy
	 Cdkmt/K+Ri4kaJMJtt5U0kBg7S+2ijmkvcPa0wFmTuJ3Pf2eUNXFSKfw3Og8Ae9Z8A
	 164Hyyiy0uf1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CF56D8C977;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvZOhUHRrgkOAPJ@gmail.com>
References: <ZZvZOhUHRrgkOAPJ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvZOhUHRrgkOAPJ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-01-08
X-PR-Tracked-Commit-Id: bcf7ef56daca2eacf836d22eee23c66f7cd96a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42c371f8ec4296cee49b10d8e6be50aae90f2d70
Message-Id: <170476626424.5897.16200889528056879536.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 12:15:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42c371f8ec4296cee49b10d8e6be50aae90f2d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

