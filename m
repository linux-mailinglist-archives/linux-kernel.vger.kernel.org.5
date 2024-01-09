Return-Path: <linux-kernel+bounces-21548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3B8290FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5FF288BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170473EA96;
	Tue,  9 Jan 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3In2sGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F03EA8E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 371D5C433F1;
	Tue,  9 Jan 2024 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843931;
	bh=T2s2mQEWs6QBULlqS5J8229yFLqn92vMst+hJ7mSbxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j3In2sGE9gAGi60HRU+8Vhk0S5dSuyE0Kts1EThkA7wmNCsw2jQXumi82UAxgQJ5H
	 5Lp0aQh8KrBZ9jvZscXZJAC4e1CM+7OZe5OP9t5jFbbpceXnaaNUWFR3fTPMmuRZxm
	 eoehWgrb0grPPmJ0zWrg74XdvBJbOGCs0ub5SIFhlL0xVPh7rFT0Y2xgSBJbUGRAtj
	 M7qICInYcl3hCH/Pg/UluoGlz4vvy92Jcn+xr70bWnlnzXlgfRnABd9YkDOsjaECe9
	 oL4JZkpOVE459wM+GxkZnvnI/gCJTgbAwox+mDwXzyxa7IePpzoFmX9Y8bg2m1pGmh
	 15nyEVbf6GbYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 249E0C4167D;
	Tue,  9 Jan 2024 23:45:31 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231227174023.346ec9fb@xps-13>
References: <20231227174023.346ec9fb@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20231227174023.346ec9fb@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.8
X-PR-Tracked-Commit-Id: 98d4fda8f2d4bc3fb97958d2ef4c90e161a628f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35f11a3710cdcbbc5090d14017a6295454e0cc73
Message-Id: <170484393114.13323.6194868442201458335.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 23:45:31 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Dec 2023 17:40:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35f11a3710cdcbbc5090d14017a6295454e0cc73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

