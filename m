Return-Path: <linux-kernel+bounces-13-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A6813AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA391F21FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA8697A0;
	Thu, 14 Dec 2023 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MggRYk5S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A716978D;
	Thu, 14 Dec 2023 19:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C571BC433C8;
	Thu, 14 Dec 2023 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702582020;
	bh=vkWYixzyfgyZi8a/VjYllS8R/TJLFtiB0inVFXCnrI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MggRYk5SC9uccJDxd3wsRLBrv6cFbxMA1rm7EBBhdT9hLrbAgLPQD5lxRaBnViMDi
	 r23yD2KZjTILw3W8zobHffZQSBtdSGormnzOTrrl7tfxJ9cOY7k9CsfVwBdnFOlRbP
	 VRU85t0aCOom4WpN407KBpS4JpNZrk6WoCVJwQAs9N1ywK8his7nfddhyF/kfA+l4l
	 3D/7jQbO4Aa7Axhai0qoEeKM5K3M9pjvqSwOE5GQ6yyWkhvMe2EsqTFxo8zgOybge5
	 oxt9/ct3gb87usVf8N+0JD/bIcDMgBFh8kONeDKJUyvsLmMEE+dPnkD0HQJIwzn8VG
	 d4aTDjlJIrM4g==
Date: Thu, 14 Dec 2023 11:26:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
 geert+renesas@glider.be, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net-next v2 00/21] net: ravb: Add suspend to RAM and
 runtime PM support for RZ/G3S
Message-ID: <20231214112658.583cfc60@kernel.org>
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 13:45:39 +0200 Claudiu wrote:
> Subject: [PATCH net-next v2 00/21] 

We got 260 patches in the review queue. Please pace your patches:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

> Patches are based on series at [1].
>
> [1] https://lore.kernel.org/all/20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com/

Meaning there's a dependency we're supposed to track?
You have to wait for fixes to land, we marge the trees every week.
-- 
pw-bot: cr

