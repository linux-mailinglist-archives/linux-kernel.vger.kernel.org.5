Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C77B44BD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjJAAAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjJAAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:00:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B17D3;
        Sat, 30 Sep 2023 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zHKNQBD4HfXptN+HoK19706SzP8TcfFl8M1EmRCT3vU=; b=aomI3NV3QMZDzNfeXmEa7vnIpO
        A/YSsjxGaXJ+qlDbdrQNvGVidWrnoAzYAvzL4EPzaOs3bX7RpPC23rRPGPZ+Yfb6YCaqKGec9kA8D
        cfaQUoguCkw98+yr6dwX9zqMzG6hrZHpGIHnZzinuAIgdAzye7nYDSWOulhIJrWMKaJ2HnFdJHW+x
        Bdds9XYfO9r8wx00wIkTrR7zbbKmzcibGZsTfET36efbb1jAnf9I8kd49PjSRuZy8QZ4zGbQUeiwB
        b5hfotDlb7zsM8G72b++B+YLh0j1LUF66RoyxUz57uFgMaXernE5nfZCD6Zpn1WbqSDir7K7NoSRG
        aS12BB9A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmjt7-00AFNK-18;
        Sun, 01 Oct 2023 00:00:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: akcipher - fix kernel-doc typos
Date:   Sat, 30 Sep 2023 17:00:43 -0700
Message-ID: <20231001000044.26680-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

Correct typos of "destination".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 include/crypto/akcipher.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/crypto/akcipher.h b/include/crypto/akcipher.h
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -382,7 +382,7 @@ static inline int crypto_akcipher_decryp
  * @tfm:	AKCIPHER tfm handle allocated with crypto_alloc_akcipher()
  * @src:	source buffer
  * @slen:	source length
- * @dst:	destinatino obuffer
+ * @dst:	destination obuffer
  * @dlen:	destination length
  *
  * Return: zero on success; error code in case of error
@@ -400,7 +400,7 @@ int crypto_akcipher_sync_encrypt(struct
  * @tfm:	AKCIPHER tfm handle allocated with crypto_alloc_akcipher()
  * @src:	source buffer
  * @slen:	source length
- * @dst:	destinatino obuffer
+ * @dst:	destination obuffer
  * @dlen:	destination length
  *
  * Return: Output length on success; error code in case of error
