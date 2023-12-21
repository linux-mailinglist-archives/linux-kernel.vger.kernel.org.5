Return-Path: <linux-kernel+bounces-8908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05B681BE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3431F22E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E165190;
	Thu, 21 Dec 2023 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHaNzibM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1465186;
	Thu, 21 Dec 2023 18:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACB50C433C8;
	Thu, 21 Dec 2023 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703182802;
	bh=QHum0DRiz2hTXa5Ar01QzJVafvtafkiFnK1cP2ijRm0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BHaNzibMUkWt8X8Bi35CU7va984bVgrXYv3laECRVkfXUjLX4vP6Tvoqa1W5r2QEv
	 RDXIp8s5mEY8oZZ1l52BscZSxmMEnOwP/6CXe0yGrOz/cGp2/0m7Fet3z3xU4z9xF8
	 3kGJ9gXfcC4t0T3aHnvEnP11w8uBqbpScTkl3odztIWI2bDp+K4o75LuS4kE11cifF
	 yeHt0/nxE/KoA3GuMLPT7npt2b7+wK22dxNUaCBRf979z1ja2wztwGKiywXAX8mscx
	 1mphCgkgF5Umla4sNU1PnzJ5ovBJ8eYg1rwBNgu4nPZW1i7CS2GqNBo8hpKCO/Yau2
	 VG/+IvBva/0/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82F37DD4EE5;
	Thu, 21 Dec 2023 18:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231221144131.366000-1-pabeni@redhat.com>
References: <20231221144131.366000-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231221144131.366000-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc7
X-PR-Tracked-Commit-Id: 74769d810ead7e7af1a481f07a4d890861a6a4cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c5e046bdcb2513f9decb3765d8bf92d604279cf
Message-Id: <170318280250.26746.1338089847831863708.pr-tracker-bot@kernel.org>
Date: Thu, 21 Dec 2023 18:20:02 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Dec 2023 15:41:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c5e046bdcb2513f9decb3765d8bf92d604279cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

