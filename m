Return-Path: <linux-kernel+bounces-25099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590D82C7F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D271F24433
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7D1A730;
	Fri, 12 Jan 2024 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZGb0QSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB31A701;
	Fri, 12 Jan 2024 23:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB6CC433C7;
	Fri, 12 Jan 2024 23:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101939;
	bh=3y1uoNWKd8tam1ezfC8dDZ4MG9KPOYDb7ijWVz55ff4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kZGb0QSlMlmkBayilS5IbUVeoSSJTwHeIEVHfVJ2Mr3fIpHPvpZs/OAixpWoxrWuA
	 8s9cO4lMH0BVdw4pqZREAxFLehqTnuI8QGmNoAJvtPhre+130I5Nom/1kL2bLrPf9E
	 OT/XUOpcoIPZAaM1ecVSYvm3dqoQccQ75WS8YAXyaqopkFUuOOCtk0eYsNaiEbvLHm
	 qXsOR+2xS+cjsA+/IGIkYZGFjyIG7UGbqrf1eIb7s42XrLsdN3vJoH1ts7q/25AfDi
	 UQX7saMGd0zJpgfdVM0uXwuGM2BhpWU6m0tTUD1ZjhbnyMA12CN1iXbbkoTalJCpxB
	 EgGk2K9ZvA0cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC496DFC697;
	Fri, 12 Jan 2024 23:25:38 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112155851.2987763-1-thierry.reding@gmail.com>
References: <20240112155851.2987763-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112155851.2987763-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.8-rc1
X-PR-Tracked-Commit-Id: 7afc0e7f681e6efd6b826f003fc14c17b5093643
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42bff4d0f9b9c8b669c5cef25c5116f41eb45c6b
Message-Id: <170510193896.16457.16750929757894793798.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 23:25:38 +0000
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 16:58:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42bff4d0f9b9c8b669c5cef25c5116f41eb45c6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

