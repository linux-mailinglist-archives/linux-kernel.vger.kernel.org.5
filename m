Return-Path: <linux-kernel+bounces-20359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84876827DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0A91C234AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A324B44;
	Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvio9GVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA6134A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF2AC43141;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773062;
	bh=9Z53iwKDQL4rEcgimEyufEB7raA6LsGRZzqQGQznPxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lvio9GVIRPG8vFe8RUPPUMzrh1N+WMVVZ+dFmck6MlbrCUy5LhhTuoAZruCeYokzh
	 dvIhaY1NBGm3iFgU8OfSECwSTfv19FO6W7PnbODhLAiZ8Ac73HLux4L/u4tMOoUKHJ
	 2CnOb/27qcmgCVHRIKDHEpM5dEZHD7E2Tj0Uv3SbNN4Iz/qnaljYAPXoVoGiRGmPWi
	 vNUV9RmpPO+hexgTZmdMnc2Yb7sxmhB0iF/w0mdGSrJ89Q+1857OllUL60jVk8acAz
	 /ko5O/I1HXXOLs5a7xQNfp4i4+lZWrPMzmAS+NbDBa1A7PM+js5hWqe9dunHcVGMjT
	 9gU0EV4edh4rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDDB4DFC688;
	Tue,  9 Jan 2024 04:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] CPU hotplug changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvNBnboWjpkQuW9@gmail.com>
References: <ZZvNBnboWjpkQuW9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvNBnboWjpkQuW9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-01-08
X-PR-Tracked-Commit-Id: fe22944cf05ede8e6f841cfecdb7093a53a3d9b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a08b4d4836c721e012ff4c542a8baa8baa3594
Message-Id: <170477306283.30368.332521083164923801.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 04:04:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 11:23:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a08b4d4836c721e012ff4c542a8baa8baa3594

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

