Return-Path: <linux-kernel+bounces-24118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE882B758
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AA31F2546D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB1C58AD6;
	Thu, 11 Jan 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrZLT37l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7B5427A;
	Thu, 11 Jan 2024 22:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43AD3C433F1;
	Thu, 11 Jan 2024 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705013878;
	bh=H7x7aO2J1+r7GnkJCYack1M5emNiJYwQG4urpX/5Vx8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CrZLT37liQ90tILP5tGj9L/gadqWQxXWU6+bGXGgpLmZ+u8GYhq5d9SM14HDBjyUD
	 IMlyWRm+YxXyvAqqwVxEPSWe16KZ55uTXnUNcKAQEvbSxhLz35pVcVnbFAnE1NR2oF
	 PDbeIjj+VzHAUFqxy6XeKc3LcLXzBOJU7Po/w3W7p8wQVyfI8ml0gAhkYI1JrdRCR8
	 1EjtMUg6u2u8Vp6vJb7qakWUfi+B+9wtaddr/HaOKJEwaySzc5+qqWofkvdsQyczjX
	 62XwClTo7QuFjQXJsfhaIs0t4F4pPYbGsnK+Ib45a1AtNZiSDzuRXpws5key9CYZaI
	 OVZcECv1t8xTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31EFDD8C96C;
	Thu, 11 Jan 2024 22:57:58 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 45a2c87f28ad0ee8c286bb6dd5686bc54f5b7160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22d29f1112c85c1ad519a8c0403f7f7289cf060c
Message-Id: <170501387820.24643.1028378102454088188.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 22:57:58 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 15:48:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22d29f1112c85c1ad519a8c0403f7f7289cf060c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

