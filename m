Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10BA75D8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGVCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGVCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:16:00 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80530EF;
        Fri, 21 Jul 2023 19:15:59 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qN29w-002D8R-SS; Sat, 22 Jul 2023 12:15:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 22 Jul 2023 14:15:46 +1200
Date:   Sat, 22 Jul 2023 14:15:46 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        liulongfang@huawei.com
Subject: Re: [PATCH 0/4] crypto: hisilicon - misc fixes
Message-ID: <ZLs70nA54ajdrZPY@gondor.apana.org.au>
References: <20230714114138.1582-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714114138.1582-1-qianweili@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 07:41:34PM +0800, Weili Qian wrote:
> This patchset fixes some issues in qm.c and enables hpre device
> sva error reporting for possible error debugging.
> 
> Weili Qian (4):
>   crypto: hisilicon/qm - flush all work before driver removed
>   crypto: hisilicon/qm - stop function and write data to memory
>   crypto: hisilicon/qm - increase device doorbell timeout
>   crypto: hisilicon/hpre - enable sva error interrupt event
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  5 +++-
>  drivers/crypto/hisilicon/qm.c             | 28 ++++++++++++++++++-----
>  include/linux/hisi_acc_qm.h               |  2 +-
>  3 files changed, 27 insertions(+), 8 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
