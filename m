Return-Path: <linux-kernel+bounces-8605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40881BA12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A3289013
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3234F20E;
	Thu, 21 Dec 2023 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgsYL0TR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AC3608F;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78990C433C8;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703170823;
	bh=zSxKdeMV7i+o2DwR5Chw6s112MhrvoSfwPZaBaf4654=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgsYL0TRYEOHZZfRLjbpGiE8iqIMFzwj13wiHDOd/Q6kTpjOmWensDD8nADSeIPOj
	 X4xw/RmBvqlsHcJ3Efq8WVjFiZ2H+xe5C4e4DaZ0dZxvf2xCRy+Z8fEQnkzwi750p2
	 rFJsVo1BOTi1L1rAU63TRAKYft3xHRLAJ1t+Cuhd3mwh6u8FM1oz/7sgkpdJdP/uMp
	 bqugytxvVXzoSoZXavNpUlQ+qq8ErUCWAzrvaciJiDGaLeVIrLSYItlcjIdJPU3jJE
	 ONfmIFkcT9vcUcW6KwMII2SmkXFS37KEMcAWBIMozVXbxAFKGdtOOOdMxVNit9Fkqq
	 NJRl9Sc3sUsVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E9EEDD4EE5;
	Thu, 21 Dec 2023 15:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phy: at803x: remove extra space after cast
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170317082338.5769.2881350995739706971.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 15:00:23 +0000
References: <20231217232739.27065-1-ansuelsmth@gmail.com>
In-Reply-To: <20231217232739.27065-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Dec 2023 00:27:39 +0100 you wrote:
> Remove extra space after cast as reported by checkpatch to keep code
> clean.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: phy: at803x: remove extra space after cast
    https://git.kernel.org/netdev/net-next/c/fc9d7264ddc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



