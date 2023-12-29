Return-Path: <linux-kernel+bounces-13206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F282011D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD571C2144B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FE12E75;
	Fri, 29 Dec 2023 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJu5tO23"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257F12E46
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEA50C433C9;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703877024;
	bh=azbq9IaFcbH3G1hY8wqg9qCkLNXlK1459gYGzqBZmB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJu5tO23zkSBizsuEcsJ8lve5wEaPt3xh8r7hHFcy5yNbHXULOf9dKCWiPc0PMwvJ
	 sC7V3b6/qVKuqdxb0Q6dF1pL+MAKuk0CX2QR3Ichgze7V9AW+I1YHnU1MLSdiKSYPR
	 O3lZ3g0oA4VqTnWv8xTGhn7kjOpRBEv+PqUMUIhGOKwkbpDTc7lq+BwYhwNygY++KQ
	 Xo5SIjFODNmXhr7+FWNg7g2uPBl1/2R9Kv8Lrj8CWxnjTvnbukDBQiNgzNPriOPvwf
	 xhaApl/8r7l8Fm3s1qdyi6g0l0nhAgYP70Butd73zX1rUKc1hABVvY6dqLd3rpUzf8
	 j2wye18ew2v0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B409BE333DB;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V5] f2fs: show more discard status by sysfs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170387702473.8173.3280676810374722700.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 19:10:24 +0000
References: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 20 Dec 2023 09:59:58 +0800 you wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: Improve the patch according to Chao's suggestions.
> changes of v3: Add a blank line for easy reading.
> changes of v4: Split to three entries
> changes of v5: move these entries from disk/xxx to disk/stat/xxx.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V5] f2fs: show more discard status by sysfs
    https://git.kernel.org/jaegeuk/f2fs/c/c3c2d45b9050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



