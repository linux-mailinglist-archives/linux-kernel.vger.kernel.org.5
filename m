Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DD7D1C07
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjJUJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJUJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:23:18 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891DB0;
        Sat, 21 Oct 2023 02:23:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qu8CE-009Vaa-6K; Sat, 21 Oct 2023 17:23:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Oct 2023 17:23:07 +0800
Date:   Sat, 21 Oct 2023 17:23:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.6
Message-ID: <ZTOYe9lZvPxxFDm+@gondor.apana.org.au>
References: <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au>
 <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
 <ZOLcCC523FoBAyv0@gondor.apana.org.au>
 <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
 <ZQz3qxwwAjDaqi5V@gondor.apana.org.au>
 <ZSUPdPFo+M/rQhwo@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUPdPFo+M/rQhwo@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 152d0bcdf1efcb54a4fa20f694e9c7bbb6d06cbf:

  dm crypt: Fix reqsize in crypt_iv_eboiv_gen (2023-10-06 10:39:18 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p5 

for you to fetch changes up to b11950356c4b416d2e87941f3aa7a8bf089db72b:

  KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash (2023-10-18 12:27:10 +0800)

----------------------------------------------------------------
This push fixes a 6.5 regression in crypto/asymmetric_keys.
----------------------------------------------------------------

Herbert Xu (1):
      KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash

 crypto/asymmetric_keys/public_key.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
