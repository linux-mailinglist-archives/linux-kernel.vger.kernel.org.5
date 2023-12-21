Return-Path: <linux-kernel+bounces-7856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F881AE53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9F41F24B67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD395AD5C;
	Thu, 21 Dec 2023 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SceD/I7f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE09477;
	Thu, 21 Dec 2023 05:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89F1DC433C7;
	Thu, 21 Dec 2023 05:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703136126;
	bh=Lw+V06Yn69FY5ftFPf3ftY+ZYPlSO27puJXjTIAOhvI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SceD/I7fZMJQVPJeQCz4+hXcLeJdSbQ+ojU3Wv70G9lQRrJiDTEcTArGtlaa4/J4q
	 gOorr/63yLEWwI7z0gp2s+10TuVIxi9W4cRaKfxg/pD4yv44y7rIepRNmtXR5bcb7W
	 Rio49uJzDQ31MvS6mlggzYZ+mj/KC0Twm1QCcG8W+oLGeuREWjPuiXITee38KvORj5
	 Ic4bXlP+SfEkE3MQgwFOpK139eZdXU5S9uVmdIiNka2jty5LCFG8WzpTANbCaoKItf
	 R/KaWlgISOZJhTkR05TOnfbiNlraABrvxqdr2ypTx6pVw7zFcc0NHdSyRn0X3pyF6o
	 uwSv/3CQi/mtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 789A5D8C988;
	Thu, 21 Dec 2023 05:22:06 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvnbV3AxWeibhBaL7UtfZ7ko18-1SZg2LN0U0YNgvJ6Cg@mail.gmail.com>
References: <CAH2r5mvnbV3AxWeibhBaL7UtfZ7ko18-1SZg2LN0U0YNgvJ6Cg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvnbV3AxWeibhBaL7UtfZ7ko18-1SZg2LN0U0YNgvJ6Cg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc6-smb3-client-fixes
X-PR-Tracked-Commit-Id: 12d1e301bdfd1f2e2f371432dedef7cce8f01c4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eee7f5b48e20c585dc8069b3ab8abdcabd0afded
Message-Id: <170313612648.796.18134558177984902202.pr-tracker-bot@kernel.org>
Date: Thu, 21 Dec 2023 05:22:06 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Dec 2023 22:08:56 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc6-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eee7f5b48e20c585dc8069b3ab8abdcabd0afded

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

