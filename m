Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687CD7C8349
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjJMKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJMKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:38:55 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9609BE;
        Fri, 13 Oct 2023 03:38:52 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFYs-006jd6-FA; Fri, 13 Oct 2023 18:38:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:38:35 +0800
Date:   Fri, 13 Oct 2023 18:38:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
Message-ID: <ZSkeK2bbjbRljkaB@gondor.apana.org.au>
References: <20231006213917.333702-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:39:17PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
