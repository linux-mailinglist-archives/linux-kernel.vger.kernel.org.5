Return-Path: <linux-kernel+bounces-2795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD08161FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D3B282E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397E481CE;
	Sun, 17 Dec 2023 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afUE5RGc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D08481B1;
	Sun, 17 Dec 2023 20:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124E8C433C9;
	Sun, 17 Dec 2023 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702843998;
	bh=OdSFilFvnAcTrN8dj5LWw6WnTbCaxstIIBXtCuNgY6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afUE5RGc2Oh2Cba5Z+CvC964O8w9C1RKd64k8a7E8jahmzS5CVY6Fvx4o7Q7dS/2x
	 tp9idGW+OL0jwoz6RHdR/pBkihk9JWwX1X1B4tRIwUGdzBUPMXv4l79b9GCY4Bk5Qb
	 kiFRrkGp72imOkU8ZB2q5ZqfrQyfqaSdCcvZDW7siQkxsuxt7qBkeXnHMZKw1NEDam
	 +q3Pm8u2OsG0kQByRvKRRN1FJHLVBfnbGduM+IUOidPKxtAPSVXBeiiWEp7LwIfvNp
	 Z2ySNwffwQIFrjLe/0ZsoQ/c3sX/Dgo6rhjurT+65S6wji0wlR7aZxWcHCWvGN/vbJ
	 gCDmLyEUG1nAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED98FC04DD9;
	Sun, 17 Dec 2023 20:13:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Add new devlink param to configure
 maximum usable NIX block LFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170284399796.30184.3650113376008662211.git-patchwork-notify@kernel.org>
Date: Sun, 17 Dec 2023 20:13:17 +0000
References: <20231215120149.160122-1-sumang@marvell.com>
In-Reply-To: <20231215120149.160122-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 17:31:49 +0530 you wrote:
> On some silicon variants the number of available CAM entries are
> less. Reserving one entry for each NIX-LF for default DMAC based pkt
> forwarding rules will reduce the number of available CAM entries
> further. Hence add configurability via devlink to set maximum number of
> NIX-LFs needed which inturn frees up some CAM entries.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs
    https://git.kernel.org/netdev/net-next/c/dd7842878633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



