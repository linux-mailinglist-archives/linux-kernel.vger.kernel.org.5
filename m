Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001147C4C28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjJKHnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjJKHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:43:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0F92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697010194; x=1728546194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lWzOOyt28ry7ssgIabGacOOLls7MaeJvKT00FgND8/w=;
  b=IZMgOLELSlGR24jaKSMgMzj0lQND6p8d+GmjXfO4HvX4fopqjWtgxoK/
   jqEjyI+LB/EF5ETV7rKpNEEJnZnnoOXTg3WrKQwSbPUH8+qS6+Aq09z6q
   OuEjuLeU+PraWMgv0/Z2endXEwB3lpl3OZ88anZ60/tYxOkpC9fkprwKB
   e+tMstLdPir6dTqRvlarNyHg6iw75uHw9p/t02z3J6zqisnq5ldnaCgSF
   6u2bsffiDl6EdW6PgNWALCjeduDQy2A+iB7ne0bYjGWGYEfN6AYrdw3Wy
   zBJ7n9zfwtYoN1OY4sAbz30+8Q2wfBfNUhk4NspcFWlg2BkuZBg2V3LfG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363960723"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="363960723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703627082"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703627082"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:12 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/3] mei: documentation fixes
Date:   Wed, 11 Oct 2023 10:42:58 +0300
Message-ID: <20231011074301.223879-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling errors and kdoc issues.


Tomas Winkler (3):
  mei: docs: use correct structures name in kdoc
  mei: docs: add missing entries to kdoc in struct mei_cfg_idx
  mei: docs: fix spelling errors

 drivers/misc/mei/bus.c       | 4 ++--
 drivers/misc/mei/dma-ring.c  | 2 +-
 drivers/misc/mei/hbm.c       | 4 ++--
 drivers/misc/mei/hw-me.h     | 4 ++++
 drivers/misc/mei/hw.h        | 4 ++--
 drivers/misc/mei/interrupt.c | 2 +-
 drivers/misc/mei/mei_dev.h   | 4 ++--
 include/linux/mei_cl_bus.h   | 4 ++--
 8 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.41.0

