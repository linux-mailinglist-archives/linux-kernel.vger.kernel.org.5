Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3C7F4DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjKVRFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:05:22 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 833C3197;
        Wed, 22 Nov 2023 09:05:15 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 37D75E0EB6;
        Wed, 22 Nov 2023 20:05:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=PaQ8UrY
        qoUK/m1kbaJ2p3IjQEyIB74QQMBgVZJwX1Jo=; b=QZbubmNnJ/JWWkDxD0DId1m
        G5uv4grvSYMYvuF37B9zNkGKbNmBWrInKwDoT1Lq24tq578FQiUstj/OWdwgm02U
        Ei4trnz5pVKMb8mm2VIf2YWWTSwUoslbnPM64LbQo01wBlDH+ntuiXrZ1oNVc8FR
        xHaHJgHkVbrpnsyUv2T8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id F28E6E0EB4;
        Wed, 22 Nov 2023 20:05:12 +0300 (MSK)
Received: from localhost (10.8.30.118) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 20:05:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MAINTAINERS: Add MIPS Baikal-T1 SoC bits maintainer
Date:   Wed, 22 Nov 2023 20:04:49 +0300
Message-ID: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.118]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the last few years several Baikal-T1 platform-specific drivers have
been merged into the kernel repo. I should have added them to the
MAINTAINERS list in the first place, but didn't do that postponing for the
final series with the arch-specific patches. Sooner than later that will
be done (after I finally finish working on the EDAC and network drivers),
but until then let's add the already merged in drivers maintainer to the
list in order to not have them looking abandoned, especially seeing such
concern has already been raised here:

Link: https://lore.kernel.org/lkml/20231122054142.31322-1-lukas.bulwahn@gmail.com/

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon driver
  MAINTAINERS: Add maintainer for Baikal-T1 PCIe driver
  MAINTAINERS: Add maintainer for MIPS Baikal-T1 platform code

 MAINTAINERS | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.42.1


