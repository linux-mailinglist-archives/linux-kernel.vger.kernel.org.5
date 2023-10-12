Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8067C6305
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjJLCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbjJLCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6AC0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6sy2vPKg2Ma8pUzKqIV8BjF+bvF2bXFYRLMo/bjz7+4=; b=cLzqD/ieDv7DNb5i0XJPJ3Icik
        59cGe9IL7J1Lk8mZ6JdpAD0JychgwrkPg/UW+iQT8BXSTsvkqcKRR+CkZa86wz7dWY33rkjKDmFjC
        776v+WO5eL7cW0ZIe4CpGupDyJN18+hTNTlint+q3OdwTxITp6oe6G31SpX1FWD2ardz3fYLiDp+i
        yhHuI93CRgnU+QxaiIiNWgGQM03zFdVenDhptPEVUxE7M01tc7botLsCMMbkfEEV2lSYzo+28ugUP
        paOawlrLJnszES5LCrkHruJ6d9gMF32bAd5wW8aePK5YIAbhmlw7c5V7R9xvd9P9fw4he1IKdhhlC
        OpMEm+6A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkn-00HDiv-07;
        Thu, 12 Oct 2023 02:48:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/7] misc: mei: interrupt.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:44 -0700
Message-ID: <20231012024845.29169-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012024845.29169-1-rdunlap@infradead.org>
References: <20231012024845.29169-1-rdunlap@infradead.org>
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

Fix kernel-doc warnings in interrupt.c:

interrupt.c:631: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/interrupt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -626,9 +626,9 @@ static void mei_connect_timeout(struct m
 /**
  * mei_schedule_stall_timer - re-arm stall_timer work
  *
- * Schedule stall timer
- *
  * @dev: the device structure
+ *
+ * Schedule stall timer
  */
 void mei_schedule_stall_timer(struct mei_device *dev)
 {
