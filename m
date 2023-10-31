Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6AA7DC489
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjJaChR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjJaChK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:37:10 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7AA118;
        Mon, 30 Oct 2023 19:37:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFmIuE_1698719821;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFmIuE_1698719821)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:37:02 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com
Cc:     jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de
Subject: [PATCH v3 0/2] Some fixes for idxd driver
Date:   Tue, 31 Oct 2023 10:36:58 +0800
Message-Id: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Hi Dave, Fenghua,
As we talked in v1 and v2, I add fixes tag in patch 0 and change some
descriptions in patch 1.
If there are no other issues, please queue it up.

Thanks,
Guanjun

Guanjun (2):
  dmaengine: idxd: Protect int_handle field in hw descriptor
  dmaengine: idxd: Fix incorrect descriptions for GRPCFG register

 drivers/dma/idxd/registers.h | 12 +++++++-----
 drivers/dma/idxd/submit.c    | 14 +++++++-------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.39.3

