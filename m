Return-Path: <linux-kernel+bounces-6822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B68819E14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651B828ACE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272422323;
	Wed, 20 Dec 2023 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXZdhhbq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08322310;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACEF7C433C7;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703071825;
	bh=MipMd8/XclHrPRB6dqSILhdXwlTf1VnPhP4xY1gGs+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXZdhhbqy+bQ/rqMv3JDvebkX3CLNh4cdZZwk8xXtP8iAWvzk8GV+ZS7jO7vEkMkB
	 5TnyAnBH7f1rYQUu/SVWRrvEEo/pN7UxKA0A9ED0Socds2Wqexw7RIkb1hxOTZ6z/R
	 bgoRsUFd6SgEdU/rpoq4GIInQqewE9bOdIWHHbbj07G/IudkVizv4yQczw6+UR/lH8
	 UxhIGGmTERbE7KTfwACcuQ1gtp5hpsCb2mUtxearbzGYVRAHgaIE4WWeq/Sl+F4adq
	 gT27WFnKgdzHCTMV76jvVTBFH7XL84PZtudykWqAsXsBmD2VuI6kl0VRuq/YSB14l8
	 Mbiu6sEDVMYCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F0D2D8C985;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-af: insert space after include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170307182557.15860.5948663264630094873.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 11:30:25 +0000
References: <202312181459+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312181459+0800-wangjinchao@xfusion.com>
To: WangJinchao <wangjinchao@xfusion.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stone.xulei@xfusion.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 15:04:07 +0800 you wrote:
> Maintain Consistent Formatting: Insert Space after #include
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
> V2:
>     In accordance with Jakub's advice, modify the patch title.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: insert space after include
    https://git.kernel.org/netdev/net-next/c/b6895d0ac9d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



