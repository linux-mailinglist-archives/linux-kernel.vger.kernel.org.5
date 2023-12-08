Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D143980A9FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjLHREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjLHREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:04:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA610F8;
        Fri,  8 Dec 2023 09:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702055083; x=1733591083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XyNMLeHiHgz9zyJ+B2ye1DJ6XRbnBWA/BZKLjYEhKJo=;
  b=LSusbQW+tl+7RaVL+Vl26m991wP7Owlz26sDc018r7aLWYq64JC8kcw0
   6vNeysbRkoHL0CHOwX6EbeMtxqtPvcLFuWoPU1ELfBO1326K9RkwqMfTo
   dt1ano/ig/vnuqygR/FKmjdYSLlz1erU3yK0XKiGAzqkZey1oS2LqNGbi
   o97wcAJNNHiuoV/2oTPCDACvOSfpQNAFKE/1KBAzd6uOjfWzXzVuNi+tD
   PQZViwJ7G3B2lpdZCPv4/hqluAcQxa6IM0gMDHQET92XLTtn7kAQX6sCX
   A/0jXg0e1UkAzjBxHo3jZ+Af1vh7RURLlGf/Eo5hkS+hcbN3oMDhkelj2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1311102"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1311102"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838189001"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838189001"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2023 09:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 966E9154; Fri,  8 Dec 2023 19:04:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] spi: pxa2xx: Update documentation
Date:   Fri,  8 Dec 2023 19:02:53 +0200
Message-ID: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of documentation updates.

Since v1:
- spelled controller fully in patch 1
- fixed inconsistent indentation in patch 2

Andy Shevchenko (2):
  spi: pxa2xx: Use inclusive language
  spi: pxa2xx: Update DMA mapping and using logic in the documentation

 Documentation/spi/pxa2xx.rst | 59 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

