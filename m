Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6631F757867
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjGRJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGRJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:48:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1BE60
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:48:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4vK270RKzBR0gv
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:48:22 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689673702; x=1692265703; bh=JRGID7uu6hygn5FSR+Q5iVBRCD4
        Rz20jZdrXREQTkuE=; b=YFwp5mOWm+Utn5eV9/N7/NB9KDl6qZyUwFhG1BKthxS
        cleAg/Qta1pGDifDtgI9URraJRGDDULiUhkWGXnQyXY/xhjksTP4jm2iT2nv8teL
        /5UQYqFSYHH8+meA4z9Kw4Rq+eAN1rcd346bd2aYk3UANNZFFrdAyzRR6QrpKAsa
        WU9d/hEsdOi5Mgk5dcRsMP0rA1eQMzBZUO2rWWTqH5DFQVLduGmvy1o3TpfzWycq
        uxlyxa/2XvISQzRtnqfnQ7eXmO9zMEcmoxXNoZBU+MF0GAoCrX12XFXikoEADzHY
        pMoZjgMtpObw37RUWCBMTptew9SQLb6Hw2J1gtI3IQA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PW-z4RFN8L-M for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:48:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4vK25VYrzBJBfd;
        Tue, 18 Jul 2023 17:48:22 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:48:22 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: space required after that ','
In-Reply-To: <tencent_1D2A7704CC3721452CCE2B2E86EE04F5D90A@qq.com>
References: <tencent_1D2A7704CC3721452CCE2B2E86EE04F5D90A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a1b3139f2635446abf6f3c39306aa164@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

./drivers/ata/libata-transport.c:92: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:92: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:92: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:92: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:94: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:94: ERROR: space required after that 
',' (ctx:VxV)
./drivers/ata/libata-transport.c:94: ERROR: space required after that 
',' (ctx:VxV)

Signed-off-by: Yu Han <	hanyu001@208suo.com>
---
  drivers/ata/libata-transport.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-transport.c 
b/drivers/ata/libata-transport.c
index e4fb9d1..4e87f77 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -89,9 +89,9 @@ struct ata_internal {
  /*
   * Hack to allow attributes of the same name in different objects.
   */
-#define ATA_DEVICE_ATTR(_prefix,_name,_mode,_show,_store) \
+#define ATA_DEVICE_ATTR(_prefix, _name, _mode, _show, _store) \
      struct device_attribute device_attr_##_prefix##_##_name = \
-    __ATTR(_name,_mode,_show,_store)
+    __ATTR(_name, _mode, _show, _store)

  #define ata_bitfield_name_match(title, table)            \
  static ssize_t                            \
