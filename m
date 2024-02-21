Return-Path: <linux-kernel+bounces-75253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380F85E545
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7762839DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC68562A;
	Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5nTa5SE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35584FD8;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=cvrtwBi5lWElckc/fOJGsoG2w1n/6ObWkicyXxXhY7CS/x9FT7xVHG/S7yJyzLzimH9XVotilku8TB0NvSvt77lKrfflVCV2e5CfZptDSX35Ghsav9CCtwFMNX7OYcoKJ5463MVl5Lp/TZFdURDf1Y7x+1ONbg0IBgZSUzGcPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=oX4EdpTpbO8MejBIv3YlvOvhveBN1t+BKjJS4l8AiCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsUqAbnV5rpNDY/WJ+gewlD83QK2lmbZTHTJLfcscCEV2tdOXgJglqv+alviyiYS9U4pnUaHZDNvXhepsPD6JHhLisTfWq9i9iOJvPxNYtHJs+PLiwq8xZVDc/xskRaCS+a4hSlA0+Fk8Sf4GpNE30yo8rJErfC9EUCDrQ6Qy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5nTa5SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24B9AC43609;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=oX4EdpTpbO8MejBIv3YlvOvhveBN1t+BKjJS4l8AiCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a5nTa5SEaMxM4vHu942onhLIICKUgYn7Q19DgYidK7JLBiT7FqaZCzgunXlwEJiuZ
	 Sb45adoMh6XjrIiPjC3u2V5VDXR/MB1YAnZMnnxHTyDrEk58kaK/UzzHdEdIHp3teH
	 P6p9rcbUpSIG8Vkf146UKlBQE7nABz2lVcFVmkbCjxPntTclLdOhZvzM2+ZvoPh7bm
	 zcNhcPmOZ5JWv5pXJRXTqhwIQRVE5iakwdrF3z4fyc2kpRFNgK5mexBkgxW/lIBDov
	 breV/8cxigGnl506a31c0XkugLdz0CpCie2BavlG0jH+vr0qll9Gf8QmdZbmEH/IjM
	 vgJBEw4J7f6rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00E7FD84BD0;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: doc: Fix bouncing email address for
 Sahitya Tummala
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903099.7043.6155002050076801898.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240202165208.4091800-1-quic_jhugo@quicinc.com>
In-Reply-To: <20240202165208.4091800-1-quic_jhugo@quicinc.com>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, quic_stummala@quicinc.com,
 quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 2 Feb 2024 09:52:08 -0700 you wrote:
> The servers for the @codeaurora domain are long retired and any messages
> addressed there will bounce.  Sahitya Tummala has a .mailmap entry to an
> updated address, but the documentation files still list @codeaurora
> which might be a problem for anyone reading the documentation directly.
> Update the documentation files to match the .mailmap update.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: doc: Fix bouncing email address for Sahitya Tummala
    https://git.kernel.org/jaegeuk/f2fs/c/bb516cc086ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



