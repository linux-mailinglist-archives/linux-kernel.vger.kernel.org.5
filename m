Return-Path: <linux-kernel+bounces-24602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B9E82BEFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BE6B214E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927606351D;
	Fri, 12 Jan 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfn7HiVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E96634F9;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB5CC433F1;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705057826;
	bh=LiBLajmA7uXC+66jfNQCT8GgUggwuGVXAxL/x96ZZNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dfn7HiVd32RIHN/nwnjIOKavUD1jDRAQRZl6RIpUteZB3RqVK/OUVtzFBahEg1fiu
	 4ZTVNH6G3z21e93R8iClQc6LXeMH2qPQxypE5NhFPiUwtzg4GSEATX6jH/4h9ncVuc
	 1+BXb7NaatgCIa5eB1M5T+C94FKnf1FkmKTNOK+qwkOA9ekE9yvDulAOe/k4YmHviZ
	 w5pWoCdpPgGMV4lc8OJQ6HvdaAu3wMJpDfkghf6eNUXlPcSQmaUNRKPlw3eQuDMIoh
	 zYg9RetHkBQl62wVIztVP95uqQdcZszAVrD/IzSsyIUpS5lBz0J9oxyyLHRjgJfdqY
	 nquy2fhkx5a0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51639DFC697;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170505782632.23132.18265133237882813457.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 11:10:26 +0000
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yuiko.oshino@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 10:52:42 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ/G3S SMARC Module has 2 KSZ9131 PHYs. In this setup, the KSZ9131 PHY
> is used with the ravb Ethernet driver. It has been discovered that when
> bringing the Ethernet interface down/up continuously, e.g., with the
> following sh script:
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: populate .soft_reset for KSZ9131
    https://git.kernel.org/netdev/net/c/e398822c4751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



