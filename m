Return-Path: <linux-kernel+bounces-19671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6558270A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD861C220A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8346540;
	Mon,  8 Jan 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1ehixv99"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52E4652F;
	Mon,  8 Jan 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=876Pmdev7h3YBKXrTytJRM8JGp0yGIQGTehUIIKYAUk=; b=1ehixv99HNX5QcJ2OoPKf9eQrH
	lTkFJSKGFYVKS6LDV/2scCjpgy4F5tH7oEPDQYBug+Mng+LSgsifziSmR3YGbOT5GSF6/7B+Vr8Bv
	FnDbm2wFnlj46pSmKXixGYQNRpr6Lc4as4eXQMI+uyjtCV9+BFdUunK3bRN8mC8O0dHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMqG1-004eK2-99; Mon, 08 Jan 2024 15:05:37 +0100
Date: Mon, 8 Jan 2024 15:05:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 4/5] net: phy: marvell-88q2xxx: fix typos
Message-ID: <a9e822af-6173-486b-9e54-f71147fbf9a1@lunn.ch>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-5-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093702.13476-5-dima.fedrau@gmail.com>

On Mon, Jan 08, 2024 at 10:36:59AM +0100, Dimitri Fedrau wrote:
> Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
> mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
> Fix linebreaks and use everywhere hexadecimal numbers written with
> lowercase letters instead of mixing it up.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

