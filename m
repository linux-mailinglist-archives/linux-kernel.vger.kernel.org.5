Return-Path: <linux-kernel+bounces-12328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BA81F373
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF151F2326E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD6EA9;
	Thu, 28 Dec 2023 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRBMr+RS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C229627;
	Thu, 28 Dec 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EDC5C433C7;
	Thu, 28 Dec 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703724022;
	bh=mRx0gmtexSXHggLtO/Gj1OlBoW0jB4lAbMPy9UrmR9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aRBMr+RSgvJg0D0Rg9UQ6wPjF7Cqul/Ju/At2QJlb3cBiWisjDdtLitX2f/fqJgne
	 vx8z4Xiv9yqj3cI8muh00/lR4oTSCRhsJbZW+Bj9CJr78pdvDDi8P4+wzy1vIhp9dV
	 bqsjcrXRnNnyRY/FSa3jDZNncfv4jDes2Et3s6FcxLJhpuyo352F1bD0UYJcI+T6BX
	 sbNsSEVOyaitft3xXg0CEOzxCAi8CfEKRn1RCUjLmg5vQQ6ZNT1h7pA7FgFSgyN+Ot
	 K71DZvBWhzYHb6Xuhu2LT51+iceTVzCN9zz/0Ntdavch306CwsFQu1oBpl+T0yf7Dd
	 8iyjoadoTbuaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C769E333D3;
	Thu, 28 Dec 2023 00:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
References: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-27-15-00
X-PR-Tracked-Commit-Id: 1803d0c5ee1a3bbee23db2336e21add067824f02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5837722ffecbbedf1b1dbab072a063565f0dad1
Message-Id: <170372402217.1891.15749831862328432263.pr-tracker-bot@kernel.org>
Date: Thu, 28 Dec 2023 00:40:22 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mm-commits@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Dec 2023 15:03:54 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-27-15-00

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5837722ffecbbedf1b1dbab072a063565f0dad1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

