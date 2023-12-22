Return-Path: <linux-kernel+bounces-9924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D381CD46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C942860FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D628E3C;
	Fri, 22 Dec 2023 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHecqjA6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AE28DDA;
	Fri, 22 Dec 2023 16:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ADD5C433C9;
	Fri, 22 Dec 2023 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703263918;
	bh=VHokONlHkHVHxLU/6YrMWl0oF+rGWN4DzsnhP43ofas=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cHecqjA6nlhVCgQGkWqEL1XRyLVcoMoWkaLGCuI1V/b3aVWCwsVLTpb+e4hyG3mJn
	 n4T8E2udpzkW3wmj7soLSsBNXeLC3otavvjmn/ckZ+cwUMuhIeaTkyEiLoE5xe1/fe
	 DHY2Q65bJ8E373JD2BIX0kTR1XjHatq5Rw+ePqntoJS30EK93tLVBY/kVyQFd6jOA+
	 WFz+C2FMtGwvWuiiKtSI/WkrYARjoKZbK2DT9r+Pnr9D/NN5MaUWwDHRHg1uA+2e1p
	 lRYUQtroVJR+tfeQAtA6DA60/yNIVUAVf7D6LH2JAS4DAtxKbc/qzNUX6RX6Bjjv8R
	 gv3xKvz8E6FVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED2F7DD4EE0;
	Fri, 22 Dec 2023 16:51:57 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <s5httoatcwn.wl-tiwai@suse.de>
References: <s5httoatcwn.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5httoatcwn.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc7
X-PR-Tracked-Commit-Id: 916d051730ae48aef8b588fd096fefca4bc0590a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5414aea7b7508d01235ea0c95064ad66395c3239
Message-Id: <170326391796.6925.14650561582298257660.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 16:51:57 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 17:33:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5414aea7b7508d01235ea0c95064ad66395c3239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

