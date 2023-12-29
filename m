Return-Path: <linux-kernel+bounces-12897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD881FC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB8285E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6220FC;
	Fri, 29 Dec 2023 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmXojT84"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8A137F;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8692AC433CA;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703813424;
	bh=4M08B1YUOoBNenHviDpHf6iucvEuYfpqF+yXHTMtB6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XmXojT84SKNFq1ZSXQV6gJZ81Guhh2b3wN4C0jrwbm+r376OPPDvyn4nEFkltr5c0
	 9ZtGHSDowKVgZkfyqKZarzPkRrrBhmKd+GYKkatx1fw0MY9QLs8MBVYOGvaPOI7U/K
	 auC66Wun7xyESIr73ARlfRx53GPlgzuo696l1GOop3TztO9HfoG+8XXTrFlshedKB5
	 QJXR9/HRy3N5H+B2ul4N8y2DGWtjYlwXS5yTw22LqRlnId25+698/1f55wWfxEKEFC
	 5C6lAEbtpP2yqTGcBdQv/YGrliBJMpUMKKsixcMe5FO8Hwc1yOZIn4GIws1d/wMCZg
	 qc/1tIl+LMWWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CB5EE333D8;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: reformat kerneldoc for struct ethtool_fec_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170381342444.27815.5111739346807500830.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 01:30:24 +0000
References: <87v88tg32k.fsf@meer.lwn.net>
In-Reply-To: <87v88tg32k.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 16:55:31 -0700 you wrote:
> The kerneldoc comment for struct ethtool_fec_stats attempts to describe the
> "total" and "lanes" fields of the ethtool_fec_stat substructure in a way
> leading to these warnings:
> 
>   ./include/linux/ethtool.h:424: warning: Excess struct member 'lane' description in 'ethtool_fec_stats'
>   ./include/linux/ethtool.h:424: warning: Excess struct member 'total' description in 'ethtool_fec_stats'
> 
> [...]

Here is the summary with links:
  - [net] ethtool: reformat kerneldoc for struct ethtool_fec_stats
    https://git.kernel.org/netdev/net-next/c/1271ca00aa7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



