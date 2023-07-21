Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517C75D67A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGUVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGUVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:24:43 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6130D0;
        Fri, 21 Jul 2023 14:24:42 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJ1s2Y031028;
        Fri, 21 Jul 2023 21:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=3qFbs7ny735Se8n+zekA1xfETEDp1cFK+SaOIyzWAhg=;
 b=Bkb1a2zCHDwf/8Exym+IiFrKI87IrgZAEuW7hE4+2qRcwQOrj2wG6YMBxaTW7hrqihLr
 2ZB6wcWkdqhMfDDrE758r8lKXq0ZhdlLKX9xhwg0bYBlv6cXcQkRxOh4+MfyuCQWCpFN
 WLGkS3e4DuyHnqh3nnoY5zjoQr6iO6/JefPzWBLyv7lj4xao2XcchcOecBQwmG2D2RKJ
 YSsC/5DUyKBuu3oF5+oaZZbxSm4Cv8qNudxH4aKAHNL+DI+c08KUizSnFjeFnvxYxecD
 YGMGIIGhYh1W9ocorfQuxHrTu3AsooZ1H+RhQqLpdq3qGVeOF84YZvCty6Z3CChuTyRC GQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ryacpbwwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 21:24:30 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E604AD2D2;
        Fri, 21 Jul 2023 21:24:29 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 41FEA809FDC;
        Fri, 21 Jul 2023 21:24:29 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] MAINTAINERS: HPE: Add GXP UMAC Networking Files
Date:   Fri, 21 Jul 2023 16:20:44 -0500
Message-Id: <20230721212044.59666-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721212044.59666-1-nick.hawkins@hpe.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: OcWqRi7nCqDrzVPQvsG7gQUKHY1vudSp
X-Proofpoint-GUID: OcWqRi7nCqDrzVPQvsG7gQUKHY1vudSp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=932
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

List the files added for supporting the UMAC networking on GXP.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..4f1c3fa27f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2243,6 +2243,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
+F:	Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
+F:	Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
@@ -2252,6 +2254,7 @@ F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
+F:	drivers/net/ethernet/hpe/
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
-- 
2.17.1

