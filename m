Return-Path: <linux-kernel+bounces-1960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAE81565C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3162D1C21516
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6282F1875;
	Sat, 16 Dec 2023 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGBzSvP2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CD17E8;
	Sat, 16 Dec 2023 02:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1118C433C7;
	Sat, 16 Dec 2023 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702693520;
	bh=kRO0YG8+CO4ljrvXLSlofWbI0i/fwH09st4tIvhmNGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGBzSvP20kthkCpRSw6/kUQXvv+pM1IdKhddtV/DM3OzDlJewl3lCxCAHrHOnZ+Ng
	 egKnFxUTVWougaYSbRZPe+H3g52By8pKuVinW1EzvUpGRDVc6OdeuSEjmsvuYE+FHb
	 5pu12o3IpaTlERnXZCmKBuBt5DANQNL45g8+Tfl5vPd05YyO9L7B8DIsXNFosOrVoo
	 S2EhtU7+dfqdySxGow9WY6ksSKWgWdLoauua52XIrMCHHM7APywP0SWRhhOagB5WPz
	 WatiN7nuYU358KM2ud7uMZfcci6fRdTOq7aWIwdRg1iCof9NnJdAYVtGCsz7xrG+JP
	 jlY485gHYiV7A==
Date: Fri, 15 Dec 2023 18:25:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12 net-next] qca_spi: collection of improvements
Message-ID: <20231215182518.081559ea@kernel.org>
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 16:09:32 +0100 Stefan Wahren wrote:
> This series contains a wild collection of improvements for the
> qca_spi driver. This is a follow-up series to the recent bugfixes.

The fixes are now in net-next, and looks like this series
no longer applied, please rebase & repost.
-- 
pw-bot: cr

