Return-Path: <linux-kernel+bounces-25067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0882C724
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC92827FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BD179B5;
	Fri, 12 Jan 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXtgseqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6E17753;
	Fri, 12 Jan 2024 22:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C7E0C433C7;
	Fri, 12 Jan 2024 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098013;
	bh=26deiBuDM2cHwW+fHUMMLk8LExSj4ydAlDceeDpdz4I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cXtgseqM65J//SkT/lf+jO9L5FQcY63RHWmOOYT+zsla5guidHXXvbidoFz2nviGh
	 1dKVs+Jp98QbUnb4t+6sAEhPtQBU51kE/rN4EXJtAKZkWD51+ymoMfJ3zyGJmKy6pU
	 RAXX13j37LU0SnfVxxOK/8jpq2UzrBbYMp5I01JahQ7pAYu/vtMSzhTqlrUkJE9gQh
	 wOkRwQ7pSq9wIPfJOa3hNal0Ke1bulyqQQaGh5ocwwFiiHd7uBC/msOeZPML0XXqDx
	 F4M+Vku7bUyoxoxZR92xtspKI4X+XBcpA6tvyRMIpWPaUsaNK77N2CzJgoOsZe78fF
	 HP+Ms2yRSNLdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6099BDFC697;
	Fri, 12 Jan 2024 22:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM/NFIT changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <659f98289aefc_aeafc29498@iweiny-mobl.notmuch>
References: <659f98289aefc_aeafc29498@iweiny-mobl.notmuch>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <659f98289aefc_aeafc29498@iweiny-mobl.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.8
X-PR-Tracked-Commit-Id: a085a5eb6594a3ebe5c275e9c2c2d341f686c23c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3cc31e75185f9b1ad8dc45eac77f8de788dc410
Message-Id: <170509801331.4331.11664974315313237446.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:13 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 23:26:32 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3cc31e75185f9b1ad8dc45eac77f8de788dc410

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

