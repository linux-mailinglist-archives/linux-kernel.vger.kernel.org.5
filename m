Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228CC7A71F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjITFXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjITFXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:23:19 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEBE65;
        Tue, 19 Sep 2023 22:22:25 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qipfC-00GD5j-E0; Wed, 20 Sep 2023 13:22:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Sep 2023 13:22:17 +0800
Date:   Wed, 20 Sep 2023 13:22:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/2] crypto: hisilicon/zip - change support algorithms
Message-ID: <ZQqBiY2b/z9bRTUO@gondor.apana.org.au>
References: <20230914090908.3849318-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914090908.3849318-1-shenyang39@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:09:06PM +0800, Yang Shen wrote:
> Add deflate algorithm. Remove zlib and gzip algorithms.
> Tested with disable CONFIG_CRYPTO_MANAGER_DISABLE_TESTS.
> 
> Yang Shen (2):
>   crypto: hisilicon/zip - support deflate algorithm
>   crypto: hisilicon/zip - remove zlib and gzip
> 
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 282 +++-------------------
>  drivers/crypto/hisilicon/zip/zip_main.c   |   4 +-
>  2 files changed, 37 insertions(+), 249 deletions(-)
> 
> --
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
