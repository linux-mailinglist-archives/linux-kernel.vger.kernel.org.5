Return-Path: <linux-kernel+bounces-18354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FD825BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1451C2373D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EF364A2;
	Fri,  5 Jan 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB8dSJdD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78D360BC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C86E2C433C8;
	Fri,  5 Jan 2024 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704487658;
	bh=ELTvh5cZx7niUHAIZtF1h4VTcQkwcTo3rsbrOdwaEvI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZB8dSJdDHj/0rsDPEoXRWVPOtNlCb0S3qzyLiILS6dE4chLhdro+B/TxClGueOWnc
	 HZtDuHDs7r8bPNAeU1iaGQMRb8xjx42uazHwLJPEHCNqaQLZAwoWe1pvbrfDJYEtmi
	 9YlcWEHl7QWeocxY8kE7izhViACfdxs3GNZr9IeCYwDBBkZ+N1Y+n4NY8Kwu7N9kfM
	 AFyfsD1LKlzpE+kzpr2QErQm7BXBIdYs7j193lLYUGUUQUPjiptAopptMqK2O1xHnp
	 BswXqbpwI8qKOHEh0Q+cX85Q2d2N6487aSqq9vVRcoBPyvV1g69SOLrPythlSs9HO1
	 aJuTbounuNH1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4AD0C4167E;
	Fri,  5 Jan 2024 20:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.7-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105150612.GA15407@workstation.local>
References: <20240105150612.GA15407@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105150612.GA15407@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-final
X-PR-Tracked-Commit-Id: ac9184fbb8478dab4a0724b279f94956b69be827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ab2706bb1280693e7dff1c5c42a8cb9d70c177
Message-Id: <170448765873.28812.4699031223901783444.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 20:47:38 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jan 2024 00:06:12 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ab2706bb1280693e7dff1c5c42a8cb9d70c177

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

