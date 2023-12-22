Return-Path: <linux-kernel+bounces-9863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F081CC84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D43284FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE479241E9;
	Fri, 22 Dec 2023 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0xocgyO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3724200
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EFFCC433C7;
	Fri, 22 Dec 2023 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703260976;
	bh=CPmTjYBtuhsovYGOkaccdtO0Mov4KGKnL7+0splSCH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s0xocgyO232js75/Q5m8+N04Y7+KFDgRcmFbujuBL4GlY1hQuflw0QRREHHbsLpes
	 XAhHof3A1UVYnrvBSbcoGx4BfzN5os8NQ99xZRHAGfFj/M4s7yfnMQ6CoKGCnB13XH
	 PU6BVzdXkovSDmk+ZEcQDwXM4MCmG2n1FT2auCVLUuUWDqgoug6fmKsITTsUCJEKqn
	 9Mkx+bkNmqziYjvSqQGv/Ww0Aoq9Xo/QcHiV8W+r+r+ntPjisKNfwHdQ9dGlHMgr8I
	 RubEU0Ob1NBiW3HWGHQCJURBR4M4P0V76NgszpIDK0BPwpDa5e50ovjZuzrho3l6JL
	 ixnwEM7pBsqZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E09AC41620;
	Fri, 22 Dec 2023 16:02:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txmoVE1CPtarnL=Y4M8XxHs0VYkfdWw-X2MErNHt+DEig@mail.gmail.com>
References: <CAPM=9txmoVE1CPtarnL=Y4M8XxHs0VYkfdWw-X2MErNHt+DEig@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txmoVE1CPtarnL=Y4M8XxHs0VYkfdWw-X2MErNHt+DEig@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-22
X-PR-Tracked-Commit-Id: d4b6e7f582e29acac17bcaf7f7771138d72f89d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8afe6f0e0e257bf7f79f5996c037e8977dcc8cc1
Message-Id: <170326097657.10957.15303638903528908234.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 16:02:56 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 14:59:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8afe6f0e0e257bf7f79f5996c037e8977dcc8cc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

