Return-Path: <linux-kernel+bounces-20356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B2827DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1828551F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02221374;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC8l72p/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B3468B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9022AC43394;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=ZVeIQbvA7lysRgtcO0Q5s9phaqhHi3+fZIfL8s3RTWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kC8l72p/x5+9utpGWjEyz9iTnn6r2hrCYPmrwhzxiNg2EvbNDJYnxjqc+P2NYPL/h
	 9lS6vqkEeOxMUCqbBrb/0Zb1PAXkah4cVv8gcFtOlOEZ37Nl9OLwJwUwNvfM4iq0IX
	 yP4GWv9s9T3Acko/jNCTFKZVcNg6bOrDhMvPYyIqdblNs7MNH1Rsnxw2DHXXitgVpw
	 59WMIk2V1l7CKGZTVJuDvf3vrBJM1EpNI49Y6W5vAYORmQ9n4erGzwDYmO49gby2Bc
	 xZBirJgNN2vn0lU87qnzkF9viAgu+DzGLqNW8GnMvPzIcep+J6aUlncOhdE5zhCsdD
	 fDjKuDMX1JcIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E336DFC688;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] objtool change for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZu+vWxAfJiAOjFP@gmail.com>
References: <ZZu+vWxAfJiAOjFP@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZu+vWxAfJiAOjFP@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-01-08
X-PR-Tracked-Commit-Id: e2e13630f93d942d02f3b3f98660228a3545c60e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 669d089a7fe1eacf4e86160297f32c678ee71ec5
Message-Id: <170477306251.30368.1808315452974851756.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:22:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/669d089a7fe1eacf4e86160297f32c678ee71ec5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

