Return-Path: <linux-kernel+bounces-17128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15748248B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8EA2811BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279D2C18C;
	Thu,  4 Jan 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSkg4gEY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926A28E15;
	Thu,  4 Jan 2024 19:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB3EC433C8;
	Thu,  4 Jan 2024 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395408;
	bh=UfJh6I2mFrBoujS0j0AUAW4t8ZB5oK4vMkw960rtMls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oSkg4gEYexEiXiaENS4DTgbaFNRUe67zo0pzUFxWENm9pe9lSy2muPqJj6t62vq71
	 Bd3AxxDigv4bNWZtkv7obwW8baNMrWZpIe/IGJ5O6p4bQZ8n/a44QVPbDu09Ol6/9m
	 DWeHRblscfvBssHSjdxuWmn8dgIkD5mvvv3zsr0m0ZtY5o4nBJCwGQI0dWcwsxcGex
	 3MiPedJazl+vLRNL7WByLr8iHbHeYNi8yluUqnOoZ0uDXbFZa7le2M4OsfLPHzwn50
	 D07hxwOf+LguvrOi323z4x7rlji43KnDuvM+i5UUrfDHEVdB/swfcuSq7AzjI3otvP
	 xEOH9u0dhpz3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AAACC43168;
	Thu,  4 Jan 2024 19:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-7
From: pr-tracker-bot@kernel.org
In-Reply-To: <1a6657ef8475862e4fc282efe832fa86.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
References: <1a6657ef8475862e4fc282efe832fa86.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <1a6657ef8475862e4fc282efe832fa86.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-7
X-PR-Tracked-Commit-Id: b20712e853305cbd04673f02b7e52ba5b12c11a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5eff55d725a4e0dc6fc7709c4b1ca4fe40588d07
Message-Id: <170439540848.3148.16111811287337636824.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jan 2024 19:10:08 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 04 Jan 2024 18:32:23 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5eff55d725a4e0dc6fc7709c4b1ca4fe40588d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

