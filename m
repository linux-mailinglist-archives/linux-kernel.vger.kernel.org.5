Return-Path: <linux-kernel+bounces-21541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A768290EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061ECB235AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C073E498;
	Tue,  9 Jan 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWm38TCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FB3E484
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 406E1C43399;
	Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843713;
	bh=BIeClIideJDJM0aEfD3JSraZPbFaOzHQgchYyRu4few=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iWm38TCTGcbGY47JLfYdy8XpBkFPvXF7ZDRwnYpLFfAAsQxk/btGwBL2GoVqsPHw5
	 zI1gbMTM5r66875H3os+WFpRRBJ/ALspmSmkBFMiSpgWs5UcOwbVx6iBMEuKT3bd+o
	 34hCcymkXLAOUzmx6pc34lbv4UA1+wcuTkY/wGdvBhHfZ9kRA4xVXdtVeOZ/xCAVOt
	 UTfSpE6MdL+HPDTCF1MItTCEQCBTZ+uMdTkEraysv8lNJWhPFpmZDA0w7CrTuVkYN3
	 ojokPx0FjIVu+A30quWyNdXdHF2MYE2FAlLXkBBzzKA8GWrDvGnJ8Td799M1dTeuDs
	 YcV/ri7ItaCHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28338C4166F;
	Tue,  9 Jan 2024 23:41:53 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107223748.885ECC433C8@smtp.kernel.org>
References: <20240107223748.885ECC433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107223748.885ECC433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.8
X-PR-Tracked-Commit-Id: 3b201c9af7c0cad2e8311d96c0c1b399606c70fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83130ff423d61b018e1018cfa9ca5c1511b5f33b
Message-Id: <170484371316.10226.4640767494714743189.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 23:41:53 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 07 Jan 2024 22:37:36 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83130ff423d61b018e1018cfa9ca5c1511b5f33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

