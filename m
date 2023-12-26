Return-Path: <linux-kernel+bounces-11685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840C81E9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0310D2827EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332A4C7D;
	Tue, 26 Dec 2023 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb6bHdFg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9F443E;
	Tue, 26 Dec 2023 20:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 296C7C433C9;
	Tue, 26 Dec 2023 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703622625;
	bh=ssgpZ49piN0RSEBeazSXVQruSiFrJuUegm8xutzokIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gb6bHdFg3j+qOJCmNcmFhHoo3oOdiPrhN2oFlpU4sTAPdwVHrTMTZOcviZpheCrs4
	 UNMxYBgG31/v0o2zpi5lfBkHBIFmUh8Jgd12zck4k8upAo3jCsMEVm4UDmL/3vFs+T
	 RBNsiv0NCpgabk1KHA+192TZoSKP5WuPwF5k6cTlZ4tao2JEhqzHnVq6NmMxSq4zUk
	 97fhDcZZuvsC1fYy9GxsHNMVtdcxUdflaE7C+dPE1r6Vzwid9R1ghFX53lt0v4m94w
	 kkvueLZhpim1REVkcvzmJ/4ZN9edeA/Aj/s/0PKOUnwSafgXquib+yT4jceL0/7S/l
	 WpeAk6Qzz2ocA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1045EC4314C;
	Tue, 26 Dec 2023 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-af: Fix marking couple of structure as
 __packed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170362262506.14680.13738555065707744949.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 20:30:25 +0000
References: <20231219142633.321507-1-sumang@marvell.com>
In-Reply-To: <20231219142633.321507-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 19:56:33 +0530 you wrote:
> Couple of structures was not marked as __packed. This patch
> fixes the same and mark them as __packed.
> 
> Fixes: 42006910b5ea ("octeontx2-af: cleanup KPU config data")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: Fix marking couple of structure as __packed
    https://git.kernel.org/netdev/net/c/0ee2384a5a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



