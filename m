Return-Path: <linux-kernel+bounces-9922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC281CD47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874A1B218A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A328E35;
	Fri, 22 Dec 2023 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FESQcErf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D07250EC;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9EFFC433C7;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703263917;
	bh=O2i5GkKXF4HeE3cNgDiYO0B6MxaCdyUyxEZG54psc+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FESQcErfuQjTomKmbiD8yoyDMa57owOiA8QwkfqLaU6sA83J4YKT9WxS7nhnt8gNK
	 DqHxFIZ9Kpt6wADkwoExAMWOz2B9Thg6NwJUxlrythZ3RVvwy3q4rNapyKv9NrXsYb
	 xVf76K4WjiYWCeIZ9oJvbXW34ioztqa0wMIv5ly8YZ+nho1+WSrgX8v78IDcRp1BOJ
	 9BFnuex/iMcGu57ZyvoUVmwUe3etuucygbMgPCUfQ6ia/h3gltVYzCl3/tOKaxGXKS
	 CPjd8clGTRicCuFmwh6iY/ntLTFrsXsVgkAGgIzduO+hM4xzz58pv/PSxaKpn2DUtc
	 PxHFWffkS3Obg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0ED3DD4EE1;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231222100731.10294-1-brgl@bgdev.pl>
References: <20231222100731.10294-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231222100731.10294-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc7
X-PR-Tracked-Commit-Id: 1cc3542c76acb5f59001e3e562eba672f1983355
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9ca0330d222ae6c32ba5519f5a2f04dc97b7d8b
Message-Id: <170326391772.6925.5113777074821997814.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 16:51:57 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 11:07:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9ca0330d222ae6c32ba5519f5a2f04dc97b7d8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

