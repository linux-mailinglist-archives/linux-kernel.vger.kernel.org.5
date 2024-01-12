Return-Path: <linux-kernel+bounces-25075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805E82C734
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE38285035
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E418ED5;
	Fri, 12 Jan 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az89xzU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A818E0C;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B8CC433C7;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098029;
	bh=M/30r0NvTosk/kbuONSypEK955IwxD2HAnW1ir0oorc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Az89xzU7Suv44V6zPvZS1LaH0jleeBWrWnRwHi1DYz4yzJQeJ5oh4//f2xleTE1Hs
	 z9C+pd+ioLH69rzecF8oIZb6GCEsn33rWVNSAZe4bAO0ZbWQgwnn2Z+UwBmWqmlsaq
	 RMYRS/xblxR7XDg4IaA+XVXbuSUeCC5tqiBFQF6vy2mK6e47hf6lHRHB61PwXZ+btJ
	 qKULlIx3rizYbqVc9zpDYxuH9vy1EQCvAIj8uMSqu9SKQxC92Tz+3ZrGsyShNLhh+K
	 9FyISxPo/lKkEqxLPYG2vA46Ik/KxAxV8kcd+Pbvsv67rVELLLmNo6N8b5oN4Z+0jn
	 SH8xaSJLtJDYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EF1ADFC697;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112010650.GA782780@nvidia.com>
References: <20240112010650.GA782780@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112010650.GA782780@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf9ca811bbadd7d853469d58284ed87906cc9321
Message-Id: <170509802944.4331.15727570788389988171.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:29 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 21:06:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf9ca811bbadd7d853469d58284ed87906cc9321

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

