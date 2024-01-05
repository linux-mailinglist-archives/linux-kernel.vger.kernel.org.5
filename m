Return-Path: <linux-kernel+bounces-18352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2F825BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7947C1F2458D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0E21A11;
	Fri,  5 Jan 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITVW1Y55"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5402137D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80860C433C8;
	Fri,  5 Jan 2024 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704487650;
	bh=xxRdBa4wSIPvUpG9DdRO0UWptRYS9fBz/+hAX42MCyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ITVW1Y55zddKhSG84Z+lGP0B5TFShdE0YIh4JBi3pMo14s5+UyN4qiGp7xcK2o5IT
	 up4XqqOTPOjRUblm5S+P+joKxGu1rPSq6t9XcvGVM25pyHYoo0dN+C1fUvr29bk294
	 uySERpKNwjwP7zGqpH/VcqSEtCJOh4uGZ4qG4IyTsX9MGi62EbnlYku4CIufKYSMQb
	 +WOmBJsUtoP4E3LcGMFiJGtGqavCJRL5SiLKKLd4jrMwHko1zodFgIlQVBIggBkHIE
	 loRQ/LPdZqCTp3dEoRB/dG2Jc2u+wnu8il8otKonj5WOESKSuvsqkhA2uX2IR6kNd2
	 GOedIaUn3iiRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DA02DCB6D8;
	Fri,  5 Jan 2024 20:47:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes (part2) for 6.7 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txH-Rag6weAFHx_VgozGmLd4RinHCOzpGbyVsLT7qpcfA@mail.gmail.com>
References: <CAPM=9txH-Rag6weAFHx_VgozGmLd4RinHCOzpGbyVsLT7qpcfA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txH-Rag6weAFHx_VgozGmLd4RinHCOzpGbyVsLT7qpcfA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-05
X-PR-Tracked-Commit-Id: eb284f4b37817d2038fdfe1a9d51769730ab7b5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b5bd1498da5537e3d130b3862bccdd9aedd6c84
Message-Id: <170448765044.28812.6115533026297300477.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 20:47:30 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 13:31:53 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b5bd1498da5537e3d130b3862bccdd9aedd6c84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

