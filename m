Return-Path: <linux-kernel+bounces-10077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B381CFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB151F24344
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671682FC2E;
	Fri, 22 Dec 2023 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbLa5l9z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2482F845;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C83C433C9;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703283627;
	bh=tzLxkfky1SGZ7FukP8qhT8K/nLkHtiY58wzpEImAB/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lbLa5l9zrEDA60+cxbe2sUA2+T2RPSS9OVRXc5hgjhdB5TA37qZzr0QfiEKlVHROZ
	 gJJbqTQGRoqDZyNXyIllbn8CLVVaC3DkBrl05E1DYgiElhNsY960nXBcI/oTkvy8vK
	 wLJ98dhhWNrbgjJ1QQcLy5MdHFuwdqps7DDNhuRDsoLnc5NUeTevE1GLjguq8l3E0q
	 zw4Q34w6lRPp39zrwVqXtYpNJet28CTyjnf1hSurc5ZUq0mPxeOIa+mXWB1S2cyI6H
	 vQR/ZUs2Gdhv3dTglLxrD7yMpfDtEXEmRS1ooXfLbz9d0Lf3Hma5x+VQveQZdhwkPe
	 Z6mK9qkZf6ZlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2026FC41620;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/net: Fix various spelling mistakes in TCP-AO
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170328362712.7428.17804520208125792515.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 22:20:27 +0000
References: <20231218133022.321069-1-colin.i.king@gmail.com>
In-Reply-To: <20231218133022.321069-1-colin.i.king@gmail.com>
To: Colin King (gmail) <colin.i.king@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 13:30:22 +0000 you wrote:
> There are a handful of spelling mistakes in test messages in the
> TCP-AIO selftests. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/net/tcp_ao/connect-deny.c      | 2 +-
>  tools/testing/selftests/net/tcp_ao/lib/proc.c          | 4 ++--
>  tools/testing/selftests/net/tcp_ao/setsockopt-closed.c | 2 +-
>  tools/testing/selftests/net/tcp_ao/unsigned-md5.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [next] selftests/net: Fix various spelling mistakes in TCP-AO tests
    https://git.kernel.org/netdev/net-next/c/67f440c05dd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



