Return-Path: <linux-kernel+bounces-21584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3682917E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05699288537
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18733D6;
	Wed, 10 Jan 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KowZn0pe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76595391;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48106C43394;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704847015;
	bh=8pxDYOgPRsJ7zTCTUOME9aXxtrzhwmlPtklpQwWbp98=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KowZn0pebs2WsSB8pl/ttZ0ntwOYb/gl3drPzTvIS90KjQoHuPiwhbenr/VhdC8A6
	 G5xuUQolM8SiFIeaiFlq/bx1z+A99gpYTt4w9o+ULvbIKfB+QVpnQ0gnSvcsA/PzF9
	 UHYgW7dZi4Bi00J5dsLVQB5RuoRM/HJjXMWVgXOONW0ruEjE5Pgs7n/xHlSjxLfSE4
	 l6odhLZxZXBBlQ606Av5uZ/Ywjs3cENn2xzmb2+nL083/al9WjH/my3T/3Npi/+5xN
	 GaardlndFwcYCKz3wepL8oG6nuR7YvELqUAClr4X5VptPFUozjRL3lIHBsgovsknbR
	 K0zFUm1ZO2b2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F60AC4166F;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h91BzSHFd9XnV-yq72WNiJBcYTqtKnZWTgkuzGhVvvRw@mail.gmail.com>
References: <CAJZ5v0h91BzSHFd9XnV-yq72WNiJBcYTqtKnZWTgkuzGhVvvRw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h91BzSHFd9XnV-yq72WNiJBcYTqtKnZWTgkuzGhVvvRw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc1
X-PR-Tracked-Commit-Id: f1e5e4639781724d05d90309900321baaecfde74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7da71072e1d6967c0482abcbb5991ffb5953fdf2
Message-Id: <170484701519.9066.14202488413829853021.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 00:36:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 16:02:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7da71072e1d6967c0482abcbb5991ffb5953fdf2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

