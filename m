Return-Path: <linux-kernel+bounces-7699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C253A81ABBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202A0B25729
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E171C0F;
	Thu, 21 Dec 2023 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Sdo3qa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685E1FA0;
	Thu, 21 Dec 2023 00:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE7AC433C8;
	Thu, 21 Dec 2023 00:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703118316;
	bh=ncbofAzRvDw94woQGwkqjgBNi+bXSPsNjIqYtrBxqqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W+Sdo3qaaqdDDMm3LrS7ghuXtT18SCFwoS9wB2fZkUI65qpC8Z+a/u9kT/a/XgHU8
	 naOybd06AXMUFw9775It1r3QtDMcJKQNP+EdDWVlSRaZQMTQcRDKboGNek+soeWVg+
	 a/xor9WXShRkNC0ShFukZeagdvTQURKGZhjUANdmYa/2iIm9hdIDMUsc+OHUK5WSH7
	 pQBxodAVNvyqezD/VfPEb55Phv8xVBJ8zU3/eSfsel0jEpegsvAa3oZxI93DdwjVA3
	 nasHnbwBo6/EcneMaLiO6IZPBh2yPCRYQ0+Zxo5ol4+ArFMs0xvrqEFO7fBWSodjYU
	 37wxD5BZz+l5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1891BC561EE;
	Thu, 21 Dec 2023 00:25:16 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYMP6OClkOMkey9l@tuxmaker.boeblingen.de.ibm.com>
References: <ZYMP6OClkOMkey9l@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYMP6OClkOMkey9l@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-4
X-PR-Tracked-Commit-Id: 3d940bb1818325142e6764bff788cbf95b9afb54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bf5c8925609425fe0ff7270fe8fb14246c01694
Message-Id: <170311831609.17908.136507635514667718.pr-tracker-bot@kernel.org>
Date: Thu, 21 Dec 2023 00:25:16 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Dec 2023 17:01:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bf5c8925609425fe0ff7270fe8fb14246c01694

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

