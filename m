Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7A800800
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378155AbjLAKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378201AbjLAKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:13:17 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D310D;
        Fri,  1 Dec 2023 02:13:23 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r90WN-005hnB-0B; Fri, 01 Dec 2023 18:13:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 18:13:28 +0800
Date:   Fri, 1 Dec 2023 18:13:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chenghai Huang <huangchenghai2@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, shenyang39@huawei.com
Subject: Re: [PATCH v2] crypto: hisilicon/zip - add zip comp high perf mode
 configuration
Message-ID: <ZWmxyFV1fILeQ3q0@gondor.apana.org.au>
References: <20231124054924.3964946-1-huangchenghai2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124054924.3964946-1-huangchenghai2@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 01:49:24PM +0800, Chenghai Huang wrote:
> To meet specific application scenarios, the function of switching between
> the high performance mode and the high compression mode is added.
> 
> Use the perf_mode=0/1 configuration to set the compression high perf mode,
> 0(default, high compression mode), 1(high performance mode). These two
> modes only apply to the compression direction and are compatible with
> software algorithm in both directions.
> 
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 65 +++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
