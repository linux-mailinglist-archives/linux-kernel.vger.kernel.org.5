Return-Path: <linux-kernel+bounces-16063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C568237A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85989283CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6200D1DDE4;
	Wed,  3 Jan 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaQQSsOC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9871DA54;
	Wed,  3 Jan 2024 22:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85CDAC433C7;
	Wed,  3 Jan 2024 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320343;
	bh=bXkWNzbnOOxCFFVBLyN62DVYmtj5/+d1InjQMeGJ1xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aaQQSsOC1Om+K6MJXEX9ik0s+rpmnP4VKCWGIgPqZtB99HxXl4opbLEtO7ZK02t12
	 czQCh+PMObRViT2d0zcozV3RKopT0sBIeRmNGAWtyP9l8KkqdREl0sWCr7T6AdV6ht
	 8L9pPvOD0CSFerYFLctTo/1tO6PX3ozxEVpOvejaebMqZClFURDRpBZCXnZB1/w67a
	 oBrAlQerPJvhf989v9VULnw7FGhsTVf/XY+8xH8eg1CyC3DzrAch7XjZpAWjwBKBqU
	 wxDnwYq41389nQ6i1vfvffSsSPxZ0v6BC1Hi8rDtuEboEYiMvpYHnJzwlA7gh/nYq4
	 AkT+umgHoHVcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 738C2C395C5;
	Wed,  3 Jan 2024 22:19:03 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor: Final fix for v6.7-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <94b09a9a-4e2d-43d4-9230-f72662817086@canonical.com>
References: <94b09a9a-4e2d-43d4-9230-f72662817086@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <94b09a9a-4e2d-43d4-9230-f72662817086@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-01-03
X-PR-Tracked-Commit-Id: 8026e40608b4d552216d2a818ca7080a4264bb44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7807d8544e56af9b5523f15eddac09ec0291b4e
Message-Id: <170432034346.19489.3328006084247602960.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jan 2024 22:19:03 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Jan 2024 12:26:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-01-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7807d8544e56af9b5523f15eddac09ec0291b4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

