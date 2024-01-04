Return-Path: <linux-kernel+bounces-16169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F5823A09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B14A285CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AD14F6E;
	Thu,  4 Jan 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6qEzQDv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACE5231;
	Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5F73C4339A;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=v7u+3Ek37XY/+JjQ40uSQDPOKui8j3u3nGdqB+sIDcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6qEzQDvypSqRGK57QgPR03z7mC9glF6wOoJj8k/cATFPof2MRcZ0lEBAjVLz/RTZ
	 9X0wAirDB2mnbhDYI+oHtc5crSxWVOgYscv32jHSujpocpmWT334FCWe6mvNh9tlyu
	 n/ABresxdTL74n7De3HDTWuqJjJjbc1T08qXpKXEKv7M9ILurkEHCveG+/2GGrJ5n/
	 nZ9UcyyxXeFeeKeDiSzhLJa4iRbWrjS9a/U55M8Q8QT7XGKbY8lNXgBwWsaLKsY5x4
	 /kQQCOOAAWYbNxx6gWKlSphIW0nN8JuEIakK8Gnsyapb5ILH0UFi8gHfCf/bISXH/O
	 TSTSvwCgTrD1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4597DCB6D8;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next: PATCH] net: mvpp2: initialize port fwnode pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003586.5757.15826261338546999413.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:35 +0000
References: <20231231122019.123344-1-marcin.s.wojtas@gmail.com>
In-Reply-To: <20231231122019.123344-1-marcin.s.wojtas@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Dec 2023 12:20:19 +0000 you wrote:
> Update the port's device structure also with its fwnode pointer
> with a recommended device_set_node() helper routine.
> 
> Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next:] net: mvpp2: initialize port fwnode pointer
    https://git.kernel.org/netdev/net-next/c/5fe65375e3d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



