Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0617E7BF688
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjJJIxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJJIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:53:49 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43EA7;
        Tue, 10 Oct 2023 01:53:46 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qq8UL-005THy-LE; Tue, 10 Oct 2023 16:53:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Oct 2023 16:53:18 +0800
Date:   Tue, 10 Oct 2023 16:53:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Andres Salomon <dilinger@queued.net>,
        Olivia Mackall <olivia@selenic.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Timur I . Davletshin" <timur.davletshin@gmail.com>,
        Jo-Philipp Wich <jo@mein.io>, linux-geode@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: geode: fix accessing registers
Message-ID: <ZSUQ/qB2d1si0b5q@gondor.apana.org.au>
References: <20230910083418.8990-1-jonas.gorski@gmail.com>
 <ZQQ2Cv1uL/YVxNBb@gondor.apana.org.au>
 <CAOiHx=nCfU22yd9-KommKMEnKq+VpQROOfKwyb9kbRWzY3azhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=nCfU22yd9-KommKMEnKq+VpQROOfKwyb9kbRWzY3azhg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:34:04PM +0200, Jonas Gorski wrote:
>
> Where was it applied? I don't see it neither in linus' tree nor in
> char-misc. Wondering if it got stuck somewhere.

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=464bd8ec2f06707f3773676a1bd2c64832a3c805

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
