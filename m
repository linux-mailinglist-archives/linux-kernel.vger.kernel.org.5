Return-Path: <linux-kernel+bounces-1570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D471981503E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129561C22E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D04185F;
	Fri, 15 Dec 2023 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1DXM5OA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503A41843
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 579C8C433C8;
	Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702669148;
	bh=Pmc34ctQsXa6VXl3dwQb65VAAPy1a/s7K9nk2683PJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V1DXM5OAvM/9gPoftNUkaWi8lxF6vthziPCXjmtEZBsdaVHNFnljNKwKi22wWZ3Md
	 OOyw1BUF4n2rMa0I/EkwAVB5Ge9cv+O1NfMnZHaTROq5vt7VwGJW79v8d8tCl0p4lZ
	 a95Ul4xt/sqDiqmZWiLL7NfkaMXiS/oSpKzUKtfv9e/3lEcvprJ+4wzYWB5xc97KcK
	 6z6N/u1tf8LTwHLNb+EpXIRZyEZmxS6ero0awkfig28BnNV/2O/Fbx0WxB5Mox+CVA
	 kvgdpqFe3I+xSkIHxthqWthTn97dNnln+/aRbXRE3gyjwMelUKV1wX1KeVjLehjxND
	 CUalVWTqese6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46802C4314C;
	Fri, 15 Dec 2023 19:39:08 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txCv2m6AKVoBPbAL4jpJL2aJy_T_vvH4Tj0rdtY004Hgw@mail.gmail.com>
References: <CAPM=9txCv2m6AKVoBPbAL4jpJL2aJy_T_vvH4Tj0rdtY004Hgw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txCv2m6AKVoBPbAL4jpJL2aJy_T_vvH4Tj0rdtY004Hgw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-15
X-PR-Tracked-Commit-Id: 7ba84cbf18c7a53107c64880d9c90f18fa68b481
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 595609b2ad023088dfd0ae74abb4602ea267e739
Message-Id: <170266914827.22768.3697492589292240317.pr-tracker-bot@kernel.org>
Date: Fri, 15 Dec 2023 19:39:08 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Dec 2023 16:42:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/595609b2ad023088dfd0ae74abb4602ea267e739

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

