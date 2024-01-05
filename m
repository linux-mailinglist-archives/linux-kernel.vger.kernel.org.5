Return-Path: <linux-kernel+bounces-17898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F58254B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEC91C22D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED152D7AE;
	Fri,  5 Jan 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+Dvq0Uq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE92CCB4;
	Fri,  5 Jan 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xzZGtAdZr6oqhUpLLEDm25vwwARKcimzhexHVUSEkEY=; b=h+Dvq0UqpzP0Drt86ea0S4DdI8
	V7VU0XnphGHGwOyNF4PedeztlSmeDO9rQ19+cIZmtrD6DjmPJ45NAKbd0SCNE4UCJC9kl4ELfnv+9
	YEL01TkqHOX2vEhALuM3T4VbI6w0+izHg+hGtsaylAKGE7GEb3CUgrLRfn6cfuVB++DI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLkgX-004SQy-Sk; Fri, 05 Jan 2024 14:56:29 +0100
Date: Fri, 5 Jan 2024 14:56:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v16 00/13] Add Realtek automotive PCIe driver
Message-ID: <3fcf7b73-95e9-486b-8c14-1f92094d1316@lunn.ch>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105112811.380952-1-justinlai0215@realtek.com>

On Fri, Jan 05, 2024 at 07:27:58PM +0800, Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver 
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of 
> Realtek Automotive Ethernet Switch,applicable to 
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

You should not resend a patch series in less than 24 hours. Even when
you mess up and do a partial send. As you have seen Jiri looked at
your partial patch series and made a comment. Which you then
ignored.... That wastes Maintainers time, which is not a good way to
get your patches reviewed and merged.

    Andrew

