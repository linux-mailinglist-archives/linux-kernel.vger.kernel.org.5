Return-Path: <linux-kernel+bounces-19009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAEA826667
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7A21F21420
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE912E7D;
	Sun,  7 Jan 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKOMsWim"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6245125A6;
	Sun,  7 Jan 2024 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B62EC433C9;
	Sun,  7 Jan 2024 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704667224;
	bh=0vSk3rQSAM9duFLGNqP4CwiJGaYJLkCUjUP7biwcflc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKOMsWim5MmdYlkM2F1CRJl6qo9w5NKKx4/lwb8tAA5FQUmh7D4IIQJ6mPLDjq6CS
	 PfwkqRu4KznCFly6LePK1XxOlSDxVYNuNx646qQnfZJlRqglEtHHrx1cBp2eeYFGLz
	 a0v+2KGQLrOdxmgElrNiC9TAPUCsrc3ivd38RfrY3x6LXX4aiSSQ0PVFz+KctDLI7Q
	 og/mQKq7DWJQOPd5WocAtGOulUXcxmD9i4KuTfrpU7HYU5AOqO8ZvOEBP2gL8T2eXr
	 obR/IvaU2UpH/kMp+znLnRAQD7hi/aZ8a9Pn9KK11eQDFwXHF8rl+Sr/uUlk/119W/
	 hTDUxHvy0bu+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10528C41620;
	Sun,  7 Jan 2024 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net-next] ipvlan: Fix a typo in a comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170466722406.3852.12395029185705591371.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 22:40:24 +0000
References: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 10:27:08 +0100 you wrote:
> s/diffentiate/differentiate/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2,net-next] ipvlan: Fix a typo in a comment
    https://git.kernel.org/netdev/net-next/c/e900274f27c3
  - [2/2,net-next] ipvlan: Remove usage of the deprecated ida_simple_xx() API
    https://git.kernel.org/netdev/net-next/c/3ee29a4474e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



