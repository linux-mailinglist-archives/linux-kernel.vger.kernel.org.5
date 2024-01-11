Return-Path: <linux-kernel+bounces-22972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF382A5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C6E1F22D30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A610F3;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez32nPde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B40807;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8DA1C433C7;
	Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939845;
	bh=O7VTOKm7FNUqL8mSsAmCNIckS5wZYYFPqfjtKFhhXQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ez32nPdeHMNF3R39jOZlxfMFIs44XUYqFrAgocGUuHvHrZF0ql2vlSLikmdbpYtHC
	 IV2Ytw6orjgkWKGm1Z9XfP4ClqCjWbDlHRjNsahXtxxHaNImQlhjh2xJjQ6XhCiX9F
	 weGFjiOunaYWJjF8FILru/eAoJ/BgKenX1MEOmLQRdorJ9VEHexsarOubwM32fW8ur
	 3BOgdDDKUddS9n8QQoeOmtHzziGsGE1n1kGToQk2S2yWD8rIKLRM0BxC8xri9Patd+
	 9PBwdW+mQJWcTOYjBLMFUocjeG4HoMLsH3Q3rEJYxO3bRiC8HToop1cy40fD0w4YMR
	 GB5yXW6tJaQsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C75C2D8C979;
	Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ1cUcINeJMJNyft@bombadil.infradead.org>
References: <ZZ1cUcINeJMJNyft@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ1cUcINeJMJNyft@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.8-rc1
X-PR-Tracked-Commit-Id: 4515d08a742c76612b65d2f47a87d12860519842
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cd083d53108b32f4c8ed92a3f85d7b36133c0c9
Message-Id: <170493984581.10151.3207641603041958906.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:05 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-modules@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, Marco Pagani <marpagan@redhat.com>, Kevin Hao <haokexin@gmail.com>, mcgrof@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 06:46:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cd083d53108b32f4c8ed92a3f85d7b36133c0c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

