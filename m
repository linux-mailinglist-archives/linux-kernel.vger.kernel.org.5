Return-Path: <linux-kernel+bounces-2997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AF8165C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94EE1F2158B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BD63CD;
	Mon, 18 Dec 2023 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qecIDD5h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A7567F;
	Mon, 18 Dec 2023 04:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 727EAC433CC;
	Mon, 18 Dec 2023 04:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702875101;
	bh=/dDUerN4rD0aWnqgxV/sYr2x4DP4FC9to8aGBw8BXX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qecIDD5hAFPBxWC7U2YN4eMy21q9AYdwpszeI70FgNXXnQ6hHnn42U9QPNBC4ywy9
	 CNIZzrfKDyaG8f7y/kidynZAywuy+zcS8fYq2Hza89fX+RCOJLXDJ6yColgvyDueOo
	 70HD1i/8vmAfMbYhQj4Bkp6Mx1iLqkr3K/Yj2pgh4ZXsQB2M1+5T3fT2pMOhCl4hHS
	 NLZj/RrgbxzajeY2XlCZ0es2+Oq52hc+M8hGYaCUCA7scpZHZYqJUAxDpNxJfRD2Zv
	 TsyzGgcC2SYzcew1yxdCWakLnM7IPblAgWtCmeARw3NIyvLAnjVwGG84480UwKGEXn
	 LPkn+AHcxrAqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B387C41677;
	Mon, 18 Dec 2023 04:51:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome/wilco_ec: Remove usage of the deprecated
 ida_simple_xx() API
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <170287510137.24063.216178933105392650.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 04:51:41 +0000
References: <898d9aa181a84f1d17725ca047004bad532c37e9.1702745959.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <898d9aa181a84f1d17725ca047004bad532c37e9.1702745959.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bleung@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, chrome-platform@lists.linux.dev

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 16 Dec 2023 17:59:38 +0100 you wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - platform/chrome/wilco_ec: Remove usage of the deprecated ida_simple_xx() API
    https://git.kernel.org/chrome-platform/c/57eb6dcd32cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



