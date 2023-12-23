Return-Path: <linux-kernel+bounces-10580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C782D81D676
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F161F21B15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108A21359;
	Sat, 23 Dec 2023 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma08Lx6F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D76208C4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD2AC433CA;
	Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703362873;
	bh=2CsjO+HeEKCgLhFVpdZyLLp6b7JYuTkBeQvg90H5qqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ma08Lx6FwJ4489L9GxTAMYfuq+gy2jgnaR8GpqlMF7EdF36U/pNWHjGO82dyOhuLX
	 /NPm3h9GlyNccaS0UGrIvSONzCzfEUy8Tj8yFdzayUAThbnbPpR/JAjhPySizBzXKI
	 WixDcoQVnym4DDnJtJxb5XbKcelMecjlcJV4C6kDQT4+sVsiKaX0jN+8o07akN9sju
	 mTmLqwgksl/51HS3wH3LxCwKH2sPh618H/wTz2ql5rRUFWC16wCVzht6YHMMRBBuhv
	 kbOs0V/Dypx4hbY8H3llzLQCWiNgNi7TdboPyIcTZGl3ro4ywx4wmPqqI84auDH/M/
	 /nfNL4fMJQjug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8763EC561EE;
	Sat, 23 Dec 2023 20:21:13 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYaqCSpr15clmOb9@kroah.com>
References: <ZYaqCSpr15clmOb9@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYaqCSpr15clmOb9@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc7
X-PR-Tracked-Commit-Id: 159f5bdadcdda638aad5a234b58d6031aa4ef8aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0652eb205b7ac13429d63bcc42806115d393632
Message-Id: <170336287355.28590.1104572130019480732.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 20:21:13 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Dec 2023 10:36:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0652eb205b7ac13429d63bcc42806115d393632

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

