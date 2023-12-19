Return-Path: <linux-kernel+bounces-5107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D38186A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A6B2837F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7B15E92;
	Tue, 19 Dec 2023 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb9VwYrQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C31B267;
	Tue, 19 Dec 2023 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47407C433C7;
	Tue, 19 Dec 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702986623;
	bh=ucIgfbHGguWe0Gv4Uo55+Wwc0LIf/RjYGpI5e3y9IhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pb9VwYrQMllBjOE1r8wFFgLcCeSCDT4FAubD9Sd5C5WtvGLDF4wcQfd74UNYEbT+H
	 GvBxfeHc7b60PdaYpv0PhEGAzBnqihRBDNVdArL5zwcmt/L1psc3NwQAHCpbxMl+kt
	 jr9Kmme897QPozUjf3lK41H5bW2nTSU2iP6aAA5VsUYGUuq8Mx0iMFLdxWgGVc2siR
	 aseZ6wYNEOc3X5WuOjdo0U49obzqpT0v+kKDG9afbLYZvRtjOzHbEVNnd3nhU8g4in
	 +/jlsRNXql6tWby+u4UV9n4qYEplvd2+mXis7d9HZkJ+euGZXgCnv6HVR4fzcEQNY1
	 QvMehhPMjdzDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31DABC561EE;
	Tue, 19 Dec 2023 11:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: hns3: add new matainer for the HNS3 ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170298662320.14958.16031560672027523215.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 11:50:23 +0000
References: <20231216070413.233668-1-shaojijie@huawei.com>
In-Reply-To: <20231216070413.233668-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 16 Dec 2023 15:04:13 +0800 you wrote:
> Jijie Shao will be responsible for
> maintaining the hns3 driver's code in the future,
> so add Jijie to the hns3 driver's matainer list.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> v2: add 'net-next' in subject
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: hns3: add new matainer for the HNS3 ethernet driver
    https://git.kernel.org/netdev/net/c/fa94a0c8424a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



