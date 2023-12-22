Return-Path: <linux-kernel+bounces-9921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7788881CD44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D26F286847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2D28E1A;
	Fri, 22 Dec 2023 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPelxh78"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82524B5D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4C34C433C8;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703263917;
	bh=Ue0MdyT4SH0otrhoJ4cn6K6f1XRqgoWtWCM044adwBM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IPelxh78Ii2g3sMi43ewXSCXIUrYX3hBFJ/k7ui9zDfTv55HWFRZvrQJRAzyl+z5S
	 HvtfiBw739wX3AZqeLOVXkxevPe4keyqG2XT7N+hQkdPGcW03qU5xIeYn1I0xZdG26
	 JVZ6IJXbnLKtkUoIU/6t1syI6h6fMJrixaAKi4L77gxJL8rEQRFoWYu0ddcCOzoKYi
	 9uhlGwweJiO2ftsZmpTysj+TW71ubXgN1VtcPsaeR4CHjLsnyq7UswKYjlp2i7Poxn
	 78vnbwp0oDoVF9z1SKZMMT2DoXHIpl9O2gpqTQ6bXtXYivAQ1m0Hd29hJq0ydvLLTB
	 GLYTnYnyAYGuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AAB3C41620;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231222063415.17316-1-jgross@suse.com>
References: <20231222063415.17316-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231222063415.17316-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc7-tag
X-PR-Tracked-Commit-Id: 93cd0597649844a0fe7989839a3202735fb3ae67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7bc7bce88bdf52ec2b47c576fb51269a521bd9a
Message-Id: <170326391762.6925.1618445001287059665.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 16:51:57 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 07:34:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7bc7bce88bdf52ec2b47c576fb51269a521bd9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

