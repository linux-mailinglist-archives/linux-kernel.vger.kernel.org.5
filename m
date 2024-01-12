Return-Path: <linux-kernel+bounces-24196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616182B8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4441F1C23A58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF0469F;
	Fri, 12 Jan 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpuHGnit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108AA54;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 318DBC433B2;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=6mUeJYB6GdEGzaR9k4n5cuuuVHeZpAroRaR/JgNly8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BpuHGnit0RIR0IwDwS65aHnhkantKjEQUtpNxMZj1YN09f4iigkbhmjxWp79LfK9N
	 nf/gaxO+k1ZDv99xfK9VldrnOk4ntgSVoP0ixp+Gkb6tnznhMQ/HTFiu9MNUNkAVdW
	 uZ4i/VOHG8kgFwCHoGvwgHRcCGCGrDjklU/AlDVtQ4WjTYcqcdsDwchy7lS8Npl9Y8
	 gyH2FTM2wgrRnL8RLhpWUmADvIJlY7tPir3Mnlk9xOr6Rl9UDJ8OUSVBuEArV5B7JD
	 RJxdw6TA8KYsq2ogfRjPiC3xEzB3rk45BMsyQoc6vMT+Oigq1pLtp6trGA9NhiayXx
	 vu36TtsmT9moA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19D34D8C974;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-af: CN10KB: Fix FIFO length calculation for
 RPM2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502122810.27071.6970182954909965200.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:28 +0000
References: <20240108073036.8766-1-naveenm@marvell.com>
In-Reply-To: <20240108073036.8766-1-naveenm@marvell.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, ndabilpuram@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 8 Jan 2024 13:00:36 +0530 you wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> RPM0 and RPM1 on the CN10KB SoC have 8 LMACs each, whereas RPM2
> has only 4 LMACs. Similarly, the RPM0 and RPM1 have 256KB FIFO,
> whereas RPM2 has 128KB FIFO. This patch fixes an issue with
> improper TX credit programming for the RPM2 link.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: CN10KB: Fix FIFO length calculation for RPM2
    https://git.kernel.org/netdev/net/c/a0cb76a77008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



