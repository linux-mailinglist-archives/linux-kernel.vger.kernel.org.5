Return-Path: <linux-kernel+bounces-25074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9882C731
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD622839F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68D18C20;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWi5CeOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154271865C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6798C4167D;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098028;
	bh=eZhGEF0KXxlD/g26+XohMWrk4RMuFxOtbItkn+HXzIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FWi5CeOvV9ZcW3ERfEv+24eipptBbUDfCohuXrybwV7Z9mJuhHMoDNh/Wv/66tb0a
	 DdJrRGhHr2jXSs4VuJ60wryURlpGVZDqZaXO6KahXrFRQ6MDlwdK6AVk8g6P0761D9
	 r4O1d2plyCGYD1i7VUxe6SPcCFId7DSO8zcWGApwJidPVNuMFBqbwcTTnc82R1RMek
	 cLDBGEF1wwlD35qKcudZbAtx6GkDmct5VVEOkpGQtfDsy704sAj34GckUWLB/lpSvr
	 3EeQNdRD9EUOZps8JhA2rcxO8fkKgd3kJIUHyZkDdtNwkkTLBcQaUUTVr0wV2E9vpS
	 MX2n0U7jy+fUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D191EDFC697;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110111331.GA138108@workstation.local>
References: <20240110111331.GA138108@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110111331.GA138108@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.8
X-PR-Tracked-Commit-Id: 986c20bb3e67d0171c0c2e4acd25429b1876b963
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 141d9c6e003b806d8faeddeec7053ee2691ea61a
Message-Id: <170509802885.4331.14530408177177721725.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:28 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 20:13:31 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/141d9c6e003b806d8faeddeec7053ee2691ea61a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

