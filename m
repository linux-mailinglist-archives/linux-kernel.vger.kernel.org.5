Return-Path: <linux-kernel+bounces-21637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D282922D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5662284345
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493D3C464;
	Wed, 10 Jan 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUereXWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F72364A6;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C122DC43390;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850265;
	bh=pBIcTt53KRlk1Dia/kfJlnnNUQio9EI7rDm4qnZIv9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DUereXWJ/DyA5eCL33uMe7xY/0/e7sqwpZwPQv+PkjesO7hdSXnvq6QwIb4Fo5EcA
	 zwqKh4zqHMPMt7EnmUSdDXL4HnSgtx9bumYlaTb1roysWUOliFFZL7HUXMkVU4/4Cd
	 1HHB2DKVvDyFu2+b8itqQvhISHov7Ss9wOJ0e8iZFO2CJ6usF68dEZ/jEAzPASG9OG
	 kMh4Bm7iPeFDiBxyZ+sdpNv2/Gi0N1cJqnyCn/ucCfQFdk0kvkHbAQ1qzVKowb+ZC0
	 BFUgtVxSmuT7OBaIrxRSvwmAJwMSUBWTmu2QuG/74SpyP95QLPIDsstk/pqalUbFka
	 Iki9PWqWFhb6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFFD0C4166F;
	Wed, 10 Jan 2024 01:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZu6Na7lHZj2KU0h@google.com>
References: <ZZu6Na7lHZj2KU0h@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZu6Na7lHZj2KU0h@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.8
X-PR-Tracked-Commit-Id: 09aeaabebdafbcf4afd1c481beaff37ecbc6b023
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9b56eb280451ccfd42e9e554e83c6202a2d286b
Message-Id: <170485026571.7649.14637982180786171153.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:31:05 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 17:02:45 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9b56eb280451ccfd42e9e554e83c6202a2d286b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

