Return-Path: <linux-kernel+bounces-2749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75981614F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4771F21252
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE346BA4;
	Sun, 17 Dec 2023 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpJrpPz5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6947A4E;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 171D4C433C8;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834726;
	bh=pSNSZB0sLTXjW5AP5Xr6P3187V1MXS1FkJVfdAbVRMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VpJrpPz5TPZyTCi4v2QI3bo3AJXcex8gSRzYJRXDO9WAf/1HdTDiITJIyuWeX9VTQ
	 jUfRMHXlJrflrcGnH77Uw5OVXc2+o5KMQ7OahyPj/KPgkMk1Pp4ySHJrhWHW6GNqf2
	 DgslrhXG7Ra7Jz4UL1W9O10/7XM7GvJ7Y8nd0CpL9ro2r7YeSb1WerP7Lhov87ICjR
	 ZO7ZoTOXUm/RSyakEa3jG6u2I/ONhGoOtJ68s4vpk3o0fZNor5rZoks5dso0ftm0Dk
	 q2XrFJOdj1C3LkCjguTQbAZFYvZ7VVTthgx9TS52ibXWnbyhcbEGwI/hm0mq+YCznr
	 IehajJ/si5yKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03731C04DD9;
	Sun, 17 Dec 2023 17:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231217005450.3575417-1-sboyd@kernel.org>
References: <20231217005450.3575417-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231217005450.3575417-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 8defec031c40913ef10d2f654a5ccc8a2a9730c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dde0672bfa3e5c5e8530ebb45518408acb91b083
Message-Id: <170283472600.25242.7735305313063166858.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:46 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Dec 2023 16:54:49 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dde0672bfa3e5c5e8530ebb45518408acb91b083

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

