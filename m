Return-Path: <linux-kernel+bounces-12865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48DC81FB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70167285D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEC10971;
	Thu, 28 Dec 2023 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpB9Hx0T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AD10947;
	Thu, 28 Dec 2023 21:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA8C6C433C8;
	Thu, 28 Dec 2023 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703798789;
	bh=UqvELVeXlXX4Lmsk18Ac7j8rmS8T0tWAFfszcXC+k8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FpB9Hx0TThUo9VtlCbZm6WzugQuyd1mt6zBYSbfK41yp9eqEhBh5fRL798NqG+tow
	 J0NH18mGstER2HPoN0Y3mlH6s+LAvoE4h03kZpHBSc4PuOdY7j7LlyQOZTozdMGle6
	 fRT4KhIHLc0C2HaQhu1+pNYVO8vfvG2MEbfv5N3zlyqXwmASbwTtzk22BE31Chf+Tp
	 +FKuctj5Nl44PwLUc1p4kjXhhEUq7sgdOijWCpbIdkBQLEZ9X1tACvjhXG5mlYnmPj
	 RFnjhyN2OpwHw/5xcZ0q+TO1e18WIn3PeZz4Js8nZW5HYBVc3V3I42UQethpXN8yYk
	 Zm7MQd8J7Mlgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D29ADC4314C;
	Thu, 28 Dec 2023 21:26:28 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.7-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASh0Y0qyi+vJGbNvvEnGW3-hH=QBf=aEpbtxE2N9JSodg@mail.gmail.com>
References: <CAK7LNASh0Y0qyi+vJGbNvvEnGW3-hH=QBf=aEpbtxE2N9JSodg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASh0Y0qyi+vJGbNvvEnGW3-hH=QBf=aEpbtxE2N9JSodg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.7-2
X-PR-Tracked-Commit-Id: 753547de0daecbdbd1af3618987ddade325d9aaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 505e701c0b2cfa9e34811020829759b7663a604c
Message-Id: <170379878885.15710.251699762534050732.pr-tracker-bot@kernel.org>
Date: Thu, 28 Dec 2023 21:26:28 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Dec 2023 01:46:54 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/505e701c0b2cfa9e34811020829759b7663a604c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

