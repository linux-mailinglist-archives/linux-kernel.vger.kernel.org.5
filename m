Return-Path: <linux-kernel+bounces-309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21599813F18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546681C220E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403057EA;
	Fri, 15 Dec 2023 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0QOP/2g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E9EBB;
	Fri, 15 Dec 2023 01:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 178EDC433C8;
	Fri, 15 Dec 2023 01:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702603079;
	bh=dD66Jrb9XlDMZE7mqoPH5BHLtFeEhaaoDCDeFOFfhu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F0QOP/2gxMB6y+ZL4g6M17CLFuJe7fDYOHWeVrbmheJzBuZBGcj4nAAyJ4T1LmHJt
	 xIgCrXVVq0ubNzTmCpUwQ2W8xfOtmsPGKpTEjFXOOq+WieCgql2SU4e+ajbf/Zb8oQ
	 8BV7hF7SahO4b22pskxuiM4t4ZKzACVqmNc3S9newEz3gykRxjL+8m7hga+lTdJNrU
	 cWkZFSA6S2R5KF0av+j8tDKhlsXEuk8a8JgDGmyzT/RgLpNTz+GSsVml2MLsHRB7Wd
	 VDrEI7cmO93YsYljrfShNydScUUMFkV8j0FT0f7iAg4wFUW+r8+JdpBWVjU055kwHy
	 CUEYSk/MqJ+3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F037ADD4EFA;
	Fri, 15 Dec 2023 01:17:58 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cdf76a$lddk7@smtpauth.intel.com>
References: <cdf76a$lddk7@smtpauth.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdf76a$lddk7@smtpauth.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-4
X-PR-Tracked-Commit-Id: 7bcd032370f88fd4022b6926d101403e96a86309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 976600c6da56c488776c9ee2a5733ae9736e2a75
Message-Id: <170260307897.9073.1342024765550824813.pr-tracker-bot@kernel.org>
Date: Fri, 15 Dec 2023 01:17:58 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Dec 2023 17:59:36 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/976600c6da56c488776c9ee2a5733ae9736e2a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

