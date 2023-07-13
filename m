Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61CC751C60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjGMI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjGMI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:57:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA7E42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:57:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1pQF1RGQzBRRLd
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:57:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689238629; x=1691830630; bh=dR6j+gBqoVao2Ec2QB7r39T54Al
        UJL1aVhxEKs6+n3s=; b=uLOj66Bz3tK7NzMvvqHfzVhzpBypogYNfwknCgLC1xY
        LCFrRdA+IG/GOBHQhr53nm0KxaxTxUPU0Jmd4EGqFm0wirljOL1dx8FUZIpusfuX
        Yp43Vb7ximBaBgTMSQcksaJ0OUIIZeUOUE+QGGUbTqT6eLmCydpuEvSM8o+Fq9fk
        FCDre+WMNAqv7qQoBCL155zEskSEtzI3RLdt4xcWzy46d2qkRAqsIhRTNtvUpA5o
        gwXkDQqSJVxWp0lSzuAg911NplZqK9SFO5wfPt6uiio/rZHvo20xFs6h1FmNtOuD
        zjv+HDDP/4ODggROz47OlAZzlch+sezh37sFVRvEG6w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KRxFbiC7Ejw3 for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 16:57:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1pQD6L0jzBRRLX;
        Thu, 13 Jul 2023 16:57:08 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 16:57:08 +0800
From:   hanyu001@208suo.com
To:     deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: math-emu: add missing spaces after ','
In-Reply-To: <tencent_3887A60455D8E277E0CC7B22CD2C0E2B7E0A@qq.com>
References: <tencent_3887A60455D8E277E0CC7B22CD2C0E2B7E0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <9f99a133d08a6a21648c7899501223bb@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error:

arch/parisc/math-emu/dfdiv.c:137: ERROR: space required after that ',' 
(ctx:VxV)
arch/parisc/math-emu/dfdiv.c:137: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  arch/parisc/math-emu/dfdiv.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/math-emu/dfdiv.c b/arch/parisc/math-emu/dfdiv.c
index 239150d..9cbf338 100644
--- a/arch/parisc/math-emu/dfdiv.c
+++ b/arch/parisc/math-emu/dfdiv.c
@@ -73,7 +73,7 @@
                    * return infinity
                    */
                  Dbl_setinfinity_exponentmantissa(resultp1,resultp2);
-                Dbl_copytoptr(resultp1,resultp2,dstptr);
+                Dbl_copytoptr(resultp1, resultp2, dstptr);
                  return(NOEXCEPTION);
              }
          }
