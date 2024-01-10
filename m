Return-Path: <linux-kernel+bounces-21636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E582922C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA58A1C2503E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0239FF7;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ08/Grm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC45360B1;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EAB2C433C7;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850265;
	bh=cWHK+od9zX++31pEh4jLKyCEE3QsgqyI78w09wDtO+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HJ08/GrmsC1/n+0yJOmRwwa54diNeZO9rlCJ1ZmCz3D2t6jT4OZQ7Ccmo7zEjcBZ7
	 7MnOf+9USp0WFM7FmdKNR3UmRPQnXFhr8kmBSLVcJfFk3qAYjjb5tfAjntdm56n3KY
	 khMKpWsU+cZS6iuUwTXpydFKO/T/aSZebhS4EFOhUAjMGvzMR6SIenYAbFG1bnF/Cr
	 lyuWTjv24uUVqsf9V7KubO3c9OAL6jJYJ4bKRz83elpK6K5RQPFRF5e2JBIXAcQyfV
	 IOrXdDhonzSMVLVyMdrs8dT0fUm1lHDqqwbGuQcqyk3ThMspW6ySjiuMBVUZV+UjOb
	 pNRRIDi5uV3Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E014C4167D;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZu5uEwX6QgokecO@google.com>
References: <ZZu5uEwX6QgokecO@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZu5uEwX6QgokecO@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.8
X-PR-Tracked-Commit-Id: 57eb6dcd32cf6b49c38eff81e60e8fd471aa05a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3efcce4a9ec0d2f47ad7c501d0b072c12a1706af
Message-Id: <170485026557.7649.15280250040995063848.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:31:05 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 17:00:40 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3efcce4a9ec0d2f47ad7c501d0b072c12a1706af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

