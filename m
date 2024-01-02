Return-Path: <linux-kernel+bounces-14477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B34821D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B36283639
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8C125B5;
	Tue,  2 Jan 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIatBOHo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51410979;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 883DDC433CA;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205225;
	bh=0+Wc1gaWO5JuZviQn1am9YEUwKwB1KClPqfuNr/8Ubc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RIatBOHoOhaGXi3h9X3pAHv5wSVrDzhTt0+0EH0fxfk50H9dslKkeU+QoauCp5Nww
	 mcL5oEH3jriGEQyi/pKkgGjQhqRHt+AThW51kTzAAtUZcodM7sxMtA7CmIBVNqluZy
	 CSnX6seEH/zKjONO906QN5bm4BJsSenFZxwFop5cQRgRXrMKCgfGatjmnsQ2lrScI9
	 188xNPM+vvwiuJh9L0B/ZlY4pfwAHOxoM9tLyTt9W9Bivzjb8LGLPN0otRLfF+JYSC
	 Xb97FgOenaXLc19HP4TMgqhFo4gwIhohDHbiFkw8GeaZw66ItSgCAb0BreGfC97qWO
	 3lckVixO+5MOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F15EDCB6D1;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: linux/phy.h: fix Excess kernel-doc description
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420522544.14312.11129213150378995349.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:20:25 +0000
References: <20231223050613.13978-1-rdunlap@infradead.org>
In-Reply-To: <20231223050613.13978-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 21:06:13 -0800 you wrote:
> Remove the @phy_timer: line to prevent the kernel-doc warning:
> 
> include/linux/phy.h:768: warning: Excess struct member 'phy_timer' description in 'phy_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - net: phy: linux/phy.h: fix Excess kernel-doc description warning
    https://git.kernel.org/netdev/net/c/059d37b718d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



