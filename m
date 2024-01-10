Return-Path: <linux-kernel+bounces-21583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DC82917D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361D01F26357
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23866323D;
	Wed, 10 Jan 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNWutOoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C038E;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A52BC433C7;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704847015;
	bh=9szu5Oxaq8IJwLJLG3qEd9SBXHTCCiVSVztgBe7mmPo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PNWutOoKYzaIZXzaihglUvr/ZiZqZDZrsNzqhCnHJxA1+FNQ3/CTJQbO2ptEcodNN
	 hUtdD2Zv14uTT/K53h/gUXjczdBpwWHMYZQ95UTF/bfCDe4ym3z9CKszrRBlXQ+jWW
	 w0BuzYDpCyf0YCYtPw15Fu5zhg8eaV2Csi2vupMkqXN+vTOIcHI1CvqL8ph9TtfTWO
	 DdJUbIYHBi/2uxc+jgwBb8uOunkJeuyP1h0JW2QpcVsWWEgXTz+gONxu1ZRLsQ+vFQ
	 33Fv9ZOSqtAsBnt6YHh80PQqWYdbrwzh+E0ylj11kBW6CMYEm0VBpVVJJWfU4gJD5v
	 /dusRiZ2G1+VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C0C2D8C96F;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gNn9e8mA1L-NoCRz7ipDE7J+pe37fc9nX-fn-rqjxDuQ@mail.gmail.com>
References: <CAJZ5v0gNn9e8mA1L-NoCRz7ipDE7J+pe37fc9nX-fn-rqjxDuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gNn9e8mA1L-NoCRz7ipDE7J+pe37fc9nX-fn-rqjxDuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc1
X-PR-Tracked-Commit-Id: 17e8b76491b007698cf63bc10093bc8991e45001
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f73ba68cf67ef533783013f863d750c5736f957
Message-Id: <170484701511.9066.5302007953807181602.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 00:36:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 16:01:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f73ba68cf67ef533783013f863d750c5736f957

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

