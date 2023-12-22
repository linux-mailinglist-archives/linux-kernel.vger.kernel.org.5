Return-Path: <linux-kernel+bounces-9221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E114D81C27E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D730286435
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A730138A;
	Fri, 22 Dec 2023 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvt96xkE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5BEB8;
	Fri, 22 Dec 2023 00:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99DE6C433C8;
	Fri, 22 Dec 2023 00:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703206731;
	bh=q29WWQAJiVDYxm/YLzD5LdCR4yaDPUqzYThRAFt3JLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tvt96xkEltTpLfY1YFKDNsfPv2RDE+puhIEZu9KY/jEUyhWsIBIA999v85N5XwIWm
	 ZRgW28+HRwit4fg7CGl1KZyYZ+uLDE4zqmCs3ZKW3OufC1g4JVU1u/nre2IxHmE2dV
	 26t0/EPr3nlel0kZPAXKvU3oDdwNPfDvxkTFLOCxlD3iRtdH/IDyzUTeCf1XmQIaSE
	 TK7vIMWj+4t8FfFwjtHKmT+hsNm4BzEWgoimkC7Dzk8KzC4J6f3TApj12St5Io6HPB
	 VPwo18G9H93f2++aoCwLs2SeC7xnJKrcjspqlSzAJIqlFbviLA4GLNu/JI4QtJzA8d
	 OuJihMEezaiSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851EDD8C98B;
	Fri, 22 Dec 2023 00:58:51 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY=R+tyyFxQVuXJARqVDRXCi_A=JvYACWJ6L5JQa_8pHg@mail.gmail.com>
References: <CACRpkdY=R+tyyFxQVuXJARqVDRXCi_A=JvYACWJ6L5JQa_8pHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY=R+tyyFxQVuXJARqVDRXCi_A=JvYACWJ6L5JQa_8pHg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.7-4
X-PR-Tracked-Commit-Id: 14694179e561b5f2f7e56a0f590e2cb49a9cc7ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24e0d2e527a39f64caeb2e6be39ad5396fb2da5e
Message-Id: <170320673153.4959.14621736536219251148.pr-tracker-bot@kernel.org>
Date: Fri, 22 Dec 2023 00:58:51 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Dec 2023 23:50:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24e0d2e527a39f64caeb2e6be39ad5396fb2da5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

