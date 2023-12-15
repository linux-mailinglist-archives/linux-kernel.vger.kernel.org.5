Return-Path: <linux-kernel+bounces-710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958B8144F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2A9B21DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48D1946E;
	Fri, 15 Dec 2023 09:57:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57B18AF4;
	Fri, 15 Dec 2023 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rE4wg-00BCgo-Fz; Fri, 15 Dec 2023 17:57:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Dec 2023 17:57:36 +0800
Date: Fri, 15 Dec 2023 17:57:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, shenyang39@huawei.com,
	liulongfang@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH 0/2] crypto: hisilicon - optimize the processing of qm
 and sec functions
Message-ID: <ZXwjEHL4E4KpJS1J@gondor.apana.org.au>
References: <20231209070135.555110-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209070135.555110-1-huangchenghai2@huawei.com>

On Sat, Dec 09, 2023 at 03:01:33PM +0800, Chenghai Huang wrote:
> This seires patch optimize the process of ret, and delete risky redundant
> functions.
> 
> *** BLURB HERE ***
> 
> Chenghai Huang (2):
>   crypto: hisilicon/qm - delete a dbg function
>   crypto: hisilicon/sec2 - optimize the error return process
> 
>  drivers/crypto/hisilicon/qm.c              | 3 ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 7 +++++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.30.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

