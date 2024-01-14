Return-Path: <linux-kernel+bounces-25468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8382D0BE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6971F217C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0B23C5;
	Sun, 14 Jan 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsRfdqbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E42100;
	Sun, 14 Jan 2024 13:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC8EC433F1;
	Sun, 14 Jan 2024 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705238423;
	bh=YybB2Vm5vhA59PCX9egPSHYi3oRPN8siKFnrMKOrxsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CsRfdqbg8CbxfWKMm6xhXdf3lcV4LeWTtIaswyH/iwt1mzyPuzP5ayKQMi8yB8Jcd
	 LlnHg1ZtppmGEmc+J7K7zwYZPk1+2SFn2YYv4VyIKpi3jG7Yav+n6vLb1AhKSFS45B
	 7FVrejQ58/OTBv6WvSyk+umT7hUphzmu6b/HZl/rfeu2/ShQoFW2QoAMEybJA6tXHU
	 3AVFl/VKoufbVbdC/UMlqi1B6pw/CR6WxYHgaOuqwaZjtXAVN9ZWjDr1nk+7eoB3ob
	 moPknUfkpiz5/yO0jcYfvVDgBMlmxX7POxAl6tjjIy00fqNl7HCuCMTj8C2cmg4fCZ
	 zzKLpD7k1gtUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71C0FD8C96D;
	Sun, 14 Jan 2024 13:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net: PATCH] MAINTAINERS: eth: mvneta: update entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170523842346.10285.10833413139196399042.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jan 2024 13:20:23 +0000
References: <20240112140628.62314-1-marcin.s.wojtas@gmail.com>
In-Reply-To: <20240112140628.62314-1-marcin.s.wojtas@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 14:06:28 +0000 you wrote:
> Add myself as driver maintainer and restore the maintained status.
> While at it, update the file field to cover mvneta_bm part of the driver.
> 
> Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net:] MAINTAINERS: eth: mvneta: update entry
    https://git.kernel.org/netdev/net/c/c061be1bd5e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



