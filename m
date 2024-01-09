Return-Path: <linux-kernel+bounces-21429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FD828F05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D48CB23DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077A3EA66;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcADTtnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2473E487;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54247C433C7;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836413;
	bh=5dszgQgbQNayVSAdr0JuJsR48NOE9JSdxp+Zue6jlew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fcADTtnS6DTX5ucnLV3yxbT2bHW49jdm9G6aPgHJ/WHdjzpQmRds9lL+wpw9Kc+fK
	 /3Qr79QcL+z/n1whUfNXR0AybpK6Jtlsa37vDmOZ/XJnIPVcTJEIh7Rf4x7I8fwoT3
	 CXEnN/HqadQyZaXV0r1FGlXlQ84MAo0WPuNru9Kp+IM7gIak+H/cyWSXdPFOmDmvZ7
	 LMV46vd354W172/ZuZQrj9UwEU5mSDxD6v4C6Z3X3fsyU6NkNRV7HGh2l7gH1xwK0+
	 2jpcHN4krTf2NejdxS//JSwMWJTCdDXZDAe2agGeCr4dAUo+IprqCVB0k49FmTxhFl
	 tTyBInKREd8wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D6FEC4167D;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20240105
From: pr-tracker-bot@kernel.org
In-Reply-To: <f88ee41d9615f7382f89f6a3fbc2f0db@paul-moore.com>
References: <f88ee41d9615f7382f89f6a3fbc2f0db@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f88ee41d9615f7382f89f6a3fbc2f0db@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240105
X-PR-Tracked-Commit-Id: 4e8714b76613e6284b263274d6dddcfac24be262
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eab23bc8a807dbd32ac4f20af4a146d1679f57a3
Message-Id: <170483641324.1854.18051833503795004567.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:13 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jan 2024 18:20:52 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eab23bc8a807dbd32ac4f20af4a146d1679f57a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

