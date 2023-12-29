Return-Path: <linux-kernel+bounces-12898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A881FC59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216B8283408
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1B20E1;
	Fri, 29 Dec 2023 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP3gVd8D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB31382;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84300C433C9;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703813424;
	bh=XqmQV1kUwB1SpUYkpx3Aftc0MGnCMfRkmbMCKqeDIjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bP3gVd8DmjbsHcpLGjLhkQ73ogXmZx6fH9L5Ljj436AJaD2xXUyaa2sgS4UtjJFr8
	 zhPklGWYHEzKamaQz/r2ZB2paa9iPlI9GNg1d5Qyd/nW18C3QWG3H94YawLZ7Bd1nD
	 rohtj/kYD3vwBJfeR9AWvavsc396LPCdlw41GnI5oNsGYFdMI9EqOtMY1Y5itrzuIl
	 AER/mnlOx1HtLqo/erdR2Sriu+xqPumG517pA1xR9tuuAa1tSaW4nf+4OdKChg1O1/
	 G5hQ4pp8l+X9BSy8CFTXKCguyTPZjU/Odjqo9tFb87uEf4gdnprvaR3y4878dFimnw
	 mdDcIFcajzK5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66142E333D3;
	Fri, 29 Dec 2023 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sock: remove excess structure-member documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170381342441.27815.16733739025972963982.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 01:30:24 +0000
References: <874jgdhhu7.fsf@meer.lwn.net>
In-Reply-To: <874jgdhhu7.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 16:51:12 -0700 you wrote:
> Remove a couple of kerneldoc entries for struct members that do not exist,
> addressing these warnings:
> 
>   ./include/net/sock.h:548: warning: Excess struct member '__sk_flags_offset' description in 'sock'
>   ./include/net/sock.h:548: warning: Excess struct member 'sk_padding' description in 'sock'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> 
> [...]

Here is the summary with links:
  - [net] net: sock: remove excess structure-member documentation
    https://git.kernel.org/netdev/net-next/c/144377c340f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



