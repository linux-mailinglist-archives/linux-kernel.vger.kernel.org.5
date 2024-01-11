Return-Path: <linux-kernel+bounces-24036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319C82B5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2245B25C02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049957877;
	Thu, 11 Jan 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhUvRkrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F657868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24280C43394;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705004419;
	bh=3o5fxzrZXmcLmspPWYtH5zMR0B5CE9B/xigBPhIeIxM=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=LhUvRkrVdU7Y+RJz+CcXFC3wMxkhbC3CnC8K2GGf1pYlG14BYnDhg43O3tXpjqDfl
	 e6VUsTkbSHfoo0kZjMLHanPpRiDynpeB08brwMEx7eCvW7z2R96yTaZqfg9k1PrHI1
	 ySAkj2W2QKQnp9+2mZAUZDuwCFs6iFwO9l9xTWHtGbI+fIb94IVbscKsWRfuJ4wek2
	 Gd9OTjREoNpQNJ30ZjPWfHAqcdylYc4o5wveqR/OJf8QxfsunvrwQvbYBYg1mySo4C
	 ISd/28fPd9uoOVZqr+1fbUST//6yKu4rgGF57ZQ8jb4bfy1qWvb3a58OU1bYRgdngW
	 x9fqFzxnR96xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10A66DFC698;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] SoC: driver updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <e56412b6-f79a-4464-b2f8-2ba2c078f0c5@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com> <e56412b6-f79a-4464-b2f8-2ba2c078f0c5@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <e56412b6-f79a-4464-b2f8-2ba2c078f0c5@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.8
X-PR-Tracked-Commit-Id: db0a7c09b2a552c5028a29942e80a4848d182934
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6597d17069a67819f57569e44ac9069f0b829e8
Message-Id: <170500441906.14602.3050873929534381970.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 20:20:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 17:18:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6597d17069a67819f57569e44ac9069f0b829e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

