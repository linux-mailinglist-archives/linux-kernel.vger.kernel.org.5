Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD67AC3B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjIWQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIWQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:36:55 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC971D3;
        Sat, 23 Sep 2023 09:36:48 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="180728095"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2023 01:36:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED750401DDF3;
        Sun, 24 Sep 2023 01:36:44 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] Match data improvements for tvp541x driver
Date:   Sat, 23 Sep 2023 17:36:38 +0100
Message-Id: <20230923163641.31685-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add match data improvements for tvp541x driver.

This patch series is only compile tested.

v1->v2:
 * Added Rb tag from Jacopo for patch#1 and patch#2.
 * Adeed patch#3 for sorting header files.

Biju Das (3):
  media: tvp541x: Extend match support for OF tables
  media: tvp541x: Drop CONFIG_OF ifdeffery
  media: tvp541x: Sort header files

 drivers/media/i2c/tvp514x.c | 49 +++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

-- 
2.25.1

