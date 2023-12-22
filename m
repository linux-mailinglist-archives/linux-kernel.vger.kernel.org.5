Return-Path: <linux-kernel+bounces-10068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92A81CF88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB21C229B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05502EAE4;
	Fri, 22 Dec 2023 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5m9HJVR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FA2E852
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 21:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53D7CC433C8;
	Fri, 22 Dec 2023 21:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703281676;
	bh=Nt1eoTAd6/tn02fj4nmURFKtpH46vsgHNIhoG1iij/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p5m9HJVRiAw285fDu5z0DPVjFxpXfAS/r8uOwenhaAj0VgKTOLgjLyJjGAvhdmjUb
	 7q2N2MeblqTnf+KWNSMJINh3CkRh+Yh/yM69ls5tIydGwHSDAI/yGyOZO9g+w48aoO
	 BSmeegNDuKHKddRJTpWVNERab7ZPBaTxzD+GqfeNgsgolUKCqPrbqXokaV+kkSWTQl
	 A8XVcR1M+vrCn8TCOOkJCSZ45bWvcdfqCf1feWbAqegALEG2VSQWMzNyCMdCDSpqG9
	 FdSPqT0EfUPPpRXvTfA3DrrYx1WHLXgzBAm7JM6wcrizttv+efJpSCM6cMaoEV2ty6
	 fRr+iHGYc04Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38722C41620;
	Fri, 22 Dec 2023 21:47:56 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYXku6xHecwqwIse@alley>
References: <ZYXku6xHecwqwIse@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYXku6xHecwqwIse@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.8
X-PR-Tracked-Commit-Id: 5c47251e8c4903111608ddcba2a77c0c425c247c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
Message-Id: <170328167621.24018.7022041020855443118.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 21:47:56 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 20:34:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0f65a7c112b3cfa691cead54bcf24d6cc2182b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

