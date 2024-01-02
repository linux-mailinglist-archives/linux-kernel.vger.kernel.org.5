Return-Path: <linux-kernel+bounces-14949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCCE8224D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777961C22CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC0171DF;
	Tue,  2 Jan 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6NrCSUg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046F182A1;
	Tue,  2 Jan 2024 22:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE3CC433C8;
	Tue,  2 Jan 2024 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235029;
	bh=UVk1aW6/m8cK+g7P0nIEKweCbLRTxfLjSy/D3W726v4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6NrCSUgpj49nZW/PoG9PDFS+vT/sSIVpret8csR6T/GbjW9kRx4lrSHDeWG/Cyi9
	 5WdpRun3cb5fr2k+zev012DkRmEx9gr1F5lsVohqGwyAEaV9PuzHABAEqSaRn/4UAz
	 SIzVj1MRJBv9i1Vwax/IUaUzRRJpXegla9cmyPtNFI6S6L9L8SdhYC+1dwkO55o2Ah
	 klWBiN5Ond/gFkwdH4HwP5QaJjkt/BdX9OK28pPPyaBKI8mOGqs+BO299Hz5AW0xBB
	 Jn4QkuiviObX0vNgtvkRahLBVVj6n4e9TX1PLCkkokaDi+K5/KaVrTINKb6r4VN3gX
	 pP663K75sUdag==
Date: Tue, 2 Jan 2024 14:37:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/4] net: phy: at803x: even more
 generalization
Message-ID: <20240102143707.69f08d5a@kernel.org>
In-Reply-To: <20240102140330.7371-1-ansuelsmth@gmail.com>
References: <20240102140330.7371-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jan 2024 15:03:24 +0100 Christian Marangi wrote:
> This is part 3 of at803x required patches to split the PHY driver
> in more specific PHY Family driver.
> 
> While adding support for a new PHY Family qca807x it was notice lots
> of similarities with the qca808x cdt function. Hence this series
> is done to make things easier in the future when qca807x PHY will be
> submitted.

Does not apply..
-- 
pw-bot: rfc

