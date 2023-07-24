Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96875EDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGXIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGXIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:34:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E022A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:34:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8YPH66RXzBRx55
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:34:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690187683; x=1692779684; bh=xivezc9+8JHiL00mjjAuXmu9/dh
        6CnD4VSummcQwwCI=; b=oWaxq45Ozhy0XRIkwsph6ljsedBLPbXkY+NRRSkVFKn
        pGajiMAgayA4DV00tcw6V5clYeTsa3Ykd6DTbajnm1UDDxRRABwdk0D2ScUnVas5
        y5iFjuQcf0Xt3SUBardnqmDWZLfgpWg2EGGpmojPmBkeet8l1dJL7aoo6iY2tcr0
        DJsE8ofwcGrSIs+DcrsfSJ40ktsvCR55NPFblEg2PCRvsd8CDzTS6RDWNpwNBxxd
        RYOHO4qykFKSyEc/9Qo/inAvqSUvWBJ4/wuOSsysNznk9wkg/HDp/ZjAX5qugYcp
        SisL4sERndhJxlskaCvk3DCO2mIa6FibhYW+6kx896A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o-lx48Ygr152 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 16:34:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8YPH40vFzBR1P0;
        Mon, 24 Jul 2023 16:34:43 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 16:34:43 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in
 smu11_driver_if_sienna_cichlid.h
In-Reply-To: <20230724083344.9285-1-xujianghui@cdjrlc.com>
References: <20230724083344.9285-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <8e6eda082855e1b928253669fbb49316@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: trailing whitespace

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h 
b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
index c5e26d619bf0..8ec588248aac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
@@ -30,7 +30,7 @@

  #define ENABLE_DEBUG_FEATURES

-// Firmware features
+// Firmware features
  // Feature Control Defines
  #define FEATURE_CCLK_DPM_BIT                 0
  #define FEATURE_FAN_CONTROLLER_BIT           1
@@ -92,7 +92,7 @@
  #define FEATURE_ZSTATES_ECO_BIT             57
  #define FEATURE_CC6_BIT                     58
  #define FEATURE_DS_UMCCLK_BIT               59
-#define FEATURE_DS_HSPCLK_BIT               60
+#define FEATURE_DS_HSPCLK_BIT               60
  #define NUM_FEATURES                        61

  typedef struct {
