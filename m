Return-Path: <linux-kernel+bounces-14996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63878225E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5569F28467D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC85A4C;
	Wed,  3 Jan 2024 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5qKZiw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB6364;
	Wed,  3 Jan 2024 00:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05128C433C9;
	Wed,  3 Jan 2024 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241225;
	bh=m/YtIRosK7AiMzo6ZLongGReudykuxF9y3ocqvW6R7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5qKZiw/REbZx47AsPFOpYVfyQYr32QPrNhfBtyzcTaphRYlUbroehMv2hNScRNhP
	 rxMsxFIwiSHP1yw/oMsB52n7JiwqO8s8fD7i/kYSaOPI3y+MoOEximvmH2327LC0tL
	 RcT9II93mmm4tlh4g8bQ1oFk+Y6f9JPiN/X3iwdwexfDR6Uwdal3gOk0e9TzN4qZgk
	 GlMi47EwYWPVAT/49vEYXz+L8avtnc3vJB2Iil7P8MlwxSjfovGFJ+fE3LOudxyqbB
	 WH71HeARxawo+kOb8ek5gTMpf8N1kYkvKSZf1rZOJL5Kv9VXcKCrerdJ0cvixsmZ2o
	 mn6YI6MADHfaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC903DCB6D1;
	Wed,  3 Jan 2024 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: new reviewer and prevent a warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424122489.12524.14018674920048838370.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:20:24 +0000
References: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
In-Reply-To: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Dec 2023 13:10:16 +0100 you wrote:
> Patch 1 adds MPTCP long time contributor -- Geliang Tang -- as a new
> reviewer for the project. Thanks!
> 
> Patch 2 prevents a warning when TCP Diag is used to close internal MPTCP
> listener subflows. This is a correction for a patch introduced in v6.4
> which was fixing an issue from v5.17.
> 
> [...]

Here is the summary with links:
  - [net,1/2] MAINTAINERS: add Geliang as reviewer for MPTCP
    https://git.kernel.org/netdev/net/c/118ba479d02c
  - [net,2/2] mptcp: prevent tcp diag from closing listener subflows
    https://git.kernel.org/netdev/net/c/4c0288299fd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



