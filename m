Return-Path: <linux-kernel+bounces-16549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814482400D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCBC28634A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5493210FE;
	Thu,  4 Jan 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yoo6lv3Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31920DFD;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98630C433C9;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704366025;
	bh=nxpiW+Iut7PZJppF0TdL+N+Fy+2MpSFFur0QGg1Rwb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yoo6lv3Z7pRHyFv5LA/AeFX6kVlpok1EBRzKzqPSU1TajgW39eAnq5i1fZ7+7+7VA
	 dykjWRqO0CzkjpEFa4CxkVcXjsxjAHrJ02E2p67dyJ57Iy0dy+B+iwZD3RowtLKcgX
	 BARSGpePl/N1BnU7iupnqS7pwrohGFtrcg26ZwUcVPcBrtWMPzGXazZdtKKYjKFD5d
	 8lO9TTWDsJncrHMozYTkuckd8xKMPf6U12ampaIJvxJNuTWrgQm70k8SvfD6Y7zSyC
	 YDTfiXoUvnctBQoX46OxcNllKm4jSn4kY8RfQd1w7FT8jTLvEXLjz5x6RH6897sFyc
	 m4knutBHGascQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75CD8C43168;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] net: ravb: fixes for the ravb driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436602547.13188.10092365658612268142.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:00:25 +0000
References: <20240103081353.4165445-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240103081353.4165445-1-claudiu.beznea.uj@bp.renesas.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mitsuhiro.kimura.kc@renesas.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jan 2024 10:13:52 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds one fix for the ravb driver to wait for the operating
> mode to be applied by hardware before proceeding.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] net: ravb: Wait for operating mode to be applied
    https://git.kernel.org/netdev/net/c/9039cd4c6163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



