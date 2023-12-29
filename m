Return-Path: <linux-kernel+bounces-12927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC981FCC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73C31F21249
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B6567D;
	Fri, 29 Dec 2023 03:28:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A772584;
	Fri, 29 Dec 2023 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3Y0-00FG3R-64; Fri, 29 Dec 2023 11:28:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:28:43 +0800
Date: Fri, 29 Dec 2023 11:28:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ovidiu.panait@windriver.com
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, Heiko Stuebner <heiko@sntech.de>,
	Corentin Labbe <clabbe@baylibre.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] crypto: rk3288 - Use helper to set reqsize
Message-ID: <ZY486/gwA4o/hmeM@gondor.apana.org.au>
References: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218164649.2492465-1-ovidiu.panait@windriver.com>

On Mon, Dec 18, 2023 at 06:46:43PM +0200, ovidiu.panait@windriver.com wrote:
> From: Ovidiu Panait <ovidiu.panait@windriver.com>
> 
> The value of reqsize must only be changed through the helper.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
>  drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

