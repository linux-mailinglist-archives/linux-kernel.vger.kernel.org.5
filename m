Return-Path: <linux-kernel+bounces-10115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3481D068
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363CA1C226AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358CA35F0F;
	Fri, 22 Dec 2023 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnDwrvs7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15335EFD;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5532BC433CD;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703287231;
	bh=oI1RQYQCD9YiMYzDf3+5VQivEeECJlJPQdyNt0c+WQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FnDwrvs7wF6jLuJgCmzGKsG53ObkjwJJoVP0FPUCBEPgQ+XD7gE/m0kWxObuNeO7C
	 rpHGJS+o1dY43S9FhEVdJfJ9JhkpCW8u2tFkIr1g1rttHH7SoCU7PAVtpJJIDCekJn
	 QbBABHre1a/EmRozd51uQdeGZ1HqbKo0Q2xT38ypQDbV6TKu5D7DHAP2rM6ZpUvrz4
	 //qpdaa+qj+ni2UkaG0Xry5cw63ynmb2CKMNY9rJJiq27B47mrP9Av2Z1yPWs1VqCI
	 P9o4jre++3oEALOrHn83uW9q1c0ix9RMjcl8E3f97KZkCs3rRQAr+u9PZGoQO3rX25
	 ROoDOVIF8p7Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39434DD4EE5;
	Fri, 22 Dec 2023 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: skbuff: Remove some excess struct-member documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170328723122.4715.10503862336858743750.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 23:20:31 +0000
References: <87cyv3javh.fsf@meer.lwn.net>
In-Reply-To: <87cyv3javh.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 17:26:26 -0700 you wrote:
> Remove documentation for nonexistent structure members, addressing these
> warnings:
> 
>   ./include/linux/skbuff.h:1063: warning: Excess struct member 'sp' description in 'sk_buff'
>   ./include/linux/skbuff.h:1063: warning: Excess struct member 'nf_bridge' description in 'sk_buff'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> 
> [...]

Here is the summary with links:
  - net: skbuff: Remove some excess struct-member documentation
    https://git.kernel.org/netdev/net-next/c/dcc3e46472d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



