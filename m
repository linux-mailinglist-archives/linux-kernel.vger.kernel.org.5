Return-Path: <linux-kernel+bounces-785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94A48145FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0E285951
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43024A19;
	Fri, 15 Dec 2023 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1J4mz7r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2F200AD;
	Fri, 15 Dec 2023 10:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DA32C433D9;
	Fri, 15 Dec 2023 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702637425;
	bh=96rdUXos92UdNTF38+uJWWiSZ6vZQrwky+dUjC3SsK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1J4mz7rStFU7HooAvqwfjJoaotqM0sV7pDk8siuNohJS/HasMLdQdEfU5H7nt4Fj
	 JUgaDTd6noEfZT0pOxw0gWD4Le18ECw/bA5Y6N0MQmWOPp5DPBvTzpXYVBtZVzd8i7
	 yLBn6lWvKMCHp2LqpOKUmpNpUiGxNnkb/mAPoDLVrw+/7GP3+QKVA6pnzghQrXIvdr
	 MsAjcvyTslnYI4phVsW7foyUeuMElSbnUAM5NizeQlut16WCUAKbTj89P62mBT0wnr
	 L1Iajfy0pXWF0Dh/n5rlsjltjt5dg/KMRlHKhhKkE3id62qKGeuWQTW+Mbckc/SjRy
	 JYvhJanqidqSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A80FC4314C;
	Fri, 15 Dec 2023 10:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/2] net: phy: at803x: additional cleanup for qca808x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263742503.9428.5612921496608996554.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:50:25 +0000
References: <20231214004432.16702-1-ansuelsmth@gmail.com>
In-Reply-To: <20231214004432.16702-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 01:44:30 +0100 you wrote:
> This small series is a preparation for the big code split. While the
> qca808x code is waiting to be reviwed and merged, we can further cleanup
> and generalize shared functions between at803x and qca808x.
> 
> With these last 2 patch everything is ready to move the driver to a
> dedicated directory and split the code by creating a library module
> for the few shared functions between the 2 driver.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: at803x: move specific qca808x config_aneg to dedicated function
    https://git.kernel.org/netdev/net-next/c/8e732f1c6f2d
  - [net-next,2/2] net: phy: at803x: make read specific status function more generic
    https://git.kernel.org/netdev/net-next/c/38eb804e8458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



