Return-Path: <linux-kernel+bounces-13893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33F82144E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D681F21730
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA166ABF;
	Mon,  1 Jan 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acp1N/4y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92296123;
	Mon,  1 Jan 2024 16:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25C9EC433C9;
	Mon,  1 Jan 2024 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704125424;
	bh=ic+w3LPlgjH3sWSog/mFAUeMZjqxZrc7Qv7sWaA0DuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Acp1N/4ycD89S20jllMY/sy9qM7GxBdYBY0YOlHZFG6ne3LyATFYLRqlMKpRdvl3T
	 E/BLJDa9usF4x4y7QsMo6fbuoaUkkswl7uRfHU4TcfI8j2mEKvpOI++c1YIDQK9qLq
	 GepjyxaA+OQSeeYSedL6UuMKbHtFftQ/4PvpmPNev3m4tvlf+B207Z9RTOyvW9H7zu
	 1GJCuCEzbvCfEAnZ00aKEyVrO7aVMJoYuho0gL9DejI0gWWfCQ3vFX5uSfTb2amjSu
	 IBXQJdeemrXF49duH4OxrKYh1DlIagzGvTYaAVYXII1wWKDewaAPzFonPbhOTS9eO/
	 EZyN6ETV2kq7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 069B4C4314C;
	Mon,  1 Jan 2024 16:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: step down as TJA11XX C45 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170412542402.28310.1781055624628353422.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 16:10:24 +0000
References: <20231221154419.141374-1-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231221154419.141374-1-radu-nicolae.pirea@oss.nxp.com>
To: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrei.botila@oss.nxp.com, sebastian.tobuschat@oss.nxp.com,
 pirea.radu@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 17:44:19 +0200 you wrote:
> I am stepping down as TJA11XX C45 maintainer.
> Andrei Botila will take the responsibility to maintain and improve the
> support for TJA11XX C45 PHYs.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: step down as TJA11XX C45 maintainer
    https://git.kernel.org/netdev/net/c/82585d5e2af1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



