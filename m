Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85967C6303
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbjJLCsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjJLCsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C024A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uU2CuKrPRByE9KpH6bAEiqxhIA+w3138Fn9uwRBzp7s=; b=RWjnwWXRpROxrVO9+72W5bH3eC
        aDsnN79eXFSBGLnx3xox9D+xdaq+ns/u0oGil5ow7ng4KRoTjxywGa4GI+BRcW+lkjTubvVFu9iVe
        4ffOgX/drmIR9AsRMGDkmbJBZ7Qhg6mS6/Zn75iMUJDnGQw6SGZP5a6clclpNiUnouKi6BFjpsiBP
        6Tn4EjOL2yiXXm+nwP6634Lo4tq00BRuPIy0qBfflNTyNiNFtjvAuecYhTeiHrQATohZOshdHyr9I
        /QqlAOfUNBfNB+9DH2xaVUP+Azn6DZh9hyulc8SHRot9ngGMmBqj8ZNjvfdX5Ztv+Tqn8Ul6P5TaZ
        cLdnF9Zw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkl-00HDiv-2X;
        Thu, 12 Oct 2023 02:48:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/7] misc: mei: fix all kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:38 -0700
Message-ID: <20231012024845.29169-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all remaining kernel-doc warnings in drivers/misc/mei/.

This series should be applied after Tomas's 3-patch series
for char-misc-mei docs fixes.


 [PATCH 1/7] misc: mei: hw.h: fix kernel-doc warnings
 [PATCH 2/7] misc: mei: client.c: fix kernel-doc warnings
 [PATCH 3/7] misc: mei: dma-ring.c: fix kernel-doc warnings
 [PATCH 4/7] misc: mei: hbm.c: fix kernel-doc warnings
 [PATCH 5/7] misc: mei: hw-me.c: fix kernel-doc warnings
 [PATCH 6/7] misc: mei: interrupt.c: fix kernel-doc warnings
 [PATCH 7/7] misc: mei: main.c: fix kernel-doc warnings

 drivers/misc/mei/client.c    |   20 ++++++++++----------
 drivers/misc/mei/dma-ring.c  |    4 ++++
 drivers/misc/mei/hbm.c       |    2 ++
 drivers/misc/mei/hw-me.c     |   16 ++++++++--------
 drivers/misc/mei/hw.h        |    8 ++++----
 drivers/misc/mei/interrupt.c |    4 ++--
 drivers/misc/mei/main.c      |    8 ++++----
 7 files changed, 34 insertions(+), 28 deletions(-)


Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
