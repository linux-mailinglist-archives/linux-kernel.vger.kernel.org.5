Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90A752F32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjGNCL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjGNCLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:11:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF726BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:11:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2FN21XxGzBRSVZ
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:11:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689300706; x=1691892707; bh=qpbUutfhWSEGYJ0tZoBTgWWOCO2
        ajKc9xPlTE67rB2c=; b=ZlZAHih8w6Wg+xJrjQiRHgs8Wu6K55BH6BTT1wdBtyw
        eZeSA9EcbMpbwwPAEOP1eq1rfIZ9aTrpzwlhaATmbH/ByQ5j1jTpeEpNy6jv9XoK
        1UC0xXieDgD09MHjKo0Dbo7rQ9NLI/+NzS84SPwVQYrZWYhEtBS4OQWGcmij0cxl
        oG6NSnuL8+U6wi0/MbIUo+ppYx2usgcMOYQ8OknJ5jnr9veuHXu8N/TSgEah2H8L
        Rn8vuEWh0Vvk3MACNUHTT+W2gI4243b5RF9qitev6bXJIPVYJoqQF8eFRuM1UKmv
        BrH+KV8YvtJBV3S0FNNYDu+6i8pToKxbNlU1JnxEq3A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o5sk_qI-RZ7d for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 10:11:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2FN15gbHzBHXkF;
        Fri, 14 Jul 2023 10:11:45 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 10:11:45 +0800
From:   hanyu001@208suo.com
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH] drivers/edac: amd64_edac: Add space after ','
In-Reply-To: <tencent_542F76295685CA05E1D9B274D0CE0B21450A@qq.com>
References: <tencent_542F76295685CA05E1D9B274D0CE0B21450A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f26979e296237d188d4035e3eb6e9ea0@208suo.com>
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

Fix a warning from checkpatch.pl.

drivers/edac/amd64_edac.c:413: ERROR: space required after that ',' 
(ctx:VxV)
drivers/edac/amd64_edac.c:413: ERROR: space required after that ',' 
(ctx:VxV)
drivers/edac/amd64_edac.c:416: ERROR: space required after that ',' 
(ctx:VxV)
drivers/edac/amd64_edac.c:416: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/amd64_edac.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5d7c080..ddb9bf3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -410,10 +410,10 @@ static void get_cs_base_and_mask(struct amd64_pvt 
*pvt, int csrow, u8 dct,

          if (pvt->fam == 0x15)
              base_bits = mask_bits =
-                GENMASK_ULL(30,19) | GENMASK_ULL(13,5);
+                GENMASK_ULL(30, 19) | GENMASK_ULL(13, 5);
          else
              base_bits = mask_bits =
-                GENMASK_ULL(28,19) | GENMASK_ULL(13,5);
+                GENMASK_ULL(28, 19) | GENMASK_ULL(13, 5);
      }

      *base  = (csbase & base_bits) << addr_shift;
