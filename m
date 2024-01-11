Return-Path: <linux-kernel+bounces-22975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF482A5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0A71F271FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD42116;
	Thu, 11 Jan 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po3ZtUl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049A111C;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D42AC43601;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939846;
	bh=2Ehi9MvUvYj2i3upmCtopTC6fjPCoweOub1OYoxPCro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=po3ZtUl+JIJ0hvKQp5GIS2DT4nwiClM3PFSIuzwz/odOr8qCQEPzmr+CxPnOF4MbB
	 5eOwOdFUPfoV7ZxwwvpWfgi3drpdphHb5hMRCquz4OC5pufG1Ra0y64djBLJ8j9fjk
	 Bd5VRJjzktlog2PeQGj9kYnKhVLref7i66pAD9HnYzpVrBqUZa8GPAR2TJdJr83Drl
	 3pBlNQ2iw4edMBDQYbMbqF11iwrHID3mtT7bWtmDu9b7gSwMZs9v9/Nh/TYNSDWxK3
	 uuHtOV2vLM0uZxFii2e5cCejmf7umwN/1l3+P7OyW+Umlhb1Rga1jYRa65Ry/U8sEG
	 wgsZ/KjONO59A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D7C9DFC686;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muCHfBddtoXwKmFZFnQ8+H+PA_gAf8htYEGhN0az6vV8g@mail.gmail.com>
References: <CAH2r5muCHfBddtoXwKmFZFnQ8+H+PA_gAf8htYEGhN0az6vV8g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muCHfBddtoXwKmFZFnQ8+H+PA_gAf8htYEGhN0az6vV8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part1-smb-client
X-PR-Tracked-Commit-Id: 26ba1bf310f0ed43f249a93d0cf8a93675cd8ae8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84e9a2d5517bf62edda74f382757aa173b8e45fd
Message-Id: <170493984657.10151.1402667335311596210.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:06 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 16:26:33 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part1-smb-client

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84e9a2d5517bf62edda74f382757aa173b8e45fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

