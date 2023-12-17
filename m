Return-Path: <linux-kernel+bounces-2752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D78816152
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CFF281DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20AB46BB1;
	Sun, 17 Dec 2023 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbsZWE0p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DA46536
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAFAFC433CC;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834726;
	bh=xtjnRmXxlgw7Veh+FYkELJmoDLzpOj7PbtEPgw4d5JI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FbsZWE0psvYhJY8X6jeFIWHGIwgQsuSVj+H2kAIrCSzS/R7JEhwTrLVM5vSou89yn
	 HkxSuQ494sISja24Pq8FnRFOlAJpz1awGXKjEqL18RKRcDgKsdXlHu/ZihimLlfnrq
	 SEjp8eN7/XjCrXVX5k2Q3NUbFFkaXXTzJTukQuCdwxv6fUBOlJdhhwL6iSsf3LpQ/j
	 BzkRaPZAw+6NIv+LiYlrQ1aAvIM7bBKbUa1waaIKYIZxvxdQc50wGEJmvY5ezLJvx9
	 K3TFFbZBcziTd6z0m8/Vma1IrRBIXa17d9Hlr3RogaEwKKWttxboBn+NZWbrf+yXV5
	 yMe8MHTywsQjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C62A2C4314C;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZX8pI+hOq9Tg5H2A@matsya>
References: <ZX8pI+hOq9Tg5H2A@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZX8pI+hOq9Tg5H2A@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.7-fixes
X-PR-Tracked-Commit-Id: 393cae5f32d640b9798903702018a48c7a45e59f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: accc98aff5c39fdc63bf0bac471b9c601aaf4755
Message-Id: <170283472680.25242.12025901272747366107.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:46 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 22:30:19 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/accc98aff5c39fdc63bf0bac471b9c601aaf4755

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

