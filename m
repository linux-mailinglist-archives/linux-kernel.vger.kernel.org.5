Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62167760B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjHIN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjHIN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:28:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC81999;
        Wed,  9 Aug 2023 06:28:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id A493040009;
        Wed,  9 Aug 2023 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691587703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTGknezdyiZk9bMBK1nMMSA2F/Bkc0Kki250K3B4O9I=;
        b=UcrQcxA5z6Om3X0KL8cndimdBdYb9MM2H8GFYfp9FecjFn3GBOvVau58f4I2HTGSrxhKyP
        P6k/uByE6jBHt0at03n8KRvpa7xGlOGDUgqErKEN2L8qVMlj06a3AapcGNig7hDxVFkYvv
        QHXNgMx//gOJcJiooCqFJ1Llt6wAjpncVXI2J1SusUma4wEqNNef4bV+StQjP/aUsrT4c5
        OUBj8conZx8gSlV2gMsMKC8UqouV2f+OLinKxCaCF9zdjfVD8yVvPUF61vIh/8WI/Y37hX
        4ZDDFK/1+x1uIxLZFVvJT/fKrTM7lwUDHGlL2+EPCk1lK2VFb0bVu7JCp1or1w==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 08/28] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date:   Wed,  9 Aug 2023 15:27:35 +0200
Message-ID: <20230809132757.2470544-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809132757.2470544-1-herve.codina@bootlin.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After contributing the driver, add myself as the maintainer for the
Freescale QMC HDLC driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..14041d90f9c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8304,6 +8304,14 @@ F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
 F:	drivers/soc/fsl/qe/qmc.c
 F:	include/soc/fsl/qe/qmc.h
 
+FREESCALE QUICC ENGINE QMC HDLC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	netdev@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
+F:	drivers/net/wan/fsl_qmc_hdlc.c
+
 FREESCALE QUICC ENGINE TSA DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.41.0

