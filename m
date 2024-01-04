Return-Path: <linux-kernel+bounces-17130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2A8248B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6281A1C222C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C32C694;
	Thu,  4 Jan 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbPnCyNL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66D2C197;
	Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46BADC433CC;
	Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395412;
	bh=uUyzxL/whoaQlKCyQDcEzSUXLnp24xYHeBsO5EBExu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WbPnCyNLuLruFW4NJlg3q/Mkw9AcfwT6GChCn4VGdMRhOsARV+Z5g1iTlHRe3EO33
	 +m8XKUGzx1nleQFlKSNTFu1aaaknEmxYxWmBvjyiwFfOhmJhE4o2VkR95sUbcbYQ4v
	 Ee/iVRhUL259V7DCrVR2sREH9c3gb10P/mlBYqMMFCQEk9qpNLTgTxJmRvxn9VUlIX
	 HBH7f2UWyoQ+NyiReCN5FDqaoKXBmXHQjGUIdbrbfovJ7n04M2e5aOHsP+YD/qI6Yl
	 /IsoZuI6IDd+lswkM+vCx3X+6QNexPeVnNKSoubnA5Ir0tY+G3QzTlhIwgRhzTgntb
	 52zdmiTcFsYRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B585C4166F;
	Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734vda0ro.wl-tiwai@suse.de>
References: <8734vda0ro.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734vda0ro.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-final
X-PR-Tracked-Commit-Id: b6ce6e6c79e4ec650887f1fe391a70e54972001a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08bd31ece082051f5369324ae99983f4e3f9b84e
Message-Id: <170439541217.3148.6514329844665870093.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jan 2024 19:10:12 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 04 Jan 2024 10:47:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08bd31ece082051f5369324ae99983f4e3f9b84e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

