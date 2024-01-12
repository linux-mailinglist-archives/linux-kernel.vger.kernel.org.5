Return-Path: <linux-kernel+bounces-25071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727AF82C72E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1603FB23EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F118658;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI+W2w4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BD18629;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DA8C43330;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098028;
	bh=81mZuJRSCM6LcwaPdTzDmYKCM8djbYCnvaxo2lgr21I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lI+W2w4xavwtYpwPLLz2T+s+/3Vr6/sRUWWFyKd47W1gv4cPUbv3m93CrXAZzGH5Y
	 F71RpBEXOfG07Fqw5B1tVaEyRBxHyhiWC5z95LaMmLKuyhXiLcu2m8FcWryHq1tI6B
	 uGguTp+t83ZxlYENV08Kk7V0Lvamtw4q48tmVd4ewleK9Gga4WQSpvjizNRhsp97YV
	 QugTXyv+PE5YCcWF+yJ3jHpVYCV3HhIEo/5tc5/QOg7kjpWXYRfeOe9iF8Rf3csiPH
	 aIw1odbF3fy/cbhb0GoLvwJbkNEWszKWS4XoOxnFQTiZi6jq4e0sJ/E+0n+4fEN9Eq
	 UqmRpIEhcZYLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1510FDFC697;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109190514.45830-1-brgl@bgdev.pl>
References: <20240109190514.45830-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109190514.45830-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.8-rc1
X-PR-Tracked-Commit-Id: 1979a28075470ef82472a5656ecc969f901e0d3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 576db73424305036a6aa9e40daf7109742fbb1df
Message-Id: <170509802808.4331.10892348092320142699.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:28 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Jan 2024 20:05:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/576db73424305036a6aa9e40daf7109742fbb1df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

