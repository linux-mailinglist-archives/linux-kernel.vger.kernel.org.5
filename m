Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34E8800B74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378936AbjLANKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378918AbjLANKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:10:51 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F210D;
        Fri,  1 Dec 2023 05:10:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8A121C0005;
        Fri,  1 Dec 2023 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701436256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mxbx8bOBklNdOGLUAlIxTWUDi4Ba9Vi/ktOs2rs75As=;
        b=hTN9WIz9/0OL1bdEP99mrePvJ/D8037U3rLOAJVt0UbPVs6GJCGxyx9ENLyvXVf1dEAdsM
        siGaxUBZRGspp4bAOYh9UnIXHqDNy3dArh1XnZ/3Fu8zTspAxC/uP1KulE8i1YLYkKn9aF
        1TeDr0o3KCFT4TENsu1le2XcnKpeS8ANLh4MyGkcaO46tMS7APlCsytyWEz3NBJLkjNgLf
        dVEk6RwRxc59FxOUt4s3XE1n8rvEsne79EEegg2UuyarLHpoSkcXLaQCQbDNoqFQma/MMV
        GGhX0PE3CXLxB3y6/QQgdrBGMY/I3BdKItc0+ASVhG70iLBEBSOdu5hqzr9sZg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] docs: nvmem: minor improvements
Date:   Fri, 01 Dec 2023 14:10:41 +0100
Message-Id: <20231201-nvmem-docs-kerneldoc-v1-0-3e8f2b706ce6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHbaWUC/x2MQQ5AMBQFryJ/7SfakuAqYkG98oOSNhGJuLvGb
 mYx81BEEERqs4cCLoly+CQqz8gug5/BMiUnXWijdKHYXzt2ng4beUXw2BKyHVG7Ziir0hpK6Rn
 g5P63Xf++HyrBg2FmAAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two small improvements to the NVMEM subsystem
documentation.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      docs: nvmem: generate kernel-doc API documentation
      docs: nvmem: remove function parameters (fixes hyperlink generation)

 Documentation/driver-api/nvmem.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 8608dc8b55496087e82db3c955289b71a22735c6
change-id: 20231201-nvmem-docs-kerneldoc-cbe8f9a454c3

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

