Return-Path: <linux-kernel+bounces-24035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F4E82B5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136971F2472D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFA57879;
	Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGlOQueA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9456B9A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0249C43390;
	Thu, 11 Jan 2024 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705004419;
	bh=1cm2o8/PhmD8VtB0xZXW7iKYJnwYwlN7Q0IbMHqLfkY=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=QGlOQueAasTBfJzSOkt9uMQaDGJpz3GepTkzgq/pjuuPcZzNo0ZbWU2DYrtNW6b80
	 UcwQvEmE4+1xH5rfSEqUAHQTtJiLxubkQ2g2dn69j1xk+e8Ku4Epi3SwQADvibf8PA
	 aCzymg94Sc6bzTbrgY5w4rXL/8U02r/hPcjmkCy3GJ6uWYI37GcemO3CYJc68OhKB3
	 w2vdviPifhZxDGp55A7Jorp+D9R+zKi//IUeCrIoW0qEPxjwn0kQX8WAqjsrxJ4u9x
	 C383wD5NK9Zze6pKIxckQq+SEcKDPYRVlmI6CSyFDQHpTHbf+aatoFk9+UkfYUVu5k
	 ET1aaBJ/U3Guw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D996FD8C972;
	Thu, 11 Jan 2024 20:20:18 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] SoC: DT changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <b1923a64-b5e6-4dac-988e-ea2a75e948d9@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com> <b1923a64-b5e6-4dac-988e-ea2a75e948d9@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <b1923a64-b5e6-4dac-988e-ea2a75e948d9@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.8
X-PR-Tracked-Commit-Id: 18a1ee9d716d355361da2765f87dbbadcdea03bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4101e55974cc7d835fbd2d8e01553a3f61e9e75
Message-Id: <170500441886.14602.3852928766111569702.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 20:20:18 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 17:16:28 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4101e55974cc7d835fbd2d8e01553a3f61e9e75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

