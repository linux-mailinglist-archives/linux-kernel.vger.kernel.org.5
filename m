Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFE7535E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjGNI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjGNI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:58:52 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35512D55;
        Fri, 14 Jul 2023 01:58:47 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEdM-001RhX-H5; Fri, 14 Jul 2023 18:58:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:58:33 +1000
Date:   Fri, 14 Jul 2023 18:58:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] hwrng: pic32 - some simple cleanups
Message-ID: <ZLEOOUChJD0rr25A@gondor.apana.org.au>
References: <20230704173203.70706-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704173203.70706-1-martin@kaiser.cx>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:31:59PM +0200, Martin Kaiser wrote:
> Here's a series with simple clenaups to the pic32 driver. The patches were
> compile tested only.
> 
> Martin Kaiser (4):
>   hwrng: pic32 - enable compile-testing
>   hwrng: pic32 - use devm_clk_get_enabled
>   hwrng: pic32 - remove unused defines
>   hwrng: pic32 - enable TRNG only while it's used
> 
>  drivers/char/hw_random/Kconfig     |  2 +-
>  drivers/char/hw_random/pic32-rng.c | 71 +++++++++++-------------------
>  2 files changed, 27 insertions(+), 46 deletions(-)
> 
> -- 
> 2.30.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
