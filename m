Return-Path: <linux-kernel+bounces-15000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC078225F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B9284744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183E15BD;
	Wed,  3 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzkYxKnM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0B23C8;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA15AC433C8;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241830;
	bh=xPhNSHWSH/D4xh5+9vbVzSaKGAYr3R5ktkITLrWT/Lo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzkYxKnMz3KcFi3gWcJKzGEA+8GT/e+MeQV7dKcdMhXsmyrkBuvz3YFTRZcGBKwkS
	 5VOjIpOgvtkhmS/pxwfM2GXEqtcBcZnZonQ4qlhv/gDJJby0rw+jpsW9N+sIRof8Gs
	 SUAP6MEovj22DkZ4gilDERhZmi6FdEnZNksV6crddGcW8i6Co0N1Niybesgh/T8Z9t
	 r29kv04T0aJEi5kphDinODGh9EkQjxZYJUAaqgn04rJ8+mQuPA8qtjmejxWZhF6QQP
	 Gw1bQZdjLl8AapzOKBZzckXNFU0XCENUBlcAFLKObqj0wjDxVbwiPNMcrJ/QsgjYaN
	 wmQbrXAR+7HUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98AB5C395F8;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers/net/ppp/ppp_async.c: Fix spelling typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424183062.18204.1002529777230334776.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:30:30 +0000
References: <20231227015831.289077-1-liyouhong@kylinos.cn>
In-Reply-To: <20231227015831.289077-1-liyouhong@kylinos.cn>
To: YouHong Li <liyouhong@kylinos.cn>
Cc: paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kernel-bot@kylinos.cn,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Dec 2023 09:58:31 +0800 you wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> Fix spelling typo in comment
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Here is the summary with links:
  - [v2] drivers/net/ppp/ppp_async.c: Fix spelling typo in comment
    https://git.kernel.org/netdev/net-next/c/38894ff3a04b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



