Return-Path: <linux-kernel+bounces-25005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AAE82C5F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58761F256F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D871640A;
	Fri, 12 Jan 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI90ViK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159D15AFE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0897AC433F1;
	Fri, 12 Jan 2024 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088418;
	bh=n2qpSfzBdeIj4whO8TofAHanTFZG3WGJUxhBb7hd9eI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bI90ViK9XO50sRYA7pMqEYsCW9fJ56BuRp4KFtj/Ton0Tc3AEsHtAdiwPlDUR7g0N
	 IexpAjdHpoIlOXpxGiSERiHAVfj+gVnhMDIx6FbFr0fZuaycZ9T/pDttNwZFKBF1E5
	 d76EWobV1z9kMuRjW7GsgQHd/mvunKr0LpM5pqMOkl9qRXZymOl1FppSIcPO4MfstL
	 lYlYfTr4JpMBwxIvp/OqAfEZBnS1xJVYZ+4FSe9KHo/2u/GchQCr8RdMoWWnAeD+Iq
	 yOjd1lhJqLWJtqJFYdi4BnUlipcr6ZKnbkBpGSzdFWmRwOIID8bBtouCnOLqaRqKVF
	 al6H5bnpZmeHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A8DD8C984;
	Fri, 12 Jan 2024 19:40:17 +0000 (UTC)
Subject: Re: [git pull] drm for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-10
X-PR-Tracked-Commit-Id: b76c01f1d950425924ee1c1377760de3c024ef78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf65598d5909acf5e7b7dc9e21786e386356bc81
Message-Id: <170508841787.32272.8044456543001426203.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 19:40:17 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 05:49:21 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf65598d5909acf5e7b7dc9e21786e386356bc81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

