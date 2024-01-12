Return-Path: <linux-kernel+bounces-25100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A982C7F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2CC1F235E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EFD1A5B0;
	Fri, 12 Jan 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2zxNfPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFB1A5A8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA1A8C433F1;
	Fri, 12 Jan 2024 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101943;
	bh=n3KcV8+kw+NwcvYTXU/7UAiV3P6lJboLXx4LNJ7gXL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K2zxNfPIbjKLKkOzhdP3tp4AmgRavF5DxLFqtKt8NfFG6dnz5O4c4n0SMm0mH6P/F
	 tmuuceoB0O/uIAcQBjCOcuP4+ed8W7A9xWefAG9LrcmCls4wvNZmuNos+X2NsytbvX
	 z+x5xsNNlYfHffxdFa7avP9Vq/6irmMO1vWofzX+lVd7wypbdSTBzZp3zSLtMVoaEr
	 TgmmIochrphG+HRa1OmCSqg9V7U7asJrTuAuGNPmkI70/14lqSx/lLpUYYMW8O707h
	 05TRgzEZS/SJ+hmg8wujPYS5pdghIXD2QgOg75z8u4rF5nFL4oGzm0vXs+XEnC/jy5
	 1LRFEkMhagoBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 994D7DFC697;
	Fri, 12 Jan 2024 23:25:43 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2401082125270.29548@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2401082125270.29548@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2401082125270.29548@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024010801
X-PR-Tracked-Commit-Id: 0b43615af19742e1f4f71d332e72381430804804
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fef018d8199661962b5fc0f0d1501caa54b2b533
Message-Id: <170510194362.16457.4574288566714520029.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 23:25:43 +0000
To: Jiri Kosina <jkosina@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 21:31:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024010801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fef018d8199661962b5fc0f0d1501caa54b2b533

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

