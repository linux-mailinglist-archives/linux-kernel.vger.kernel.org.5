Return-Path: <linux-kernel+bounces-13217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F8820141
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F1B22A26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089213AE6;
	Fri, 29 Dec 2023 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKcqZM5J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20B13ADD;
	Fri, 29 Dec 2023 20:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68502C433C7;
	Fri, 29 Dec 2023 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703880028;
	bh=iO4RdDaUd7xJNJMV1+K9uFRRbofdgM1xlaf5Trqn17s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oKcqZM5JYqvpnTs445IFefgVExRyEWiLtfWg3VlNoJKdVzfrE5bXzrVTA2VBzOZDh
	 L22gy/mPJKQI8uBGkgLznUqLKGjGY/zRsVs5WVQmQmx5/NM+8eJCGem2RttTYdapTE
	 US7vR9XcXTnKDu9O48vYqxcDhDvLeeffyzHD4LN+toY9/sUfRrxZWr/srghRRI41NG
	 RISCF5lpphhufX55V/lyrILfUQ3Mww3v3SkdOvah294/Il3NHzGiNgP87MByS4Mn0I
	 B1okpw/mO3byIW0QfknmDHFD8UpQntZ/8zg9oFWfywnO2+X3zYmpfqKlN2PjBD4kCn
	 x2oi0rEzOEeQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49CCFE333D4;
	Fri, 29 Dec 2023 20:00:28 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-6
From: pr-tracker-bot@kernel.org
In-Reply-To: <99b3747b381376d301fbddef905ae10a.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
References: <99b3747b381376d301fbddef905ae10a.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <99b3747b381376d301fbddef905ae10a.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-6
X-PR-Tracked-Commit-Id: 70681aa0746ae61d7668b9f651221fad5e30c71e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e543d0b5ecf28f69b5fca94ea770b802c32d884f
Message-Id: <170388002828.30633.11548431351431848812.pr-tracker-bot@kernel.org>
Date: Fri, 29 Dec 2023 20:00:28 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Dec 2023 18:06:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e543d0b5ecf28f69b5fca94ea770b802c32d884f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

