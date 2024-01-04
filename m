Return-Path: <linux-kernel+bounces-17129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25E8248B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918CCB233FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25E2C692;
	Thu,  4 Jan 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1upHSDF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE272C19A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25311C433C9;
	Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395412;
	bh=OFT0cYdQcfcAjLV7qTEtGLasNg7g19VpAt4z0BUMlXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k1upHSDFyOkpqixG78GgFMIvKlrYI2xfghY8EnDyEZhrwBjSBy47fyP8jDVycGLGx
	 m+B/+Ltbt4hMfEUMCvPhGdmmX4n/ZeggZnlqYtlev+W8e+wwej9Y9uvkUnWrCHCSWW
	 9JY9yhpAM150JqGXYNMQzDbr/zaiN72Os6jl1Zj5O2WF5TSZa3bFcIwN3KwynoKeA2
	 SRb5JtEDAg/XbLO6sdxoDGGBnNgIJW7x0QlhT2CN4XKy1ZzyNMTaO62o+i6fvOIzjU
	 cqp+1Otejdds+vG4BQLDBDFUZA4x+DJl7GTqGjU7zYUb+gN8MdcQ9j2IqTg1CuYJBN
	 livTetexZE07Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E26C43168;
	Thu,  4 Jan 2024 19:10:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
References: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-04
X-PR-Tracked-Commit-Id: faa21f4c20960fee268bdb0fe977ed0edb6685fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5939a693dc6e6d6f293681017c70ff60c3723d43
Message-Id: <170439541204.3148.17028465187686419462.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jan 2024 19:10:12 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Jan 2024 12:29:55 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5939a693dc6e6d6f293681017c70ff60c3723d43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

