Return-Path: <linux-kernel+bounces-5934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6938191AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A87D288607
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC03B1A4;
	Tue, 19 Dec 2023 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqaG3O7Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA23B194
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D628AC433C7;
	Tue, 19 Dec 2023 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703018517;
	bh=iotnUjYtZyLYgArVxQm0Z+V66MO5h1ZvenP5TFepfiE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iqaG3O7QZH1JLU7ure5zF29LCuzBW/ildcQLrpqH5GRIeD4cF+9AJq0NvN8QS/OKv
	 U74m2FF6Snfv9OwcQGENJhdW3YchxUpuhMZfSqftFPWMVfuhUwYmVRBCUUgIcOn6cn
	 E51d0tjL4XDrufUXsXv98Krkro+LwRrikuowqtNQi/X5pSRTpdjNtTvHKY/8fwzv1V
	 9Dj0fWwAuU7YVUmeeArUNZ3ivpsdyNOAzTXdnMd9IkadKe0XfopIoGXaDwrLuDSBCO
	 BwGidCd3o6zEYz9zrYQzfuqoZxABLbU21munkjvzuN6og4luk8+EWtqg03SwdkMc8v
	 yRAM/nBlmzjvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4396D8C988;
	Tue, 19 Dec 2023 20:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2312190056450.24250@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2312190056450.24250@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2312190056450.24250@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121901
X-PR-Tracked-Commit-Id: 6eb04ca8c52e3f8c8ea7102ade81d642eee87f4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f10e214a9de738832b357a58b605c2fbd23aa96
Message-Id: <170301851779.10204.16221903088968975945.pr-tracker-bot@kernel.org>
Date: Tue, 19 Dec 2023 20:41:57 +0000
To: Jiri Kosina <jkosina@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Dec 2023 01:02:53 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f10e214a9de738832b357a58b605c2fbd23aa96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

