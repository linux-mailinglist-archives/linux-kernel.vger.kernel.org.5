Return-Path: <linux-kernel+bounces-14995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559F8225E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEF1F23553
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F134A34;
	Wed,  3 Jan 2024 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neeRo+i9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8B362;
	Wed,  3 Jan 2024 00:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DFECC433C7;
	Wed,  3 Jan 2024 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241225;
	bh=aIsUKu+yZamorxjmUFGFEBphcUe2Y1eu5rvXAC2OpdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=neeRo+i9afojXM/3NNCreF09CMJUgvSboqVXmMEpDXpLe6HPSXvkyWoICwBgVHJYk
	 Fhwz56u5pUh6ff1kn/WJCFtSpkSKaNtDS6SVImyYRBqcmvjgRAH2Gaa89l6oPLVGR0
	 B2/tCk4ZrmWgo+mvbH5TRVOwWcC3mAy9CKmROqG1oyO1jOSzTe8WzdnlNAEu41Z/n1
	 OAAiw5U2MUsOpnj+1kWXZ1ZPgtcNvUkcYrhzhjrK2GCIwc99LesHRngsKdfZA9KdFt
	 m7BRMUlujdbn3LVHNv55RW5ceRPqk3bbsLn3nf1/2o744GyRO1p21H0gYiS77SvnjY
	 jXlBx5Az16kxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E74C7C395C5;
	Wed,  3 Jan 2024 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update mvpp2 driver email
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424122494.12524.6893620259777477458.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:20:24 +0000
References: <20231225225245.1606-1-marcin.s.wojtas@gmail.com>
In-Reply-To: <20231225225245.1606-1-marcin.s.wojtas@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Dec 2023 23:52:45 +0100 you wrote:
> I no longer use mw@semihalf.com email. Update
> mvpp2 driver entry with my alternative address.
> 
> Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: Update mvpp2 driver email
    https://git.kernel.org/netdev/net/c/fe6d8300a7af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



