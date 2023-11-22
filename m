Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12757F4DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjKVRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjKVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:05:22 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B77C19E;
        Wed, 22 Nov 2023 09:05:15 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7CBE3E0EBA;
        Wed, 22 Nov 2023 20:05:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xw3nPuMf6iDNRvKrBh2RHnMk81mNTUgNUkHajKp5iEY=; b=bo49231QwqBS
        PWqOeFS9dWnvyZLg/GaJSFUPEzKuFZop15yx/4DISgeM4vtT15i1/UVxj15Cii4e
        gw4rkE+E0ui9Ec9lrhK2lpxVSgexXGmEsrS7elHQo9MM8qvvKIJOhtcQSDj8dXOu
        /6SN9nsM5pZB6aacvM3uXXkiHK4jAQA=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 5DA79E0EB4;
        Wed, 22 Nov 2023 20:05:14 +0300 (MSK)
Received: from localhost (10.8.30.118) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 20:05:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] MAINTAINERS: Add maintainer for Baikal-T1 PCIe driver
Date:   Wed, 22 Nov 2023 20:04:51 +0300
Message-ID: <20231122170506.27267-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
References: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
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

Add myself as a maintainer of the Baikal-T1 PCIe Root Port driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e50a77d746e..52ee905c50f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16796,6 +16796,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
 F:	drivers/pci/controller/dwc/*artpec*
 
+PCIE DRIVER FOR BAIKAL-T1
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-bt1.c
+
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	Robert Richter <rric@kernel.org>
 L:	linux-pci@vger.kernel.org
-- 
2.42.1


