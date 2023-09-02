Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8479096E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjIBUF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjIBUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:05:27 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3849DCE;
        Sat,  2 Sep 2023 13:05:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="178512759"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 05:05:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A6825406C22F;
        Sun,  3 Sep 2023 05:05:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] Match data improvements for bq2515x driver
Date:   Sat,  2 Sep 2023 21:05:16 +0100
Message-Id: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
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

This patch series aims to add match data improvements for bq2515x driver.

This patch series is only compile tested.

Biju Das (2):
  power: supply: bq2515x: Simpilfy bq2515x_read_properties() and probe()
  power: supply: bq2515x: Some cleanups

 drivers/power/supply/bq2515x_charger.c | 65 ++++++++++++--------------
 1 file changed, 31 insertions(+), 34 deletions(-)

-- 
2.25.1

