Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714CF7F42F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjKVJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbjKVJ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:56:49 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D4C3875;
        Wed, 22 Nov 2023 01:56:23 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r5jxv-002Ixv-TJ; Wed, 22 Nov 2023 17:56:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 Nov 2023 17:56:24 +0800
Date:   Wed, 22 Nov 2023 17:56:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chenghai Huang <huangchenghai2@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, shenyang39@huawei.com
Subject: Re: [PATCH fot-next] hisilicon/zip: Add ZIP comp high perf
 configuration
Message-ID: <ZV3QSHgP6DgE6NkX@gondor.apana.org.au>
References: <20231121134024.114476-1-huangchenghai2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121134024.114476-1-huangchenghai2@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:40:24PM +0800, Chenghai Huang wrote:
> To meet specific application scenarios, the function of switching between
> the high performance mode and the high compression mode is added.
> 
> Use the perf_mode=0/1 configuration to set the compression high-perf mode,
> 0(default, high compression mode), 1(high performance mode).
> 
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>

Is it still compatible with the software algorithm implementation
when in high performance mode, in both directions?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
