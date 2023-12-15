Return-Path: <linux-kernel+bounces-440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4E814128
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C12A2842D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E563B2;
	Fri, 15 Dec 2023 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJDB2v0T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C263A6;
	Fri, 15 Dec 2023 05:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC75DC433C7;
	Fri, 15 Dec 2023 05:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702616996;
	bh=5hUT+t9OHVagn2yUG490mCLFamAlFafx6YXLqMWajFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lJDB2v0TzNGBq+jMwvRC5wF3J20gV+HrJ9Iewcd+b9k9ZAnWdKJiot871M73JHsKF
	 /g0RtIPiwLDNujWoet45Wm3na+Zhmoa68rFEdM4NZAOr+jp4nWUE8D9y4NgsuM41hl
	 01na55Qw41DFCBs8tGbi/Jh/Fn4sXCEuMpI8yJUG/2Y+yJ+YiMu1NjN/walb6Ff5sS
	 Q/fypt5jkJA2iS5vauOmo3tGU/spS7CrLV+lQrDfvKUDdjy/BdcKxBL8p25Jd7C9AO
	 treLvmtMzlwFsZEJynjHjstOQeFhuzJKOVcOMkmu1GEwsbWWaoL2SJ0fXMM7Bk21UM
	 TApZ/3Up0arBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B48EC4314C;
	Fri, 15 Dec 2023 05:09:56 +0000 (UTC)
Subject: Re: [GIT PULL] four smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msvjVFMG24ffSg+N9nmYDy+fBBaba_wMCc-=4V=4m5PyQ@mail.gmail.com>
References: <CAH2r5msvjVFMG24ffSg+N9nmYDy+fBBaba_wMCc-=4V=4m5PyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msvjVFMG24ffSg+N9nmYDy+fBBaba_wMCc-=4V=4m5PyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc5-smb3-client-fixes
X-PR-Tracked-Commit-Id: 3a42709fa909e22b0be4bb1e2795aa04ada732a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f7168591ebf7bbdb91797d02b1afaf00a4289b1
Message-Id: <170261699662.9968.9988269347386430359.pr-tracker-bot@kernel.org>
Date: Fri, 15 Dec 2023 05:09:56 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paulo Alcantara <pc@manguebit.com>, Robert Morris <rtm@csail.mit.edu>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Dec 2023 19:35:59 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc5-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f7168591ebf7bbdb91797d02b1afaf00a4289b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

