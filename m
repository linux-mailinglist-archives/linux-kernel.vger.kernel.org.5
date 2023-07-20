Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4E75A6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGTGuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGTGub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:50:31 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59A110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:50:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63Gp75bkzBRDsL
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:50:26 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689835826; x=1692427827; bh=m7t6VBOg0a6PmL53dyQAsiPFbge
        YX8YCTKnEw5pkn3s=; b=0/39ZhiuOJeklxmPcilIbpQoSHBf8b8RkbKXmzXYJIV
        OsZP4xRumEfuoffeX4aTgyoeOuWaq+SHCk+mRC8g8ZCEzszfcE/D94DVzVBmC/bK
        6Vnv1KVlAyEYJOJlVQmvZlkve/tQcv+LKW/rb7WIrBxgHk42mhwHoHfyW5mpkmT3
        Gbl/zTMsEL+4RC95BLESZInDfzM510+IsndTux6f06FPGydOFDDlMDFxUFvrszGr
        XTY/DiWLsUxJBNwokwB7ggdXau69tQtoi4fYLp82qKby07AAFTDidW8qnRFktNJC
        kAjPdJbKM4Nrhn8fJY+KjeWj6KS/XvfIRkHX5sVviSA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iuNz6mJG6c04 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:50:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63Gp2rTPzBRDsD;
        Thu, 20 Jul 2023 14:50:26 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:50:26 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: that open brace { should be on the previous
 line
In-Reply-To: <20230720064910.2747-1-xujianghui@cdjrlc.com>
References: <20230720064910.2747-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e78682698a5190fede3bfe734c0c66a8@208suo.com>
X-Sender: sunran001@208suo.com
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic79xx_core.c  | 6 ++----
  1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c 
b/drivers/scsi/aic7xxx/aic79xx_core.c
index 3e3100dbfda3..f2e0094768ba 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -45,8 +45,7 @@
  #include "aicasm/aicasm_insformat.h"

  /***************************** Lookup Tables 
**********************************/
-static const char *const ahd_chip_names[] =
-{
+static const char *const ahd_chip_names[] = {
  	"NONE",
  	"aic7901",
  	"aic7902",
@@ -71,8 +70,7 @@ static const struct ahd_hard_error_entry 
ahd_hard_errors[] = {
  };
  static const u_int num_errors = ARRAY_SIZE(ahd_hard_errors);

-static const struct ahd_phase_table_entry ahd_phase_table[] =
-{
+static const struct ahd_phase_table_entry ahd_phase_table[] = {
  	{ P_DATAOUT,	NOP,			"in Data-out phase"	},
  	{ P_DATAIN,	INITIATOR_ERROR,	"in Data-in phase"	},
  	{ P_DATAOUT_DT,	NOP,			"in DT Data-out phase"	},
