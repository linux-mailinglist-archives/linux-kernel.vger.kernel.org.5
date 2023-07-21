Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158575C0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGUIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:03:36 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE12707
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:03:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6hrb49Z2zBRDtV
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:03:27 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689926607; x=1692518608; bh=GkxhRoU4LD0UbiYjK6HGvvKQPBq
        ZPW3z+Ap+IfGAFoE=; b=VtyyTGnecR7Dbl7KsQECiIQ0x9dWAPr5dHmz+DtRHIC
        rGe62Ma7WplghtajlK0VYUuDi24vfEDI3bWXyspW3PAK5JHB4Xbt2nW/WT5sPUmj
        y2Jga/rqHOQMsUSaVhQZWSovj76W46X1xrQ9tZ94EmIPK/SqcwOLRHud7Tc8PbLf
        kjIA6Zi4exTIRjKVU4TPnomo6RzmSCDT0mz1AECrgVfbhPmyOy/9NJ9Kta16Of1r
        LpxVVntt5814L6bVV9TGpDF4jseY+BvHm6nodgpVNXX9xCHnYqTbOQZJysCQrBG3
        XRzSb7YxxeH/Nw1oiFNNr/grR7JBRqJ0HCCzvAFbO9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0BG0eVfLFFpx for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:03:27 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6hrb23q4zBRDt0;
        Fri, 21 Jul 2023 16:03:27 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 16:03:27 +0800
From:   hanyu001@208suo.com
To:     linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: nwfpe: add require space after that ','
In-Reply-To: <tencent_4488AA292A6FC649887668C96A0DCF050509@qq.com>
References: <tencent_4488AA292A6FC649887668C96A0DCF050509@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <5c05ddf2c6e0e1a8ba90fadf0d3fd957@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch errors:

./arch/arm/nwfpe/double_cpdo.c:56: ERROR: space required after that ',' 
(ctx:VxV)
./arch/arm/nwfpe/double_cpdo.c:61: ERROR: space required after that ',' 
(ctx:VxV)
./arch/arm/nwfpe/double_cpdo.c:75: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/arm/nwfpe/double_cpdo.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/nwfpe/double_cpdo.c b/arch/arm/nwfpe/double_cpdo.c
index 344bb7c46176..e8b56ab0262e 100644
--- a/arch/arm/nwfpe/double_cpdo.c
+++ b/arch/arm/nwfpe/double_cpdo.c
@@ -53,12 +53,12 @@ static float64 (*const dyadic_double[16])(struct 
roundingData*, float64 rFn, flo
      [FRD_CODE >> 20] = float64_rdv,
  };

-static float64 float64_mvf(struct roundingData *roundData,float64 rFm)
+static float64 float64_mvf(struct roundingData *roundData, float64 rFm)
  {
      return rFm;
  }

-static float64 float64_mnf(struct roundingData *roundData,float64 rFm)
+static float64 float64_mnf(struct roundingData *roundData, float64 rFm)
  {
      union float64_components u;

@@ -72,7 +72,7 @@ static float64 float64_mnf(struct roundingData 
*roundData,float64 rFm)
      return u.f64;
  }

-static float64 float64_abs(struct roundingData *roundData,float64 rFm)
+static float64 float64_abs(struct roundingData *roundData, float64 rFm)
  {
      union float64_components u;
