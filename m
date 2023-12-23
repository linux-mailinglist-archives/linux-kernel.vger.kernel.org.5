Return-Path: <linux-kernel+bounces-10579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79881D675
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9251C216DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8B1D687;
	Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQFxI7qY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2018B19;
	Sat, 23 Dec 2023 20:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D212DC4339A;
	Sat, 23 Dec 2023 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703362871;
	bh=v5g7Uw4bnAyUSEWBuXk7FyJFivWi7vrQSVYW9EtMYXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mQFxI7qYiNZJecundwhlV0wxKiUn64M21iedNqSvsZAUAVRoAtWBbaeL2vUfiMi7/
	 oP4vZbjjhVSRR44itR+7D0vdO8UDMTLqZMIvnPAOqk9VCcn+5C8TncWgptqEa+vCrm
	 5g20CPD0OSoFD25so3ApGesO0UaCgLcnIQfr9lAcIGrC0v5oG6w+EW6EO3v8s4kCL0
	 rn7IEOzLC+vCgzDwvJ/g7vIvK+JtZEzJOiChVCa2N41xSMbTTWy9tZZ0Ot9QVC3zbs
	 AtrwKX9VZjepe6uMnJAyupFNge/ypPujuJlftXxmp+Zx0V3nLbgWoxqrOgpl8jSaou
	 k1OLjBbORgTTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C17F7DD4EE0;
	Sat, 23 Dec 2023 20:21:11 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <03b579bec43c7bcdeb4eed7ded859c92f4035461.camel@HansenPartnership.com>
References: <03b579bec43c7bcdeb4eed7ded859c92f4035461.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <03b579bec43c7bcdeb4eed7ded859c92f4035461.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 04c116e2bdfc3969f9819d2cebfdf678353c354c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f969c91482e1dedbb35aee4e7d32d13ed17f9e13
Message-Id: <170336287178.28590.8119563984557905407.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 20:21:11 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Dec 2023 13:16:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f969c91482e1dedbb35aee4e7d32d13ed17f9e13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

