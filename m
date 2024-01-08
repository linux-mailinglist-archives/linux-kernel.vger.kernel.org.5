Return-Path: <linux-kernel+bounces-19649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94E82704E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5116B1C228AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67A45BE6;
	Mon,  8 Jan 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H/5qxa2K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40604776B;
	Mon,  8 Jan 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IMoMvb9scX3hSPn85HFoM80PBcRksMLJGosthKdKK2M=; b=H/5qxa2K/VCzBB6dRHUwn+H31o
	d4VdKzFIFF9jfRpcATe59ZZj/9H2Sgm07nySFurYE84T+vN3Na8BLzv79KL4gHapKMALpHzxKPrlS
	LvQPszBFegf6SIW/g1iWIn1I32FUJ9+TeaPYyPX8EROJKstUXYPz5EOKGXHj+zZ2aLA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMpzy-004dzf-OL; Mon, 08 Jan 2024 14:49:02 +0100
Date: Mon, 8 Jan 2024 14:49:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 1/5] net: phy: Add BaseT1 auto-negotiation
 constants
Message-ID: <c9ede0c2-ec37-48b1-9ce7-8a1543c828ba@lunn.ch>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-2-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093702.13476-2-dima.fedrau@gmail.com>

On Mon, Jan 08, 2024 at 10:36:56AM +0100, Dimitri Fedrau wrote:
> Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
> auto-negotiation advertisement register [31:16] (Register 7.515)
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Sorry, more nit-picking :-(

Signed-off-by, Reviewed-by:, Fixes: etc should all be together. No
blanks lines between them. And Signed-off-by: comes last.

Given the missing statics, it looks like you will need to repost in
two weeks times.

       Andrew

