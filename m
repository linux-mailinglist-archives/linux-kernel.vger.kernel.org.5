Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384027B44BF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjJAAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjJAAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:00:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7210DD;
        Sat, 30 Sep 2023 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FHz62bZmLGVfdFXgVnp174SibFAS68vm8vO+h0fNe1Q=; b=LXXhgajBN3x3gDJJPX0IuQ3eMS
        PBhtHbdoQuagvGQfDiUt8EvjAE4z5PSoiGQuby3gpVhFA5HFA1IN4xN10KBJl/LBhScQWylZDaj24
        7dcFEsliW7B4tQuEsu7pAm1lpSB9+5I0VvnDdGBpcePi0fjC8ywedJx4h9gtxs7mbDm7xKIf4Usd2
        lTBVSdOvaBS+3g3UKtx9v93lljhF/nbnxnK9lGjEFXZjvE6fNGWl6ce/0UAdrHTi9PspGAVy9A9NV
        6Sfj/ncr8Wj8mIluVtsCCVmoTwrdVhH/cFWS9ufyLGkcgl9TRhA65EYlhRQJbvtedh1p1x1Ch8Dt5
        lJw+Yqzw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmjt7-00AFNK-1v;
        Sun, 01 Oct 2023 00:00:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: sig - fix kernel-doc typo
Date:   Sat, 30 Sep 2023 17:00:44 -0700
Message-ID: <20231001000044.26680-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001000044.26680-1-rdunlap@infradead.org>
References: <20231001000044.26680-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo of "destination".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 include/crypto/sig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/crypto/sig.h b/include/crypto/sig.h
--- a/include/crypto/sig.h
+++ b/include/crypto/sig.h
@@ -79,7 +79,7 @@ int crypto_sig_maxsize(struct crypto_sig
  * @tfm:	signature tfm handle allocated with crypto_alloc_sig()
  * @src:	source buffer
  * @slen:	source length
- * @dst:	destinatino obuffer
+ * @dst:	destination obuffer
  * @dlen:	destination length
  *
  * Return: zero on success; error code in case of error
