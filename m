Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3D813354
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573506AbjLNOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573497AbjLNOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:38:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB71E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702564690; x=1734100690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EyYI5DjgmZRm0fcSKAJZqA6XTmvNC5JdiHvvlpRhMl8=;
  b=GsRzg7QtwHjSGoirxDpfnPJ89sGuwPjNuHJatM354hMQSaElX//U9eyL
   djPWHG0gR3ZAkR0hL55/u1fdZQUZOYZ6SSF1Oo2lG4uXsQbFx6U0TRCQv
   nYcdZrYGF9hmBje56ClSoWUu1XkS7rjapeT+AVG/7TAq8ovXAMI2BKwHD
   fEAK7BWWjHOFB0SltUzZkncLi3l2f/crgkIMwRDbPVTwR194xyfJ5FiC5
   +uAufX955NjHZsBOnzUKywL794DnrMtey/GCDdO6XEX7J1CzSDIMKRdk/
   tlgCXNpge/VEev0yqsFckjUGRwtXptSOnldhg0d3LFWHk0qpCGnMpwNwj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="13821102"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="13821102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021524564"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021524564"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:38:06 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: pxp: spdx should be at first line
Date:   Thu, 14 Dec 2023 16:37:52 +0200
Message-ID: <20231214143752.294008-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Remove stray empty line at the beginning of the file
to have SPDX header t the first line.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
index 4029b96afc040803de6fc509..4f1ed9202cd9c96d8ee26bdc 100644
--- a/drivers/misc/mei/pxp/Kconfig
+++ b/drivers/misc/mei/pxp/Kconfig
@@ -1,4 +1,3 @@
-
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2020, Intel Corporation. All rights reserved.
 #
-- 
2.43.0

