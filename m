Return-Path: <linux-kernel+bounces-132604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FD899720
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73413B24033
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790114291E;
	Fri,  5 Apr 2024 07:56:23 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF91428F8;
	Fri,  5 Apr 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303783; cv=none; b=FTg6Ou/n6ErliASPlRPsehQu8u6aoYo9N0WQjuyMg894kSX0TwIsR/GTNPR5ycxQ88jiReqHXNvfg7yvUietZekwPhvpSi4Ze+9Awn+7Ick36BId1J1zt9ZhrftwUKfB4Je6MBFtiWSjwP6tKBmG1/iZ0ytPnL+yo61LYKP1xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303783; c=relaxed/simple;
	bh=SMgSnO0dEhQ8NbC3AA5vERFlEK7T5wnHtoSPEChbVrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNOfFQbaBbLZ6E7oSSp+5baXTi9p7TwClm2SrSwzfaomwRiQovhkpPFSnl4/pUdMfcSWtl4YwrYPtRsvBYGk/fA3R9fH8js/Dagit6yC7GeirH9gMxN8j7x86MUx9Nw+Mq46RCVKVM6qsryLP6sBriYNa6Vo2dnoMV1jWP0BTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseQn-00FU8r-5J; Fri, 05 Apr 2024 15:56:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:56:30 +0800
Date: Fri, 5 Apr 2024 15:56:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: jitter - Remove duplicate word in comment
Message-ID: <Zg+urvO2r39OI9H/@gondor.apana.org.au>
References: <20240328160401.445647-2-thorsten.blum@toblux.com>
 <20240329154455.1733-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329154455.1733-3-thorsten.blum@toblux.com>

On Fri, Mar 29, 2024 at 04:44:54PM +0100, Thorsten Blum wrote:
> s/in//
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Fix the commit diff because I made a mistake when breaking up changes
>   into individual patches
> ---
>  crypto/jitterentropy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

