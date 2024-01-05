Return-Path: <linux-kernel+bounces-18353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FD825BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9982F1C237FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CAD35F0E;
	Fri,  5 Jan 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Ayw/aF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543531739;
	Fri,  5 Jan 2024 20:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF020C433C8;
	Fri,  5 Jan 2024 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704487656;
	bh=edrCl2GkjAwPfyTM+UrMePr6Ql1l3vPoo8p5Xan0wKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j4Ayw/aF09CibmkrEFvPgIXZBkSL3RqQiJIsx3+QmRIvNUd0Vp+evA+oktBoYvyQR
	 +/FNU+iZeN7MQMLH/7XnUGWBVi06GN/6hLpfX9hkxqIwAwVUOpSAFpMBMRLmmYRtOG
	 xnnVngBOyCNvkElC7iaGPTT6JgF8Rip+jurClRtz2IqTBvdE7G5VNO9Ex9BQA8AbTW
	 s9uLhhTSWPDVAz9DeThYChabL2NECSZQ6+DiBQQWNbFvY7Mk2w1mM4Jk8afzxnmotJ
	 g/6m2EzUClFgTrWFVhGx/poBNqi4+TMNM1sgupi1OeDwOXbZhzM+W9FMEdgtOXDDDp
	 r6aLpMf5xpsWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA171C4167E;
	Fri,  5 Jan 2024 20:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.7-rc9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105095155.141473-1-ulf.hansson@linaro.org>
References: <20240105095155.141473-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105095155.141473-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc4
X-PR-Tracked-Commit-Id: 8abf77c88929b6d20fa4f9928b18d6448d64e293
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c23529c08fc7539a04c9c9222ab189fcd982e8e
Message-Id: <170448765588.28812.5338499227795496716.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 20:47:35 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 10:51:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c23529c08fc7539a04c9c9222ab189fcd982e8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

