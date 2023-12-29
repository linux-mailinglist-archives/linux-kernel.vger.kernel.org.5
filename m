Return-Path: <linux-kernel+bounces-13218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A6820144
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3392A1C219D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1E13FED;
	Fri, 29 Dec 2023 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djSyI3O/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B13134C7;
	Fri, 29 Dec 2023 20:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1AAFC433C7;
	Fri, 29 Dec 2023 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703880031;
	bh=qe+h+9ByZXIzHwYNA7e0f0px+RfqF17/rVbxIqk+/28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=djSyI3O/q41VUknmklWmIuPEZ55hYYN9vokdT3+xGwhw0+BGnnJpLwTIcSmYhbOdk
	 nEzTtqTdSjybEz7BCoapRqtTs8mNwWF+xZKvmiXlvnD60OKco6wQ7jdE8Xqi279dTs
	 C7/BzIaQ8SS1tP1BAF6YdHFR05zmQn1hVMjKInAvyRegAPJafvpmXqLP9ZC2bM9naL
	 UxDZ/WI9Jfc3llxrEMIQ6lq/bKkHEemw00FxjejVHtijUIpgd2uja+eO3yWt9i0FZS
	 5fKb+OSGSlS3kzRJxfQ8U54+o0zzqgG6GN5B4WyYiDSyDN/XI8XwZZnEEqi9Egl2KT
	 uWjJvmuqpCN2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EBDAE333D5;
	Fri, 29 Dec 2023 20:00:31 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.7-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231229194209.13630-1-brgl@bgdev.pl>
References: <20231229194209.13630-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231229194209.13630-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc8
X-PR-Tracked-Commit-Id: ad5575eb6278892aa25a5d249c5009860d6d8bbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f016f7547aeedefed9450499d002ba983b8fce15
Message-Id: <170388003164.30633.3480774625083448603.pr-tracker-bot@kernel.org>
Date: Fri, 29 Dec 2023 20:00:31 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Dec 2023 20:42:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f016f7547aeedefed9450499d002ba983b8fce15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

