Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305075D8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGVCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGVCOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:14:11 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3733C03;
        Fri, 21 Jul 2023 19:14:08 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qN288-002D88-LV; Sat, 22 Jul 2023 12:14:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 22 Jul 2023 14:13:53 +1200
Date:   Sat, 22 Jul 2023 14:13:53 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     olivier@sobrie.be, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hwrng: ba431 - trivial cleanups
Message-ID: <ZLs7YZ+b+BwiEeSe@gondor.apana.org.au>
References: <20230713070446.230978-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713070446.230978-1-martin@kaiser.cx>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:04:43AM +0200, Martin Kaiser wrote:
> Here's three trivial clenaups of the ba431 driver. Compile-tested only.
> 
> Martin Kaiser (3):
>   hwrng: ba431 - do not set drvdata
>   hwrng: ba431 - don't init of_device_id's data
>   hwrng: ba431 - use dev_err_probe after failed registration
> 
>  drivers/char/hw_random/ba431-rng.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> -- 
> 2.30.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
