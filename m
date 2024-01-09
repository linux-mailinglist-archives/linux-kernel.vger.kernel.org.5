Return-Path: <linux-kernel+bounces-20276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FF827CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638541F243C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1A8C0C;
	Tue,  9 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfjTHptz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837A4418
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1992CC433F1;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704766264;
	bh=/CJFfSaxTpIDVHt2n7CD9Olfe2EXcFOh3gmR+oJRQ1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RfjTHptzGHl2MPYDiSGvV8BLv2f22E25j78kcqifz1F9D6b51FUDVAAEUCoFHA4IW
	 gRW3Es5ZMW2PVzprniB87D5SvjrchppjwC6o6D7L+nc04J3MU9OH48dPo3Ao+Gv/A4
	 IPl3ip/W6kkOIVke9zI5OiF/dz/y0UNsyxH1PoDkzHcHf2EjDDNJxpGz1M69TGXBFe
	 tIrubUL9Y4R2/TFW+XoKW62rvXhxa0A5o9LiAGepWddpkfYuC/JzPWMsEC8+Z1ve0S
	 j4rCCdXl7YwVJy4DICcaGKkkFPhqUgR86fqFbjIwq1MgoRb3QCP+aOLUVyQeWXwVCO
	 9MhEW6aGmMMBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06F28DFC688;
	Tue,  9 Jan 2024 02:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZvTnQPx2C1NcFd7@gmail.com>
References: <ZZvTnQPx2C1NcFd7@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZvTnQPx2C1NcFd7@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-01-08
X-PR-Tracked-Commit-Id: 5e1c8a47fc6ec6251ddd126f4245279fc072f1c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33034c4f9497b7fe33b0d97740a4bf1c0552316b
Message-Id: <170476626402.5897.4858620734796329222.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 02:11:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 11:51:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33034c4f9497b7fe33b0d97740a4bf1c0552316b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

