Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF387DDCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjKAHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKAHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:02:14 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E87F1;
        Wed,  1 Nov 2023 00:02:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="117623809"
X-IronPort-AV: E=Sophos;i="6.03,267,1694703600"; 
   d="scan'208";a="117623809"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:02:09 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A41A8D9D96;
        Wed,  1 Nov 2023 16:02:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D022BBF3C9;
        Wed,  1 Nov 2023 16:02:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 719042005A580;
        Wed,  1 Nov 2023 16:02:06 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id EE1DE1A006F;
        Wed,  1 Nov 2023 15:02:05 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] docs: dma: update a reference to a moved document
Date:   Wed,  1 Nov 2023 15:02:01 +0800
Message-ID: <20231101070201.4066998-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27970.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27970.005
X-TMASE-Result: 10--1.066700-10.000000
X-TMASE-MatchedRID: ZYjN+pfhQkov+0FNnM7lDQPZZctd3P4BTFQnI+epPIY7euEDuMsoQMdh
        SaRRgUR74vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8hxKpvEGAbTDlOOqvlWu7hBRff
        LhwHS2Cy48VhCF28/A38kIPkLTqPrpTHGEM7chrIYLz5HpooCcjgOiwv4ejp50Wgsb4Gbk5jY3T
        eaxK1jdFuMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/DMA-API.txt has moved to Documentation/core-api/dma-api.rst

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 Documentation/core-api/dma-api-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 72f6cdb6be1c..e8a55f9d61db 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -8,7 +8,7 @@ Dynamic DMA mapping Guide
 
 This is a guide to device driver writers on how to use the DMA API
 with example pseudo-code.  For a concise description of the API, see
-DMA-API.txt.
+Documentation/core-api/dma-api.rst.
 
 CPU and DMA addresses
 =====================
-- 
2.41.0

