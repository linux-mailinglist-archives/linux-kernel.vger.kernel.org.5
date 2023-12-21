Return-Path: <linux-kernel+bounces-9068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F981BFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24181C2482C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC8D76DA7;
	Thu, 21 Dec 2023 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVFyFFt+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6609768EF;
	Thu, 21 Dec 2023 21:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA4BC433C9;
	Thu, 21 Dec 2023 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703192443;
	bh=IdpDgbuY2oX7DYDsVvR4h18IvSFqZXv5OJGoLHv/qHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVFyFFt+v++xv902/wHmAtYQeLw50gvs+VxidLSA1LEuZ59W3fwvGoXA8MAo5Jtdj
	 UaBxLOQ0bjU2F7r1V+mvsbVSSygdI5x6pTnna6WJpKvl0REzSQZGGcIaeNpwrCuiHG
	 zSzdGFpT+ldkm+Ss/7TLd6/TCfi18TvW34u1KsITVTbS6OO1oPpvXVuDbIVm0rBwLQ
	 glB/ij/N6sa3PccXBm6kYTlOWp6SbeywEijmJnvA51FJijXkURs2bN8drTgdkPvJay
	 YL3qswgEc4mqRhOLfR2OEO1BqHfZP0ZX+dIMLWyunFsFzgMDK1ciSdw5rTZ0VkWT+0
	 W7nm2rLerZS0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14B01DD4EF0;
	Thu, 21 Dec 2023 21:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.7-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170319244307.10957.3551363919740430843.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 21:00:43 +0000
References: <20231221144131.366000-1-pabeni@redhat.com>
In-Reply-To: <20231221144131.366000-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 21 Dec 2023 15:41:31 +0100 you wrote:
> Hi Linus!
> 
> We are not aware of any standing regressions, and we do not
> plan to send a PR next week - unless very bad things happen.
> 
> Let me leverage this opportunity to wish you a merry winter
> holiday and happy new year!
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.7-rc7
    https://git.kernel.org/netdev/net/c/7c5e046bdcb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



