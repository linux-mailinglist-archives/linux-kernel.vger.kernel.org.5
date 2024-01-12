Return-Path: <linux-kernel+bounces-25072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6982C72F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4D1C2060E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599531773F;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CELxkbm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EC18638;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB00C433F1;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098028;
	bh=FYsUy/hqDzdQAnyQK5gZMiuusYTz0xctN/Jq/mNFkNw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CELxkbm13Zxtg8CfxIKEk+ULcItM7+V9noulBolltObEb6jDoJLCEFNcJXTEiUDxw
	 wo85VZwNVdKDAJk+wTgW63+rVopKHXgUFTqbm0pZvIq0gZLpNOIUNmEaDy8bJZXKis
	 NIQ+8vzgELvvGSN+m/yxF7eBMWj8qaUjYJR25QCEcFRMJFjOi8T52fkeaRSAV0OHUZ
	 P3XuTU5CIAtdE3dJQuDQYlCpwtOCxPsdq8tuWo108cdRtcWXsgxG6cSrMzUf9ZYlqd
	 7eyIpUefa2t2QaEEqkMaDGguG7aqJP68+7wHFR+yWaBKKOwkC1TJ0xiry50t9yNot8
	 kkycWjzecBYcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 589A0DFC697;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109223928.2113621-1-sboyd@kernel.org>
References: <20240109223928.2113621-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109223928.2113621-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 4f964cfef39d48a8e6748847df9a1ed310b96c4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c736c9a9553f9cfcb1b03e65f91bc29fc6446fd3
Message-Id: <170509802835.4331.5074851812869255335.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:28 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Jan 2024 14:39:24 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c736c9a9553f9cfcb1b03e65f91bc29fc6446fd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

