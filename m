Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6D799EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbjIJPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIJPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:00:45 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 889091B5;
        Sun, 10 Sep 2023 08:00:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="179304420"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 00:00:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5A7D040065C0;
        Mon, 11 Sep 2023 00:00:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] Match data improvements for ov7670 driver
Date:   Sun, 10 Sep 2023 16:00:31 +0100
Message-Id: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add match data improvements for ov7670
driver.

This patch is only compile tested.

Biju Das (2):
  media: i2c: ov7670: Extend match support for OF tables
  media: i2c: ov7670: Drop CONFIG_OF ifdeffery

 drivers/media/i2c/ov7670.c | 52 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

-- 
2.25.1

