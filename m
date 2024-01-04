Return-Path: <linux-kernel+bounces-16935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7968582463D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464B41C20B59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93D28695;
	Thu,  4 Jan 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np/wq2zD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DB250F2;
	Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D63C433CA;
	Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385828;
	bh=GT7a99x/z4Bg6ZWuMZ4pBmBqzfF43hjo1DiECkMYpmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=np/wq2zDa2but9Uizayyf1+Y5dwhArdHpKNfACoIQdRYCyndlrryrS83I/WAKF6J3
	 xfD21v64YuS6DD4vXCccFTVSKJkglktMARpRxE5TExAqozwrsOZAmPSRg1PI000/Te
	 QHDwYAwmklFZnivcXqx3N9g/Equ2k8NsddUlVCNioB8ASWptQjFF2WcfhX8avYujRC
	 oEPtkK4gha9Y7B5vekCi3fJfZxHZP74NVkP1hMknB1mGntAkWATAST4iQcKI0CmwWQ
	 GYVZh2exFBzqdEa63jYQyyoEUhMlNtS2ds78xdofg19PX1fWdVhqobYotGaqww6Wei
	 aS6Atp28FszQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E642C43168;
	Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net: Implement missing SO_TIMESTAMPING_NEW cmsg
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170438582838.10335.14098796357832248818.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 16:30:28 +0000
References: <20240104085744.49164-1-thomas@corelatus.se>
In-Reply-To: <20240104085744.49164-1-thomas@corelatus.se>
To: Thomas Lange <thomas@corelatus.se>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jthinz@mailbox.tu-berlin.de, arnd@arndb.de,
 deepa.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 09:57:44 +0100 you wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
> __sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
> SO_TIMESTAMPING_NEW.
> 
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Link: https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
> Signed-off-by: Thomas Lange <thomas@corelatus.se>
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net: Implement missing SO_TIMESTAMPING_NEW cmsg support
    https://git.kernel.org/netdev/net/c/382a32018b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



