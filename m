Return-Path: <linux-kernel+bounces-12899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6738281FC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB51F24453
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49B23B4;
	Fri, 29 Dec 2023 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3n42Ydb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31858ECC;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D347C433C8;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703813424;
	bh=CuxC7CZA7gtzWvpzzhw2JZBu4bfftIVE5DvWHWVoo0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3n42YdbwfG3KGmwo1zobTzP3CDCF/S4ePYEn6XMOe5WrHUPgM4KA/M7MiY5/zgbT
	 t5g4UlJENX6i4h7MBLLKJigKc2tEJ/l8tGV+gCriLtTvSjMIXw0kPTIzD3N6U+GoG2
	 qoW8Redb0clnpybR7F0gnaPWZL+Ay3kli5a85J1flLsS2pwGGm15O5YbSHJpH/Q/Lv
	 WUSIiH0dxbS/PDDei9ZWsk+iO/JeE5bRgIwMIsrbPN2BCMb13v9nzvkLglQXg134SC
	 k/gWtK6HfbbXNis4A9LuFYrDeSAoDrjpLuTivsWpRAKf16M6fjSygE5oAo0+HKFh7q
	 pJKUApMX4OQYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7296AE333D5;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: reformat kerneldoc for struct
 ethtool_link_settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170381342446.27815.13187495008608586418.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 01:30:24 +0000
References: <87zfy5g35h.fsf@meer.lwn.net>
In-Reply-To: <87zfy5g35h.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 16:53:46 -0700 you wrote:
> The kernel doc comments for struct ethtool_link_settings includes
> documentation for three fields that were never present there, leading to
> these docs-build warnings:
> 
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'supported' description in 'ethtool_link_settings'
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'advertising' description in 'ethtool_link_settings'
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'lp_advertising' description in 'ethtool_link_settings'
> 
> [...]

Here is the summary with links:
  - [net] ethtool: reformat kerneldoc for struct ethtool_link_settings
    https://git.kernel.org/netdev/net-next/c/d0c3891db2d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



