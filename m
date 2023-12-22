Return-Path: <linux-kernel+bounces-9864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF081CC85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F31F2288E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0624B2B;
	Fri, 22 Dec 2023 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g13GQjhG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70024A04;
	Fri, 22 Dec 2023 16:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DA1C433CA;
	Fri, 22 Dec 2023 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703260978;
	bh=SDPxB5gPfCERiCk+X+3lKtCO6xGv986UEQuKvIoxBWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g13GQjhGy8QySB4xeXOzbX0LW03OOk5w7yFvNs/gEOhfnbWGW2JyGZwqLv0TJ29tQ
	 deQzihYFsyPeiM8ZXP3/JH2biv8rmxgBKlnxwiESzBQGc/4sIH9zRwu5j6P9efPMMV
	 VYeRQcsYNceRI/C7m7bnUzx2dfhLussbHL8LcbaqFrKxOFJ2uPC8DywuGmRqnf6GlN
	 HPi0f4UiazG7lQRhJBSpQ1QLr88VM7xNGizsuULjNXKsj6Cc4A9UHlrjmgBP5dcUlQ
	 F2Av0Fm9oFv+M4uEbM3eglPcunf3Tqq6fBJHtZFyZ646gJAVXScracbRQZqcMRQSMt
	 rvlpygYS5A7lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0A40C41620;
	Fri, 22 Dec 2023 16:02:58 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYThUpCUMJUMP3Oy@codewreck.org>
References: <ZYThUpCUMJUMP3Oy@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZYThUpCUMJUMP3Oy@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.7-rc7
X-PR-Tracked-Commit-Id: ff49bf1867578f23a5ffdd38f927f6e1e16796c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93a165cb9a4c7bf517db07abdfafde742c7dc234
Message-Id: <170326097871.10957.9008158473749705625.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 16:02:58 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 10:07:30 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93a165cb9a4c7bf517db07abdfafde742c7dc234

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

