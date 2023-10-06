Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDC7BBCA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjJFQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJFQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:25:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0489E;
        Fri,  6 Oct 2023 09:25:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07F6BC0004;
        Fri,  6 Oct 2023 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696609537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ps0pP6rt1cilm//gVLKjHe8N6qXcS6F9ov3FyXWvio=;
        b=AhhfA7dqKqkz/gMARCrcPNH4YI8FC3vnCEHIt7WW2TwJpNdZVtvzgeg3DOPDcN3XDWIS4W
        uZdhQp8bwiL6Tl+/r2JeIMY2hcG89RR4ZdkFO8x0x+N5+bsdL0m58944LHypCkALX8nidM
        U5tffBgmiZ2kowDSCpDPpKFkgtQgw/Xci43+Y1wFFOkQquYZqNN/RUeJle1oFbTMisvG0H
        PnOjireQl5QsUhWCXjrYb6n6rHYScmYlot3HnqlJY5x8AQzw+XthEwDP4i5y8JFZ91xb+e
        94uqOz+g1NK8d7fzG8XRwgNpBbH6K0PPoyRUqyX26+k1fYVPgaFt0AVnVzYTLg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: Add techwell vendor prefix
Date:   Fri,  6 Oct 2023 18:25:28 +0200
Message-ID: <944ce349236e007f5a4d4fad3ba48d75009644ca.1696608809.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696608809.git.mehdi.djait@bootlin.com>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Techwell, Inc.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
V5->V6:
- This commit had a "Acked-by: Rob Herring <robh@kernel.org>" Tag but
  decided not to collect it because the last Iteration was more than 2
  years ago

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..08b74f725142 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1357,6 +1357,8 @@ patternProperties:
     description: Technologic Systems
   "^techstar,.*":
     description: Shenzhen Techstar Electronics Co., Ltd.
+  "^techwell,.*":
+    description: Techwell, Inc.
   "^teejet,.*":
     description: TeeJet
   "^teltonika,.*":
-- 
2.41.0

